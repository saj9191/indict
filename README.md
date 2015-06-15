# To compile
#ocamlfind ocamlc -linkpkg -thread -package core main.ml -o main.byte

ocamlc -c language.mli
ocamlc -c javascript_language.mli
ocamlc -c indict.mli

ocamlfind ocamlc -linkpkg -thread -package core javascript_language.ml indict.ml main.ml

./a.out test.js
