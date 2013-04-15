{
	open Grapheur_parser;; (* Le coup de la maj *)
}

let void = [' ' '\t' '\r']
let variable = ['a'-'z' 'A'-'Z']['0'-'9' 'a'-'z' 'A'-'Z']*
let number = ['0'-'9']+|['0'-'9']+'.'['0'-'9']*

rule token = parse
  | "/*" {comment_star lexbuf}
  | "//" {comment_double_slash lexbuf}
  
  | "function" {print_endline "FUNCTION" ; FUNCTION}
  | "draw" {print_endline "DRAW" ; DRAW}
  | "drawing" {print_endline "DRAWING" ; DRAWING}
  
  
  | '{' {print_endline "{";BEGIN_EMBRACE}
  | '}' {print_endline "}";END_EMBRACE}
  | '(' {print_endline "(";BEGIN_PAR}
  | ')' {print_endline ")";END_PAR}
  | '.' {print_endline ".";DOT}
  | ':' {print_endline ":";DOUBLEDOT}
  | ',' {print_endline ",";COMMA}
  | ';' {print_endline ";";SEMICOLON}
  | '[' {print_endline "[";BEGIN_BRACE}
  | ']' {print_endline "]";END_BRACE}
  
  | "Float" {print_endline "Float";FLOAT}
  
  | "For" {print_endline "For";FOR}
  
  | '+' {print_endline "+";PLUS}
  | '-' {print_endline "-";MOINS}
  | '/' {print_endline "/";DIV}
  | '*' {print_endline "*";MULT}
  | '=' {print_endline "=";EQ}
  
  | "Point" {print_endline "Point"; POINT}
  | "Line" {print_endline "Line"; LINE}
  
  | variable as lxm {print_endline ("Var : "^lxm);VAR(lxm)}
  | number as lxm {print_endline ("Number : "^lxm);NUMBER(float_of_string lxm)}
  
  | '.' {print_endline "Dot";DOT}
   
  | '\n' {token lexbuf} 
  | void {token lexbuf} 
  | eof  {print_endline "eof";EOF}
  | _ {print_endline "Motif non reconnu1";token lexbuf}
  

(*commentary managment*)
and comment_star = parse
  | "*/" {token lexbuf}
  | eof   {EOF}
  | _ {comment_star lexbuf}
  
and comment_double_slash = parse
  | '\n' {token lexbuf}
  | eof   {EOF}
  | _ {comment_double_slash lexbuf}
  
  
