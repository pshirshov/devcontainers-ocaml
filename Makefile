# Makefile
build:
	ocamlbuild -use-ocamlfind tut.d.byte
clean:
	ocamlbuild -clean
.PHONY: build clean
