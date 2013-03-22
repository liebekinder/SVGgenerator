(* Un module est défini par un n-uplet
 - son nom : string
 - la liste de ses entrées : string list
 - la liste de ses sorties : string list
 - the list of disciplines *)

type t_module = {
  nom     : string; 
  entrees : string list;
  sorties : string list};;

type t_modules = string list * string list * t_module list;;

(*****************************)
(* Opérations sur les listes *)
(*****************************)

(* Ajoute un élément à la liste s'il n'y est pas déjà *)
let rec list_add e l = match (e,l) with
    (a,[]) -> [a]
  | (a,b) when a = (List.hd b) -> b
  | (a,hd::tl) -> hd::(list_add a tl);;

(* Efface la première occurrence de e dans l *)
let rec list_del e l = match (e,l) with
    (_,[]) -> []
  | (a,hd::tl) when a = hd -> tl
  | (a,hd::tl) -> hd::(list_del a tl);;

(* Efface toutes les occurrences de e dans l *)
let rec list_del_all e l = match (e,l) with
    (_,[]) -> []
  | (a,hd::tl) when a = hd -> list_del_all e tl
  | (a,hd::tl) -> hd::(list_del_all a tl);;

(* Renvoie l1 privée de tous les élements de l2 *)
let rec list_sub l1 l2 = match (l1,l2) with
    (a,[]) -> a
  | (a,hd::tl) -> list_sub (list_del hd a) tl;;

(* Ajoute les élémements de l1 à l2*)
let rec list_merge l1 l2 = match (l1,l2) with
    ([],a) -> a
  | (hd::tl,a) -> list_merge tl (list_add hd a);;

(*************************************)
(* Affichage des modules pour tester *)
(*************************************)

let rec string_of_list = function
    [] -> ""
  | hd::tl -> hd^" "^(string_of_list tl);;

let print_module m =
  print_endline (m.nom^" :");
  print_endline ("\t"^"Entrées : "^(string_of_list m.entrees));
  print_endline ("\t"^"Sorties : "^(string_of_list m.sorties));;

let print_modules (_,_,m) =
  List.iter print_module m;;
  
let print_modules2 m =
  List.iter print_module m;;

(***********************)
(* Affichage du graphe *)
(***********************)

let print_file file s = output file s 0 (String.length s);;

let rec createVarListParse m = match m with
    [] -> ([],[])
  | hd::tl ->  let temp = createVarListParse tl in (list_merge (fst(temp)) (hd.entrees),list_merge (snd(temp)) (hd.sorties));;

let rec print_list_format file liste = match liste with 
	[] -> ()
  | a::b -> (print_file file ("	"^a^" [shape=circle];\n")) ; print_list_format file b;;
  
let rec print_list_module_name file liste = match liste with 
	[] -> ()
  | a::b -> (print_file file ("	"^a.nom^" [shape=box];\n")) ; print_list_module_name file b;;
  
let rec print_arrete_for_one_module_entries file entrees mod_name = match entrees with 
	[] -> ()
  | a::b -> print_file file ("	"^a^" -> "^mod_name^"\n"); print_arrete_for_one_module_entries file b mod_name;;
  
let rec print_arrete_for_one_module_sorties file sorties mod_name = match sorties with 
	[] -> ()
  | a::b -> print_file file ("	"^mod_name^" -> "^a^"\n"); print_arrete_for_one_module_sorties file b mod_name;;
  
let rec print_arrete file liste = match liste with 
	[] -> ()
  | a::b -> print_arrete_for_one_module_entries file (a.entrees) (a.nom); print_arrete_for_one_module_sorties file (a.sorties) (a.nom); print_arrete file b;;

  
  
let generate_doc_file fichier entry_list sortie_list module_list = 
	print_file fichier "digraph G {\n";
		print_list_format fichier (list_merge entry_list sortie_list);
		print_list_module_name fichier module_list;
		print_arrete fichier module_list;
	print_file fichier "}\n";;
