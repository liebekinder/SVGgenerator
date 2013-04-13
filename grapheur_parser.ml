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
\001\000\002\000\002\000\004\000\005\000\005\000\007\000\007\000\
\003\000\006\000\006\000\006\000\006\000\006\000\006\000\010\000\
\011\000\011\000\012\000\008\000\008\000\009\000\000\000"

let yylen = "\002\000\
\003\000\002\000\001\000\008\000\002\000\001\000\002\000\002\000\
\010\000\002\000\001\000\002\000\001\000\002\000\001\000\005\000\
\002\000\001\000\001\000\008\000\008\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\023\000\000\000\000\000\000\000\000\000\
\000\000\002\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\007\000\008\000\000\000\005\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\004\000\010\000\
\012\000\014\000\000\000\022\000\000\000\000\000\019\000\000\000\
\000\000\000\000\000\000\000\000\000\000\017\000\000\000\000\000\
\000\000\016\000\009\000\000\000\000\000\000\000\000\000\020\000\
\021\000"

let yydgoto = "\002\000\
\004\000\005\000\009\000\006\000\016\000\030\000\017\000\031\000\
\032\000\033\000\048\000\049\000"

let yysindex = "\008\000\
\255\254\000\000\250\254\000\000\000\255\255\254\010\255\253\254\
\015\000\000\000\248\254\007\255\000\000\001\255\003\255\013\255\
\248\254\004\255\000\000\000\000\020\255\000\000\017\255\245\254\
\006\255\008\255\009\255\011\255\024\255\027\255\245\254\245\254\
\245\254\021\255\025\255\029\255\030\255\018\255\000\000\000\000\
\000\000\000\000\033\255\000\000\019\255\022\255\000\000\032\255\
\018\255\245\254\034\255\035\255\037\255\000\000\036\255\026\255\
\028\255\000\000\000\000\039\255\042\255\043\255\044\255\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\038\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\047\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\045\255\050\255\
\051\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\052\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\048\000\000\000\000\000\038\000\225\255\000\000\000\000\
\000\000\000\000\009\000\000\000"

let yytablesize = 58
let yytable = "\040\000\
\041\000\042\000\026\000\027\000\028\000\029\000\014\000\015\000\
\001\000\003\000\007\000\008\000\011\000\012\000\013\000\018\000\
\021\000\019\000\055\000\020\000\024\000\023\000\025\000\034\000\
\035\000\036\000\038\000\037\000\039\000\044\000\043\000\045\000\
\046\000\050\000\047\000\053\000\051\000\059\000\052\000\056\000\
\057\000\058\000\062\000\060\000\061\000\063\000\011\000\064\000\
\065\000\003\000\006\000\013\000\015\000\010\000\022\000\018\000\
\000\000\054\000"

let yycheck = "\031\000\
\032\000\033\000\014\001\015\001\016\001\017\001\015\001\016\001\
\001\000\011\001\017\001\012\001\003\001\017\001\000\000\009\001\
\004\001\017\001\050\000\017\001\001\001\018\001\006\001\018\001\
\017\001\017\001\003\001\017\001\002\001\005\001\010\001\003\001\
\003\001\001\001\017\001\004\001\018\001\002\001\017\001\006\001\
\006\001\005\001\004\001\018\001\017\001\004\001\002\001\005\001\
\005\001\012\001\004\001\002\001\002\001\006\000\017\000\004\001\
\255\255\049\000"

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
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'functions) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'dessin) in
    Obj.repr(
# 36 "grapheur_parser.mly"
                       (
	Node{value=Root;
		left=_1;
		right=_2
		}
)
# 163 "grapheur_parser.ml"
               : Functions.t_arbreB))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'functio) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'functions) in
    Obj.repr(
# 45 "grapheur_parser.mly"
                  (
    Node{value=Functions;
	  left=_1;
	  right=_2
	  }
	)
# 176 "grapheur_parser.ml"
               : 'functions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'functio) in
    Obj.repr(
# 51 "grapheur_parser.mly"
         (Node{value=Functions;
				left=_1;
				right=Empty
				}
			)
# 187 "grapheur_parser.ml"
               : 'functions))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'params) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    Obj.repr(
# 59 "grapheur_parser.mly"
                                                                            (
		Node{value=Function;
			left=Node{value=Var(_2);
					left=Empty;
					right=Empty
				};
			right=Node{value=BlocPar;
						left=_4;
						right=Node{value=BlocBrace;
									left=_7;
									right=Empty
								}
					}
			}
	)
# 210 "grapheur_parser.ml"
               : 'functio))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'param) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 77 "grapheur_parser.mly"
             (
    Node{value=Parameters;
		left=_1;
		right=_2
	  }
	 )
# 223 "grapheur_parser.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'param) in
    Obj.repr(
# 83 "grapheur_parser.mly"
       (
    Node{value=Parameters;
		left=_1;
		right=Empty
	  }
	 )
# 235 "grapheur_parser.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 92 "grapheur_parser.mly"
           (Node {value=Parameter;
					left=Node {value=Point;
								left=Empty;
								right=Empty
							};
					right=Node {value=Var(_2);
								left=Empty;
								right=Empty
							}
					}
			)
# 252 "grapheur_parser.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 103 "grapheur_parser.mly"
           (Node {value=Parameter;
					left=Node {value=Line;
								left=Empty;
								right=Empty
							};
					right=Node {value=Var(_2);
								left=Empty;
								right=Empty
							}
					}
			)
# 269 "grapheur_parser.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    Obj.repr(
# 118 "grapheur_parser.mly"
                                        (
  Node {value=Drawing; 
		left=Node {value=Var(_2);
					left=Empty;
					right=Empty
				};
		right=Node{value=DrawingSize;
					left=Node{value=Comma;
							left=Node{value=Number(_4);
								left=Empty;
								right=Empty
								};
							right=Node{value=Number(_6);
								left=Empty;
								right=Empty
								}
							};
					right=Node{value=BlocEmbrace;
								left=_9;
								right=Empty
								}
					}
		}
)
# 302 "grapheur_parser.ml"
               : 'dessin))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 145 "grapheur_parser.mly"
                          (
    Node{value=Instruction;
	  left=_1;
	  right=_2
	  }
  )
# 315 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 151 "grapheur_parser.mly"
              (
    Node{value=Instruction;
	  left=_1;
	  right=Empty
	  }
  )
# 327 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'dessine) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 158 "grapheur_parser.mly"
                      (
    Node{value=Instruction;
	  left=_1;
	  right=_2
	  }
  )
# 340 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'dessine) in
    Obj.repr(
# 164 "grapheur_parser.mly"
          (
    Node{value=Instruction;
	  left=_1;
	  right=Empty
	  }
  )
# 352 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'funcUse) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 171 "grapheur_parser.mly"
                      (
    Node{value=Instruction;
	  left=_1;
	  right=_2
	  }
  )
# 365 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funcUse) in
    Obj.repr(
# 177 "grapheur_parser.mly"
          (
    Node{value=Instruction;
	  left=_1;
	  right=Empty
	  }
  )
# 377 "grapheur_parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'funcUsePars) in
    Obj.repr(
# 186 "grapheur_parser.mly"
                                             (
		Node{value=FunctionUse;
			left=Node{value=Var(_1);
					left=Empty;
					right=Empty
					};
			right=_3			
		}
	)
# 393 "grapheur_parser.ml"
               : 'funcUse))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'funcUsePar) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'funcUsePars) in
    Obj.repr(
# 198 "grapheur_parser.mly"
                       (
    Node{value=ParametersUse;
		left=_1;
		right=_2
	  }
	 )
# 406 "grapheur_parser.ml"
               : 'funcUsePars))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funcUsePar) in
    Obj.repr(
# 204 "grapheur_parser.mly"
            (
    Node{value=ParametersUse;
		left=_1;
		right=Empty
	  }
	 )
# 418 "grapheur_parser.ml"
               : 'funcUsePars))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 213 "grapheur_parser.mly"
     (Node {value=ParameterUse;
				left=Node{value=Var(_1);
					left=Empty;
					right=Empty
					};
				right=Empty
				}
		)
# 432 "grapheur_parser.ml"
               : 'funcUsePar))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 224 "grapheur_parser.mly"
                                                            (
    Node{value=Declaration;
	left=Node{value=Var(_2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Point;
		  left=Node{value=BlocPar;
			    left=Node{value=Number(_4);
				      left=Empty;
				      right=Empty
				      };
			    right=Node{value=Parameters;
					left=Node{value=Number(_6);
						  left=Empty;
						  right=Empty
						  };
					right=Empty
					}
			    };
		  right=Empty
		}
    }
)
# 464 "grapheur_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : string) in
    Obj.repr(
# 249 "grapheur_parser.mly"
                                                     (
    Node{value=Declaration;
	left=Node{value=Var(_2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Line;
		  left=Node{value=BlocPar;
			    left=Node{value=Var(_4);
				      left=Empty;
				      right=Empty
				      };
			    right=Node{value=Parameters;
					left=Node{value=Var(_6);
						  left=Empty;
						  right=Empty
						  };
					right=Empty
					}
			    };
		  right=Empty
		}
    }
)
# 496 "grapheur_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 276 "grapheur_parser.mly"
                     (
    Node{value=Draw;
	  left=Node{value=Var(_2);
		    left=Empty;
		    right=Empty
		    };
	  right=Empty
	  }
    )
# 511 "grapheur_parser.ml"
               : 'dessine))
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
