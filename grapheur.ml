open Functions;;

(* main *)
let _ =
  if Array.length Sys.argv < 2
    then print_endline "Please, give a file name" else
  let input_file = Sys.argv.(1) in
  if not (Sys.file_exists input_file)
    then print_endline "This file does not exist" else
  let lexbuf = Lexing.from_channel (open_in input_file) in
  let f = Grapheur_parser.main Grapheur_lexer.token lexbuf in
  print_tree f 0;
  ;;