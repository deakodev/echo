(lang dune 3.18)

(name echo)

(generate_opam_files true)

(source
 (github deakodev/echo))

(authors "Zachary Deak <deakodev@outlook.com>")

(maintainers "Zachary Deak <deakodev@outlook.com>")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name echo)
 (synopsis "A bare-bones logging library for OCaml")
 (description "Echo is a lightweight logging library for OCaml that supports colorized, printf-style output with structured log levels.")
 (depends 
  "ocaml" "base" "stdio" "unix" "fmt")
 (tags
  ("logging" "console")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
