executable: functions.ml grapheur_parser.mly grapheur_lexer.mll grapheur.ml
	ocamllex grapheur_lexer.mll
	ocamlyacc grapheur_parser.mly
	ocamlc -c functions.ml
	ocamlc -c grapheur_parser.mli
	ocamlc -c grapheur_parser.ml
	ocamlc -c grapheur_lexer.ml
	ocamlc functions.cmo grapheur_lexer.cmo grapheur_parser.cmo grapheur.ml -o executable

clean:
	rm *.cmi
	rm *.cmo
	rm *.mli