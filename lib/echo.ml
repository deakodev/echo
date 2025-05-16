open Base

type color = Blue | Cyan | Green | Grey | Magenta | Red | White | Yellow
type attributes = { name : string; color : color }
type level = Trace | Info | Warn | Error | Fatal

let level_attributes = function
  | Trace -> { name = "TRACE"; color = Cyan }
  | Info -> { name = "INFO "; color = Green }
  | Warn -> { name = "WARN "; color = Yellow }
  | Error -> { name = "ERROR"; color = Red }
  | Fatal -> { name = "FATAL"; color = Magenta }

let color_to_string = function
  | Blue -> "\027[34m"
  | Cyan -> "\027[36m"
  | Green -> "\027[32m"
  | Grey -> "\027[90m"
  | Magenta -> "\027[35m"
  | Red -> "\027[31m"
  | Yellow -> "\027[33m"
  | White -> "\027[37m"

let color_reset = "\027[0m"

let prefix level =
  let open Unix in
  let { tm_hour; tm_min; tm_sec; _ } = gettimeofday () |> localtime in
  let time =
    Fmt.str "%s%02d:%02d:%02d%s " (color_to_string Grey) tm_hour tm_min tm_sec
      color_reset
  in
  let { name; color } = level_attributes level in
  let level = Fmt.str "%s%s%s " (color_to_string color) name color_reset in
  time ^ level

let log level fmt = Stdio.printf Caml.("%s" ^^ fmt ^^ "\n%!") (prefix level)
let trace fmt = log Trace fmt
let info fmt = log Info fmt
let warn fmt = log Warn fmt
let error fmt = log Error fmt
let fatal fmt = log Fatal fmt
