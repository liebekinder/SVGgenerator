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

type operation =
    Drawing
  | Root
  | Function
  | Functions
  | DrawingSize
  | BlocEmbrace
  | Declaration
  | BlocBrace
  | BlocPar
  | Parameters
  | Parameter
  | ParametersUse
  | ParameterUse
  | FunctionUse
  | Point
  | Line
  | Instruction
  | Comma
  | Draw
  | Var of (string)
  | Number of (float);;
  
type t_arbreB = Empty | Node of node
        and node = { value: operation; left: t_arbreB; right: t_arbreB };;
    
let print_value v = match v with
  | Drawing -> print_endline "Drawing"
  | DrawingSize -> print_endline "DrawingSize"
  | Root -> print_endline "Root"
  | Function -> print_endline "Function"
  | Functions -> print_endline "Functions"
  | BlocEmbrace -> print_endline "BlocEmbrace"
  | BlocPar -> print_endline "BlocPar"
  | Declaration -> print_endline "Declaration"
  | BlocBrace -> print_endline "BlocBrace"
  | Parameters -> print_endline "Parameters"
  | Parameter -> print_endline "Parameter"
  | ParametersUse -> print_endline "ParametersUse"
  | ParameterUse -> print_endline "ParameterUse"
  | FunctionUse -> print_endline "FunctionUse"
  | Point -> print_endline "Point"
  | Line -> print_endline "Line"
  | Instruction -> print_endline "Instruction"
  | Comma -> print_endline ","
  | Draw -> print_endline "Draw"
  | Var(s) -> print_endline s
  | Number(i) -> print_endline (string_of_float i);;

let rec print_tree t p = match t with
  | Empty -> ()
  | Node(n) -> for i=0 to p do print_string "    " done;print_value n.value;print_tree n.left (p+1);print_tree n.right (p+1);;
  
      

(*remplace une élément présent dans un arbre par un autre*)
let rec remplace_elem arbre elem_present eleme_a_remplacer = match arbre with
  | Node(n) -> (let aright = remplace_elem n.right elem_present eleme_a_remplacer in
		let aleft = remplace_elem n.left elem_present eleme_a_remplacer in
		if n.value = elem_present then
		(Node {value = eleme_a_remplacer; right = aright; left = aleft})
		else
		(Node {value = n.value; right = aright; left = aleft}))
  | Empty -> Empty;;
  
let rec create_function_map arbre map = match arbre with
  | Node(n) when n.value = Function -> let Node(function_name_node) = n.left in let Var(function_name) = function_name_node.value in Hashtbl.add map function_name n.right
  | Node(n) -> create_function_map n.right map;create_function_map n.left map
  | Empty -> ();;

class point =
    object
      val mutable x = 0.
      val mutable y = 0.
      method get_y = y
      method set_y yp = y <- yp
      method get_x = x
      method set_x xp = x <- xp
    end;;
    
class line =
    object
      val mutable p1 = new point
      val mutable p2 = new point
      method get_p1 = p1
      method set_p1 p1p = p1 <- p1p
      method get_p2 = p2
      method set_p2 p2p = p2 <- p2p
    end;;

(*global type to put all of this into a hashtbl*)  
type all_types = Point_wrap of point | Line_wrap of line;; 
  
    
let get_type a = match a with
	| Point_wrap(p) -> "point"
	| Line_wrap(l) -> "line"
	| _ -> "unknow"
;;

let declare_new_point args = 
	let Node(args_x_param) = args.left in
	let Node(args_x) = args_x_param.left in
	let Number(x) = args_x.value in
	(*print_endline (string_of_float x);
	print_tree (Node(args_x)) 0;*)
	let Node(args_y_param) = args_x_param.right in
	let Node(args_y) = args_y_param.left in
	let Number(y) = args_y.value in
	let p = new point in
	p#set_x x;
	p#set_y y;
	p
;;

let create_new_qc n = 
	let Node(n_name_wrap) = n.left in
	let Var(n_name) = n_name_wrap.value in
	let Node(n_type) = n.right in
	match n_type.value with
		| Point -> let p = declare_new_point n_type in print_endline ("Creation du point : "^n_name^":("^(string_of_float (p#get_x))^","^(string_of_float (p#get_y))^")") ; (n_name,Point_wrap(p))
		| Line -> print_endline "dsdssd2" ; (n_name,Line_wrap(new line))
;;

let rec eval_val arbre val_table = match arbre with
	| Node(n) when n.value = Declaration -> let (key,value) = create_new_qc n in Hashtbl.add val_table key value ; eval_val n.right val_table; eval_val n.left val_table
	| Node(n) -> eval_val n.right val_table; eval_val n.left val_table
	| Empty -> ()
;;

let eval_var_core arbre = 
	let val_tbl : (string, all_types) Hashtbl.t= Hashtbl.create 42 in
	eval_val arbre val_tbl
;;

    

let maptest : (string, all_types) Hashtbl.t= Hashtbl.create 42 in
Hashtbl.add maptest "var1" (Point_wrap(new point));
let Point_wrap(point1) = (Hashtbl.find maptest "var1") in
point1#set_x 10.;
print_endline (get_type (Hashtbl.find maptest "var1"));
Hashtbl.add maptest "var2" (Line_wrap(new line));
let print_node name point = print_endline name in
  Hashtbl.iter print_node maptest;;

(*****************************)
(* Opérations sur les listes *)
(*****************************)

(******************************)
(* Opération sur les t_arbreB *)
(******************************)


 (******************************************)

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
