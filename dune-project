(lang dune 3.18)

(name echo)

(version 0.0.7)

(generate_opam_files false)

(source
 (github deakodev/echo))

(authors "Zachary Deak <deakodev@outlook.com>")

(maintainers "Zachary Deak <deakodev@outlook.com>")

(license MIT)

(documentation https://github.com/deakodev/echo)

(package
 (name echo)
 (synopsis "A minimal interop OCaml + C logging solution")
 (description
  "Echo is a lightweight logging library for OCaml with C lib bindings, allowing both OCaml and C code to emit structured log messages through a unified logging interface.")
 (depends
  (ocaml
   (>= 4.14))
  base
  stdio
  (fmt
   (>= 0.8.10))
  (ctypes
   (>= 0.20.0))
  ctypes-foreign
  alcotest)
 (tags
  ("logging" "console")))
