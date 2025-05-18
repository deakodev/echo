(** The type of output destinations for log messages. *)
type out_type =
  | Stdout           (* Write logs to standard output *)
  | Stderr           (* Write logs to standard error *)
  | File of string   (* Write logs to a file with the given filename + Stdout/Stderr *)

(** [set_out destination] sets the output destination for subsequent log messages.
    If not called, logging defaults to a system-defined output (e.g., stdout). *)
val set_out : out_type -> unit

(** [trace fmt ...] logs a TRACE-level message using a format string.
    Use for verbose or diagnostic output. *)
val trace : ('a, unit, string, unit) format4 -> 'a

(** [info fmt ...] logs an INFO-level message using a format string.
    Use for general information and progress updates. *)
val info : ('a, unit, string, unit) format4 -> 'a

(** [warn fmt ...] logs a WARN-level message using a format string.
    Use for potential issues that do not interrupt execution. *)
val warn : ('a, unit, string, unit) format4 -> 'a

(** [error fmt ...] logs an ERROR-level message using a format string.
    Use for recoverable errors or failures. *)
val error : ('a, unit, string, unit) format4 -> 'a

(** [fatal fmt ...] logs a FATAL-level message using a format string.
    Use for unrecoverable errors; may imply imminent shutdown. *)
val fatal : ('a, unit, string, unit) format4 -> 'a

(** [flush ()] forces any buffered log output to be written immediately.
    Useful if output is line-buffered or writing to a file. *)
val flush : unit -> unit
