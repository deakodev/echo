open Foreign
open Ctypes
open Ctypes_static
include Echo_log

let trace fmt = log Trace fmt
let info fmt = log Info fmt
let warn fmt = log Warn fmt
let error fmt = log Error fmt
let fatal fmt = log Fatal fmt

(* OCaml callback functions*)
let echo_trace_cb fmt = trace "[C] %s" fmt
let echo_info_cb fmt = info "[C] %s" fmt
let echo_warn_cb fmt = warn "[C] %s" fmt
let echo_error_cb fmt = error "[C] %s" fmt
let echo_fatal_cb fmt = fatal "[C] %s" fmt

(* The type of the callback *)
let echo_cb_type = funptr (string @-> returning void)
let register = foreign "echo_register" (int @-> echo_cb_type @-> returning void)

external _force_link : unit -> unit = "_echo_force_link"

let () =
  _force_link ();
  register 0 echo_trace_cb;
  register 1 echo_info_cb;
  register 2 echo_warn_cb;
  register 3 echo_error_cb;
  register 4 echo_fatal_cb
