(*Politique :
Déclarer une fonction plus d'une fois => la dernière est prise en compte + warning
Pour une var :  Error (laquelle prendre ?)
Une var ne peut être modifiée que dans son contexte local.
Pas de fonction dans une fonction
Pas de draw Point origine2(52,53.278);
div par 0 pas encore gérées

épaisseur ligne, pas encore géré : 2 et couleur rouge.
procédures et pas fonctions

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

class valFloat =
    object
      val mutable value = 0.
      method get_value = value
      method set_value valp = value <- valp
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
  | Float
  | Line
  | Instruction
  | Comma
  | Draw
  | Moins
  | Plus
  | Mult
  | Div
  | For
  | Dot
  | Affectation
  | Arithm_expr
  | Var of (string)
  | Number of (float);;
  
type t_arbreB = Empty | Node of node
        and node = { value: operation; left: t_arbreB; right: t_arbreB };;
        

(*TODO ajout. global type to put all of this into a hashtbl*)  
type all_types = Point_wrap of point | Line_wrap of line | Float_wrap of valFloat;; 
  
    

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
  | Moins -> print_endline "Moins"
  | Plus -> print_endline "Plus"
  | Mult -> print_endline "Mult"
  | Div -> print_endline "Div"
  | Float -> print_endline "Float"
  | For->print_endline "For"
  | Dot -> print_endline "Dot"
  | Arithm_expr ->print_endline "Arithm_expr"
  | Affectation -> print_endline "Affectation"
  | Var(s) -> print_endline s
  | Number(i) -> print_endline (string_of_float i);;

(*Affiche un arbre*)
let rec print_tree t p = match t with
  | Empty -> ()
  | Node(n) -> for i=0 to p do print_string "    " done;print_value n.value;print_tree n.left (p+1);print_tree n.right (p+1);;

  
  
  
  

let rec parse_dot_op var_name_node = print_tree (Node(var_name_node)) 0 ; match var_name_node.value with
					| Var(var_name) -> (var_name,[])
					| Dot -> let Node(op_node) = var_name_node.right in
						let Var(var_op) = op_node.value in
						let Node(node_suiv) = var_name_node.left in
						let (vn,vop) = parse_dot_op node_suiv in
						(vn,var_op::vop)
;;


let rec parse_dot_op_wrap var_name_node = let (var_name,var_op) = parse_dot_op var_name_node in (var_name,List.rev var_op);;

(*recup la valeur en utilisant les opérandes*)
let rec get_var_with_operandes val_tbl var_name operandes = 
	match operandes with
		| [] -> (Hashtbl.find val_tbl var_name)
		| a::b -> (match a with
				| "x" -> let Point_wrap(f) = get_var_with_operandes val_tbl var_name b in let fl = new valFloat in fl#set_value (f#get_x);Float_wrap(fl)
				| "y" -> let Point_wrap(f) = get_var_with_operandes val_tbl var_name b in let fl = new valFloat in fl#set_value (f#get_y);Float_wrap(fl)
				| _ -> print_endline ("Opération incorrecte sur "^var_name^" : "^a);exit 1)
;;

(*Evaluation d'une expression arithmétique TODO avec les var de type float (à implémenter)*)
let rec evalue_arithm_expr arbre val_table = match arbre with
	| Node(n) when n.value=Plus -> (evalue_arithm_expr n.left val_table)+.(evalue_arithm_expr n.right val_table)
	| Node(n) when n.value=Moins -> (evalue_arithm_expr n.left val_table)-.(evalue_arithm_expr n.right val_table)
	| Node(n) when n.value=Mult -> (evalue_arithm_expr n.left val_table)*.(evalue_arithm_expr n.right val_table)
	| Node(n) when n.value=Div -> (evalue_arithm_expr n.left val_table)/.(evalue_arithm_expr n.right val_table)
	| Node(n) when n.value=BlocPar -> evalue_arithm_expr (n.left) val_table
	| Node(n) when n.value=Arithm_expr -> evalue_arithm_expr (n.left) val_table
	| Node(n) -> (match (n.value) with
			| Number(x) -> x
			| Var(x) -> ((if ((find val_table x)="not_found") then (print_endline ("Variable non déclarée : "^x);exit 1));let x_val = (Hashtbl.find val_table x) in (match x_val with Float_wrap(x_real_val) -> (x_real_val#get_value) | _ -> (print_endline (x^" n'est pas de type float"));exit 1))
			| Dot -> let (var_name,var_op) =  parse_dot_op_wrap n in let Float_wrap(f) = get_var_with_operandes val_table var_name var_op in f#get_value
			
			)
			
	| Empty -> print_endline "error";exit 1
;;

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
	| Float_wrap(f) -> "float"
	| _ -> "unknow"
;;

let declare_new_point args val_table= 
	let Node(args_x_param) = args.left in
	(*let Node(args_x) = args_x_param.left in*)
	let x = evalue_arithm_expr (args_x_param.left) val_table in
	(*print_endline (string_of_float x);
	print_tree (Node(args_x)) 0;*)
	let Node(args_y_param) = args_x_param.right in
	(*let Node(args_y) = args_y_param.left in*)
	let y = (evalue_arithm_expr (args_y_param.left)) val_table in
	let p = new point in
	p#set_x x;
	p#set_y y;
	p
;;

let declare_new_line args val_table= 
	let Node(args_x_param) = args.left in
	let Node(args_x) = args_x_param.left in
	let Var(p_un) = args_x.value in
	(*print_endline (string_of_float x);
	print_tree (Node(args_x)) 0;*)
	let Node(args_y_param) = args_x_param.right in
	let Node(args_y) = args_y_param.left in
	let Var(p_deux) = args_y.value in
	if ((find val_table p_un)="not_found") then (print_endline ("___________ERROR : La variable "^p_un^" n'a pas encore été déclarée."); exit 1);
	if ((find val_table p_deux)="not_found") then (print_endline ("___________ERROR : La variable "^p_deux^" n'a pas encore été déclarée."); exit 1);
	let l = (new line) in
	print_endline (string_of_int (Hashtbl.length val_table));
	let Point_wrap(real_p1) = Hashtbl.find val_table p_un in
	l#set_p1 real_p1;
	let Point_wrap(real_p2) = Hashtbl.find val_table p_deux in
	l#set_p2 real_p2;
	l
;;

let declare_new_float n_type val_table = 
	let float_val = evalue_arithm_expr (n_type.left) val_table in
	let f=new valFloat in
	f#set_value float_val;
	f
;;


(*TODO faire les trucs*)
(*Creé un nouvel objet en utilisant l'arbre donné*)
let create_new_qc n val_table= 
	let Node(n_name_wrap) = n.left in
	let Var(n_name) = n_name_wrap.value in
	(*print_endline ("Création de "^n_name);*)
	let Node(n_type) = n.right in
	match n_type.value with
		| Point -> let p = declare_new_point n_type val_table in print_endline ("Creation du point : "^n_name^":("^(string_of_float (p#get_x))^","^(string_of_float (p#get_y))^")") ; (n_name,Point_wrap(p))
		| Line -> let l = declare_new_line n_type val_table in (*print_endline ("Creation de la ligne : "^n_name^":("^(string_of_float ((l#get_p1)#get_x))^","^(string_of_float ((l#get_p1)#get_y))^") à ("^(string_of_float ((l#get_p2)#get_x))^","^(string_of_float ((l#get_p2)#get_y))^")") ;*) (n_name,Line_wrap(l))
		| Float -> let f = declare_new_float n_type val_table in print_endline ("Creation du float : "^n_name^" = "^(string_of_float (f#get_value)));(n_name, Float_wrap(f))
;;




let rec set_var_with_operandes val_tbl origin_var operandes value var_name= 
	match operandes with
		| [] -> ()
		| a::b -> (match a with
				| "x" -> let var_type = get_type origin_var in if ("point"<>var_type) then (print_endline (var_name^" n'est pas un point !");exit 1);let Point_wrap(f) = origin_var in f#set_x value
				| "y" -> let var_type = get_type origin_var in if ("point"<>var_type) then (print_endline (var_name^" n'est pas un point !");exit 1);let Point_wrap(f) = origin_var in f#set_y value
				(*Appele récursi dans le cas de p1 car on peut avoir un pt dérrière*)
				| _ -> print_endline ("Opération incorrecte sur "^var_name^" : "^a);exit 1)
;;


let affect operande val_tbl = (let Node(var_name_node) = operande.left in 
				let (var_name,var_op) = parse_dot_op_wrap var_name_node in
				let Node(a_affecter) = operande.right in 
				List.iter print_endline var_op;
				match a_affecter.value with
					| Arithm_expr -> (if ((find val_tbl var_name)="not_found") then (print_endline ("Variable non déclarée : "^var_name);exit 1);
							(*let f = get_var_with_operandes val_tbl var_name var_op in*)
							(*Hashtbl.remove val_tbl var_name;*)
							set_var_with_operandes val_tbl (Hashtbl.find val_tbl var_name) var_op (evalue_arithm_expr (operande.right) val_tbl) var_name
							(*let f = new valFloat in
							f#set_value (evalue_arithm_expr (operande.right) val_tbl);
							Hashtbl.add val_tbl var_name (Float_wrap(f))*)
							(*;print_endline ("affect "^var_name^" "^(string_of_float (f#get_value)))*))
					| Var(y) -> (if ((find val_tbl var_name)="not_found") then (print_endline ("Variable non déclarée : "^var_name);exit 1);
					if ((find val_tbl y)="not_found") then (print_endline ("Variable non déclarée : "^y);exit 1);
					let var_type = get_type (Hashtbl.find val_tbl var_name) in
					let y_var = (Hashtbl.find val_tbl y) in
					let y_type = get_type y_var in
					Hashtbl.remove val_tbl var_name;
					if (y_type<>var_type) then (print_endline ("Typage incorrect entre "^var_name^" et "^y);exit 1);
					Hashtbl.add val_tbl var_name y_var;
					(*let Point_wrap(z) = y_var in
					print_endline (string_of_float (z#get_x));
					let var_var = (Hashtbl.find val_tbl var_name) in
					let Point_wrap(z2) = y_var in
					print_endline (string_of_float (z2#get_x));
					print_endline (var_name^"<-"^y)*))
					| _ -> print_endline ("Erreur d'affectation sur "^var_name);exit 1
				)
;;

(*Supprime les variables locales*)
let rec clear_this_code arbre val_tbl = match arbre with
	| Node(n) when n.value = Declaration -> let Node(var_name_node) = n.left in let Var(var_name) = var_name_node.value in Hashtbl.remove val_tbl var_name;(*print_endline ("Suppression de "^var_name)*)
	| Node(n) -> clear_this_code n.left val_tbl;clear_this_code n.right val_tbl
	| Empty -> ()
;;



(*remplace une variable par sa valeur*)
(*//TODO instructions pour modifier une variable déjà créée*)
let rec rempl_var_with_val arbre val_table = ();;

(*Récupère le type d'une variable. Si pas déclarée , renvoie une erreur*)
(*TODO  Agrandir*)
let get_var_type name val_tbl = if ((find val_tbl name)="not_found") then 
					(
					print_endline ("___________ERROR : Variable non définie : "^name);
					exit 1
					);
				match (Hashtbl.find val_tbl name) with
					| Point_wrap(_) -> Point
					| Line_wrap(_) -> Line
;;

(*Egalité des listes d'appel pour les fonctions*)
let rec egal_param declaration appel val_tbl = match (declaration,appel) with
	| ([],[]) -> true
	| ([],_) -> false
	| (_,[]) -> false
	| ((typz,name)::s,name2::s2) -> (typz = (get_var_type name2 val_tbl)) & (egal_param s s2 val_tbl);
;;


(*Construit la liste des types pour la déclaration d'une fonction*)
let rec get_constr_params bloc_par = match bloc_par with
	| Node(n) -> let Node(param) = n.left in
			if (param.value = Parameter) then 
			(
				let Node(type_param) = param.left in
				let Node(name_param) = param.right in
				let Var(real_name_param) = name_param.value in
				(type_param.value,real_name_param)::(get_constr_params n.right)
			)
			else
			(
				(*N'est pas censé arriver.*)
				print_endline "Arbre syntaxique incorrect";
				exit 1;
			)
	| Empty -> []
;;

(*Construit la liste des types pour la déclaration d'une fonction par appel à une fonction récursive*)
let get_constructor fonction =
	let Node(bloc_par) = fonction in
	get_constr_params bloc_par.left
;;
	
(*Construit la liste des variables utilisés lors de l'appel à une fonction*)
let rec get_call_constr_params bloc_par = match bloc_par with
	| Node(n) -> let Node(param) = n.left in
			if (param.value = ParameterUse) then 
			(
				let Node(name_param) = param.left in
				let Var(real_name_param) = name_param.value in
				(real_name_param)::(get_call_constr_params n.right)
			)
			else
			(
				(*N'est pas censé arriver.*)
				print_endline "Arbre syntaxique incorrect";
				exit 1;
			)
	| Empty -> []
;;

let get_call_constructor fonction =
	(* noeud de type : FunctionUse*)
	get_call_constr_params fonction
;;

(*récupère le constructeur de la fonction*)
let get_fonct_decl f_name param_list = if ((find param_list f_name)="not_found") then
					(
					print_endline ("Fonction non déclarée "^f_name);
					exit 1;
					);
					get_constructor (Hashtbl.find param_list f_name)
;;

(*retourne le code d'une fonction ! Doit exister *)
let get_func_code f_name fun_tbl = let Node(a) = Hashtbl.find fun_tbl f_name in
				let bloc_brace = a.right in
				bloc_brace	
;;

(*normalize le code d'une fonction selon le contexte*)
let rec replace_by_right_name funct_code funct_decl param_list_funct = match (funct_decl,param_list_funct) with
	| ([],[]) -> funct_code
	| ((typz,name)::s,name2::s2) -> let funct_code2 = replace_by_right_name funct_code s s2 in (remplace_elem funct_code2 (Var(name)) (Var(name2)))

(*Affiche les appels aux fonctions*)
(*remplace tous les appels aux fonctions par le morceau de code correspondant avec les bonnes variables*)
(* param_list : constructeurs des fonctions. val_tbl : la liste des variables*)
(*let rec print_call arbre param_list val_tbl = match arbre with
	| Node(n) when n.value = FunctionUse -> let param_list_funct = get_call_constructor n.right in
						(*param_list_funct : liste des paramètres lors de l'appel de la fonction*)
						let Node(f_name_node) = n.left in
						let Var(f_name) = f_name_node.value in
						print_endline ("Fonction : "^f_name);
						(*print_tree n.right 0;*)
						(*let print_list a = print_endline a in
  						List.iter (print_list) param_list_funct;*)
  						let func_decl = (get_fonct_decl f_name param_list) in
  						let equal = egal_param func_decl param_list_funct val_tbl in
  						print_endline ("Correct ? "^(string_of_bool (equal)));
  						if (not equal) then (print_endline ("___________ERROR : L'appel à la fonction "^f_name^" n'a pas les bons types de paramètres."));
  						Node({value = n.value ; left = replace_by_right_name (get_func_code f_name param_list) func_decl param_list_funct;right = Empty})
	| Node(n) -> Node({value = n.value ; left = print_call n.left param_list val_tbl;right = print_call n.right param_list val_tbl})
	| Empty -> Empty
;;*)

(*Crée les associations variable / valeur via leur déclarations*)
let rec eval_val arbre val_table param_list= match arbre with
	| Node(n) when n.value = Declaration -> (let (key,value) = create_new_qc n val_table in 
						(* Si variable déjà existante, on plante tout : laquelle prendre ? *)
						if ((find val_table key)="exists") then 
						(
						print_endline ("___________ERROR : Variable déjà déclarée : "^key^". Arrêt du programme.");exit 1
						);
						Hashtbl.add val_table key value ; 
						let l_val = eval_val n.left val_table param_list in let r_val = eval_val n.right val_table param_list in Node({value = n.value ; left = l_val;right = r_val}))
	| Node(n) when n.value = Affectation -> (affect n val_table;let l_val = eval_val n.left val_table param_list in let r_val = eval_val n.right val_table param_list in Node({value = n.value ; left = l_val;right = r_val}))
	(*| Node(n) when n.value = For -> eval_val n.left val_table; eval_val n.right val_table;(*gestion du ctx*) clear_this_code n.right val_table*)
	| Node(n) when n.value = BlocEmbrace -> (let l_val = eval_val n.left val_table param_list in let r_val = eval_val n.right val_table param_list in let node = Node({value = n.value ; left = l_val;right = r_val}) in (*gestion du ctx*) clear_this_code n.right val_table;clear_this_code n.left val_table;node)
	| Node(n) -> let l_val = eval_val n.left val_table param_list in let r_val = eval_val n.right val_table param_list in Node({value = n.value ; left = l_val;right = r_val})
	| Empty -> Empty
;;

let float_to_string fl = if ((fl-.(float_of_int (int_of_float fl)))=0.) then (string_of_int (int_of_float fl)) else (string_of_float fl);;


let rec execute_the_code arbre val_tbl= 

(*Déclaration d'une fonction fille : ces deux fonctions doivent pouvoir s'inter appeller*)
(*TODO rajouter toutes les op de type modification d'une variable, for, etc...=> modif de val_tbl à la volée*)
	let execute_action_before operande val_tbl = match (operande.value) with
		| Drawing ->(print_endline "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
				let Node(name_node) = operande.left in
				let Var(name) = name_node.value in
				let Node(drawing_size_node) = operande.right in 
				let Node(comma_node) = drawing_size_node.left in
				let Node(x_size_node) = comma_node.left in
				let Number(x_size) = x_size_node.value in
				let Node(y_size_node) = comma_node.right in
				let Number(y_size) = y_size_node.value in
				print_endline ("<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\""^(string_of_int (int_of_float x_size))^"\" height=\""^(string_of_int (int_of_float y_size))^"\">"))
		| Draw ->(let Node(var_name_node) = operande.left in
			let Var(var_name) = var_name_node.value in
			if ((find val_tbl var_name)="not_found") then (print_endline ("Variable inconnue : "^var_name);exit 1);
			let real_var = (Hashtbl.find val_tbl var_name) in
			match real_var with
				| Point_wrap(p) -> (*print_endline ("ici sera dessiné un point de coordonées "^(string_of_float (p#get_x))^" et "^(string_of_float (p#get_y)))*) ()
				| Line_wrap(l) -> (*print_endline ("ici sera dessiné une ligne ("^(string_of_float ((l#get_p1)#get_x))^","^(string_of_float ((l#get_p1)#get_y))^") à ("^(string_of_float ((l#get_p2)#get_x))^","^(string_of_float ((l#get_p2)#get_y))^")")*) print_endline ("<line x1=\""^(float_to_string ((l#get_p1)#get_x))^"\" y1=\""^(float_to_string ((l#get_p1)#get_y))^"\" x2=\""^(float_to_string ((l#get_p2)#get_x))^"\" y2=\""^(float_to_string ((l#get_p2)#get_y))^"\" style=\"stroke:rgb(255,0,0);stroke-width:2\"/>")
				| _ -> print_endline "Type inconnu !"; exit 1)
		| Affectation -> affect operande val_tbl
		| Declaration -> (let (key,value) = create_new_qc operande val_tbl in 
						(* Si variable déjà existante, on plante tout : laquelle prendre ? *)
						if ((find val_tbl key)="exists") then 
						(
						print_endline ("___________ERROR : Variable déjà déclarée : "^key^". Arrêt du programme.");exit 1
						);
						Hashtbl.add val_tbl key value ; 
						)
		| _ -> ()
		
		
(* fin imbrication de la fonction corps*)
(*deuxième fct fille*)
	in 
	
let execute_action_after operande val_tbl = match operande.value with
	| Drawing ->print_endline "</svg>"
	| BlocEmbrace -> (*gestion du ctx*) clear_this_code operande.right val_tbl ; clear_this_code operande.left val_tbl
	| For -> (let Node(var_node) = operande.left in
				let Var(var_name) = var_node.value in
				let start_val = evalue_arithm_expr (var_node.left) val_tbl in
				let end_val = evalue_arithm_expr (var_node.right) val_tbl in
				(*print_endline ((string_of_float start_val)^" "^(string_of_float end_val));*)
				for i = (int_of_float (start_val)) to (int_of_float (end_val)) do 
					(
					(*On set le compteur*)
					(*print_endline (string_of_int i);*)
					if ((find val_tbl var_name)="exists") then (Hashtbl.remove val_tbl var_name);
					let f = new valFloat in 
					f#set_value (float_of_int i);
					Hashtbl.add val_tbl var_name (Float_wrap(f));
					
					(*Suppression des variables qui vont êtres redéclarées*)
					(*clear_this_code operande.right val_tbl;*)
					(*déclaration à leurs nouvelles valeurs.*)
					eval_val operande.right val_tbl;
					
					
					execute_the_code operande.right val_tbl
					)
				done;(*Suppression des variables locales*)(*clear_this_code arbre val_tbl;*))
	| _ -> ()
		
	(*fin fct fille*)
in
	match arbre with
	| Node(n) when n.value=For (*dans le cas d'un for, on ne réexécute pas le code après (<> do while)*)-> execute_action_after n val_tbl;
	| Node(n) -> execute_action_before n val_tbl; execute_the_code (n.left) val_tbl; execute_the_code (n.right) val_tbl; execute_action_after n val_tbl;
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
