open Foreign
open Ctypes
open Ctypes_static
include Echo_log

let trace fmt = log Trace fmt
let info fmt = log Info fmt
let warn fmt = log Warn fmt
let error fmt = log Error fmt
let fatal fmt = log Fatal fmt

(* OCaml callback functions *)
let echo_trace_cb fmt = trace "[C] %s" fmt
let echo_info_cb fmt = info "[C] %s" fmt
let echo_warn_cb fmt = warn "[C] %s" fmt
let echo_error_cb fmt = error "[C] %s" fmt
let echo_fatal_cb fmt = fatal "[C] %s" fmt

(* C side callback type *)
let echo_cb_type = funptr (string @-> returning void)
let register = foreign "echo_register" (int @-> echo_cb_type @-> returning void)

(* ensures that the C object file is actually linked into the final executable, 
even if none of its symbols are directly used from OCaml (eg. if the user just uses ocaml logging). 
Without this, the linker might discard the C object file, and the callbacks wouldn't be registered at runtime. *)
external force_link : unit -> unit = "_echo_force_link"

(* OCaml 5.3 (and earlier) may GC closures passed to C unless retained.
   These callbacks must be kept alive to avoid CallToExpiredClosure errors. *)
let _callbacks : (int * (string -> unit)) list =
  [
    (0, echo_trace_cb);
    (1, echo_info_cb);
    (2, echo_warn_cb);
    (3, echo_error_cb);
    (4, echo_fatal_cb);
  ]

let () =
  force_link ();
  List.iter (fun (lvl, cb) -> register lvl cb) _callbacks
