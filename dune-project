(lang dune 3.18)

(name echo)

(version 0.0.1)

(generate_opam_files true)

(source (github deakodev/echo))

(authors "Zachary Deak <deakodev@outlook.com>")

(maintainers "Zachary Deak <deakodev@outlook.com>")

(license MIT)

(documentation https://github.com/deakodev/echo)

(package
 (name echo)
 (synopsis 
  "A minimal interop OCaml + C logging solution")
 (description 
  "Echo is a lightweight logging library for OCaml with C lib bindings, allowing both OCaml and C code to emit structured log messages through a unified logging interface")
 (depends 
  "ocaml" "base" "stdio" "fmt" "ctypes" "ctypes-foreign" "alcotest")
 (tags
  ("logging" "console")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
