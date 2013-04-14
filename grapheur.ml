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
  print_endline "--------------------------------------------------------";
  print_tree f 0;
  print_endline "--------------------------------------------------------";
  (*print_tree (remplace_elem f (Number(50)) (Number(42))) 0;*)
  let map = Hashtbl.create 42 in
  create_function_map f map;
  print_endline ("Nombre de fonctions : "^(string_of_int (Hashtbl.length map)));
  (*let print_tree_2 arg f = print_tree f 0 in
  Hashtbl.iter print_tree_2 map;*)
  let val_tbl : (string, all_types) Hashtbl.t= Hashtbl.create 42 in
	eval_val f val_tbl;
  print_endline ("Nombre de variables : "^(string_of_int (Hashtbl.length val_tbl)));
  let f_name = "dessine2" in 
  (*print_tree (Hashtbl.find map f_name) 0;*)
  let param_list = get_constructor (Hashtbl.find map f_name) in
  print_endline ("Nb params : "^(string_of_int (List.length param_list))^" de la fonction "^f_name);
  let print_value_2 (a,b) = print_value a;print_endline ("    "^b) in
  List.iter (print_value_2) param_list;
  print_endline "Appels aux fonctions";
  print_call f param_list;
  ;;
