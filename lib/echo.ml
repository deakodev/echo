open Foreign
open Ctypes
open Ctypes_static
include Echo_log

let trace fmt = log Trace fmt
let info fmt = log Info fmt
let warn fmt = log Warn fmt
let error fmt = log Error fmt
let fatal fmt = log Fatal fmt

(* The type of the callback *)
let cb_type = funptr (string @-> returning void)

(* Bind the registration function *)
let register = foreign "echo_register" (int @-> cb_type @-> returning void)

(* OCaml callback function *)
let my_trace_cb fmt = trace "%s" fmt
let () = register 0 my_trace_cb
