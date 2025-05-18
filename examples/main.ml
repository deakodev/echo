let main () =
  (* 1. [Optional] Set the output dest for log messages.
        If not set, defaults to stdout with no file. *)
  Echo.set_out (File "debug.log");

  (* 2. Emit log messages from OCaml using the Echo logging interface.
        These messages will be formatted, timestamped and written to specified output. *)
  Echo.trace "Checking sync state for %s (%d files) %0.2f" "documents/" 42 34.4;
  Echo.info "Starting sync from '%s' to '%s'" "/home/user/docs" "/backup/docs";

  (* 3. If using C lib bindings, echo will emit log messages via Echo's C API (see below).
        This demonstrates interop logging from C into a unified log system on the Ocaml side. *)
  Dummie.dummie_c_fn ();

  (* Other level examples *)
  Echo.warn "File '%s' is %d days old, skipping..." "notes_old.txt" 120;
  Echo.error "Failed to sync '%s': %s" "report.pdf" "Permission denied";
  Echo.fatal "Aborting sync: required path '%s' not found" "/mnt/backup"

let () = main ()

(* Echo's C API example 

    #include "echo.h"

    void dummie_c_fn() 
    {
        echo_trace("%s", "message"); eg. 11:54:15 TRACE [C] message
        echo_info("%s", "message");
        echo_warn("%s", "message");
        echo_error("%s", "message");
        echo_fatal("%s", "message");
    }
*)
