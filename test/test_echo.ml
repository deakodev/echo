open Base
open Stdio

let read_log () = In_channel.read_all "test.log"
let log_contains expected log = String.is_substring ~substring:expected log

let check_log_contains ~msg expected =
  let log = read_log () in
  Alcotest.(check bool msg true (log_contains expected log))

let test_ocaml_logging () =
  Echo.set_out (File "test.log");
  Echo.trace "message";
  Echo.info "message";
  Echo.warn "message";
  Echo.error "message";
  Echo.fatal "message";

  check_log_contains ~msg:"Ocaml TRACE" "TRACE message";
  check_log_contains ~msg:"Ocaml INFO" "INFO  message";
  check_log_contains ~msg:"Ocaml WARN" "WARN  message";
  check_log_contains ~msg:"Ocaml ERROR" "ERROR message";
  check_log_contains ~msg:"Ocaml FATAL" "FATAL message"

let test_c_logging () =
  Echo.set_out (File "test.log");
  Dummie.dummie_c_fn ();

  check_log_contains ~msg:"C TRACE" "TRACE [C] message";
  check_log_contains ~msg:"C INFO" "INFO  [C] message";
  check_log_contains ~msg:"C WARN" "WARN  [C] message";
  check_log_contains ~msg:"C ERROR" "ERROR [C] message";
  check_log_contains ~msg:"C FATAL" "FATAL [C] message"

let () =
  Alcotest.(
    run "Echo tests"
      [
        ( "OCaml Logging",
          [ test_case "Echo.xxx from OCaml side" `Quick test_ocaml_logging ] );
        ("C Logging", [ test_case "echo_xxx from C side" `Quick test_c_logging ]);
      ])
