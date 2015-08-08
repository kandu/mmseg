PROJECT= mmseg

CC= gcc

lib: mmseg.cma mmseg.cmxa

mmseg.cma: mmseg.ml
	ocamlfind ocamlc -g -package core_kernel,trie,camomile -a -o $@ $^

mmseg.cmxa: mmseg.ml
	ocamlfind ocamlopt -g -package core_kernel,trie,camomile -a -o $@ $^

mmseg.ml: mmseg.cmi


mmseg.cmi: mmseg.mli
	ocamlfind ocamlc -package core_kernel,trie,camomile $<

build_doc/index.html: mmseg.mli
	mkdir -p build_doc
	ocamlfind ocamldoc -html -d build_doc mmseg.mli

.PHONY: install install-doc clean

install: lib
	ocamlfind install $(PROJECT) META *.mli *.cmi *.cma *.cmxa *.a

doc: build_doc/index.html

install-doc: build_doc/index.html
	mkdir -p $(DOCDIR)
	cp -r build_doc/* $(DOCDIR)

uninstall:
	ocamlfind remove $(PROJECT)

clean:
	rm -f *.annot *.o *.cm* *.a
	rm -rf build_doc

