type token =
  | EOF
  | BEGIN_EMBRACE
  | END_EMBRACE
  | BEGIN_PAR
  | END_PAR
  | SEMICOLON
  | COMMA
  | DOUBLEDOT
  | DOT
  | BEGIN_BRACE
  | END_BRACE
  | FUNCTION
  | DRAWING
  | AFFECT
  | DRAW
  | POINT
  | LINE
  | VAR of (string)
  | NUMBER of (int)

open Parsing;;
# 1 "grapheur_parser.mly"

  open Functions;;
# 27 "grapheur_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* BEGIN_EMBRACE *);
  258 (* END_EMBRACE *);
  259 (* BEGIN_PAR *);
  260 (* END_PAR *);
  261 (* SEMICOLON *);
  262 (* COMMA *);
  263 (* DOUBLEDOT *);
  264 (* DOT *);
  265 (* BEGIN_BRACE *);
  266 (* END_BRACE *);
  267 (* FUNCTION *);
  268 (* DRAWING *);
  269 (* AFFECT *);
  270 (* DRAW *);
  271 (* POINT *);
  272 (* LINE *);
    0|]

let yytransl_block = [|
  273 (* VAR *);
  274 (* NUMBER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\000\000"

let yylen = "\002\000\
\002\000\010\000\008\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\004\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\000\000\000\000\000\000\000\000\003\000"

let yydgoto = "\002\000\
\004\000\005\000\015\000"

let yysindex = "\255\255\
\245\254\000\000\241\254\000\000\003\000\251\254\000\000\243\254\
\246\254\244\254\254\254\008\255\252\254\249\254\010\255\011\255\
\000\000\253\254\007\255\255\254\012\255\013\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000"

let yytablesize = 18
let yytable = "\001\000\
\003\000\006\000\007\000\008\000\009\000\011\000\010\000\012\000\
\013\000\016\000\014\000\017\000\020\000\018\000\019\000\022\000\
\021\000\023\000"

let yycheck = "\001\000\
\012\001\017\001\000\000\009\001\018\001\018\001\017\001\010\001\
\001\001\017\001\015\001\002\001\006\001\003\001\018\001\004\001\
\018\001\005\001"

let yynames_const = "\
  EOF\000\
  BEGIN_EMBRACE\000\
  END_EMBRACE\000\
  BEGIN_PAR\000\
  END_PAR\000\
  SEMICOLON\000\
  COMMA\000\
  DOUBLEDOT\000\
  DOT\000\
  BEGIN_BRACE\000\
  END_BRACE\000\
  FUNCTION\000\
  DRAWING\000\
  AFFECT\000\
  DRAW\000\
  POINT\000\
  LINE\000\
  "

let yynames_block = "\
  VAR\000\
  NUMBER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'dessin) in
    Obj.repr(
# 36 "grapheur_parser.mly"
             (_1)
# 123 "grapheur_parser.ml"
               : Functions.t_arbreB))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : int) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : 'corps) in
    Obj.repr(
# 41 "grapheur_parser.mly"
                                  (
  Node {value=Drawing; 
    left=Node {value=Var(_2); left=Empty; right=Empty};
    right=Node{value=DrawingSize; 
      left=Node{value=Var(_5); 
	left=Node{value=Number(_4); left=Empty; right=Empty}; 
	right=Node{value=Number(_6); left=Empty; right=Empty}
	}; 
      right=Node{value=BlocEmbrace; left=_9; right=Empty}
    }
  }
)
# 145 "grapheur_parser.ml"
               : 'dessin))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 56 "grapheur_parser.mly"
                                                            ( 
  Node {value=Declaration;
    left=Empty; 
    right= Node{
      left= Empty;
      right = Node{value=Var(_2); left=Empty; right=Empty}
    }
  } 
)
# 162 "grapheur_parser.ml"
               : 'corps))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Functions.t_arbreB)
