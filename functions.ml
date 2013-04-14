(*Politique :
Déclarer une fonction plus d'une fois => la dernière est prise en compte + warning
Pour une var :  Error (laquelle prendre ?)


*)

(*------*)
(*Objets*)
(*------*)
    
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


(*-----*)
(*TYPES*)
(*-----*)

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
        

(*global type to put all of this into a hashtbl*)  
type all_types = Point_wrap of point | Line_wrap of line;; 
  
    

(*---------*)
(*Fonctions*)
(*---------*)


(* teste l'exitence dans une Hashtbl en gerant les erreurs*)
let find table value = 
  try ((Hashtbl.find table value);"exists") with
  | _ ->"not_found";
;;

(*Parse une opération et affiche son type*)   
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

(*Affiche un arbre*)
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
  
(*Crée une fonction à partir de sa déclaration (couple nom/arbre d'instructions)*)
let rec create_function_map arbre map = match arbre with
  | Node(n) when n.value = Function -> let Node(function_name_node) = n.left in let Var(function_name) = function_name_node.value in 
  					if ((find map function_name)="exists") then (print_endline ("___________WARNING : fonction déjà déclarée : "^function_name);Hashtbl.remove map function_name);
  					Hashtbl.add map function_name n.right
  | Node(n) -> create_function_map n.right map;create_function_map n.left map
  | Empty -> ();;




(*Affiche le type d'un all_types*)
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


(*Crée les associations variable / valeur via leur déclarations*)
let rec eval_val arbre val_table = match arbre with
	| Node(n) when n.value = Declaration -> let (key,value) = create_new_qc n in 
						(* Si varaible déjà existant, on plante tout : laquelle prendre ? *)
						if ((find val_table key)="exists") then (print_endline ("___________ERROR : Variable déjà déclarée : "^key^". Arrêt du programme.");exit 1);
						Hashtbl.add val_table key value ; eval_val n.left val_table; eval_val n.right val_table
	| Node(n) -> eval_val n.left val_table; eval_val n.right val_table
	| Empty -> ()
;;


    
(*Tests en dur*)
(*let maptest : (string, all_types) Hashtbl.t= Hashtbl.create 42 in
Hashtbl.add maptest "var1" (Point_wrap(new point));
let Point_wrap(point1) = (Hashtbl.find maptest "var1") in
point1#set_x 10.;
print_endline (get_type (Hashtbl.find maptest "var1"));
Hashtbl.add maptest "var2" (Line_wrap(new line));
let print_node name point = print_endline name in
  Hashtbl.iter print_node maptest;;*)
