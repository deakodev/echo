open Foreign
open Ctypes_static
include Echo_log

let trace fmt = log Trace fmt
let info fmt = log Info fmt
let warn fmt = log Warn fmt
let error fmt = log Error fmt
let fatal fmt = log Fatal fmt

(* The type of the callback *)
let cb_type = funptr (void @-> returning void)

(* Bind the registration function *)
let register = foreign "echo_register" (cb_type @-> returning void)

(* OCaml callback function *)
let my_trace_cb () = trace "[C] echo_trace called from renderer!"
let () = register (fun () -> my_trace_cb ())
