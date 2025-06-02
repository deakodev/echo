open Base
open Stdio

type out_type = Stdout | Stderr | File of string

let out_channel = ref Out_channel.stdout
let out_file = ref None

let set_out = function
  | Stdout -> out_channel := Out_channel.stdout
  | Stderr -> out_channel := Out_channel.stderr
  | File path -> out_file := Some (Out_channel.create path)

type color = Blue | Cyan | Green | Magenta | Red | White | Yellow
type attributes = { name : string; color : color }
type level = Trace | Info | Warn | Error | Fatal

let level_attributes = function
  | Trace -> { name = "TRACE"; color = Cyan }
  | Info -> { name = "INFO "; color = Green }
  | Warn -> { name = "WARN "; color = Yellow }
  | Error -> { name = "ERROR"; color = Red }
  | Fatal -> { name = "FATAL"; color = Magenta }

let ansi_reset = "\027[0m"
let ansi_dim = "\027[90m"

let level_colorize { name; color } =
  match color with
  | Blue -> "\027[34m" ^ name ^ ansi_reset
  | Cyan -> "\027[36m" ^ name ^ ansi_reset
  | Green -> "\027[32m" ^ name ^ ansi_reset
  | Magenta -> "\027[35m" ^ name ^ ansi_reset
  | Red -> "\027[31m" ^ name ^ ansi_reset
  | Yellow -> "\027[33m" ^ name ^ ansi_reset
  | White -> "\027[37m" ^ name ^ ansi_reset

let time () =
  let open Unix in
  let { tm_hour; tm_min; tm_sec; _ } = gettimeofday () |> localtime in
  Fmt.str "%02d:%02d:%02d " tm_hour tm_min tm_sec

let time_colorize time = Fmt.str "%s%s%s " ansi_dim time ansi_reset

let prefixes level =
  let time = time () in
  let attributes = level_attributes level in
  let plain = time ^ attributes.name ^ " " in
  let colored = attributes |> level_colorize |> Fmt.str "%s%s " time in
  (plain, colored)

let log level fmt =
  Printf.ksprintf
    (fun body ->
      let plain, colored = prefixes level in
      Out_channel.output_string !out_channel (colored ^ body ^ "\n");
      Out_channel.flush !out_channel;
      match !out_file with
      | Some ch ->
          Out_channel.output_string ch (plain ^ body ^ "\n");
          Out_channel.flush ch
      | None -> ())
    fmt
