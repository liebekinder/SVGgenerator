%{
  open Functions;;
%}

%token EOF

%token BEGIN_EMBRACE
%token END_EMBRACE
%token BEGIN_PAR
%token END_PAR
%token SEMICOLON
%token COMMA
%token DOUBLEDOT
%token DOT
%token BEGIN_BRACE
%token END_BRACE

%token FUNCTION
%token DRAWING
%token AFFECT
%token DRAW

%token PLUS
%token MOINS
%token DIV
%token MULT

%token FOR

%token FLOAT

%token POINT
%token LINE

%token <string> VAR 
%token <float> NUMBER

%start main
%type <Functions.t_arbreB> main


%%

main:
  functions dessin EOF {
	Node{value=Root;
		left=$1;
		right=$2
		}
}
| dessin EOF {$1}
;

functions:
functio functions {
    Node{value=Functions;
	  left=$1;
	  right=$2
	  }
	}
| functio{Node{value=Functions;
				left=$1;
				right=Empty
				}
			}
;

functio:
	FUNCTION VAR BEGIN_PAR params END_PAR BEGIN_EMBRACE instruction END_EMBRACE{
		Node{value=Function;
			left=Node{value=Var($2);
					left=Empty;
					right=Empty
				};
			right=Node{value=BlocPar;
						left=$4;
						right=Node{value=BlocBrace;
									left=$7;
									right=Empty
								}
					}
			}
	}
;

params:
param COMMA params {
    Node{value=Parameters;
		left=$1;
		right=$3
	  }
	 }
| param{
    Node{value=Parameters;
		left=$1;
		right=Empty
	  }
	 }
;

param:
	POINT VAR {Node {value=Parameter;
					left=Node {value=Point;
								left=Empty;
								right=Empty
							};
					right=Node {value=Var($2);
								left=Empty;
								right=Empty
							}
					}
			}
|	LINE VAR {Node {value=Parameter;
					left=Node {value=Line;
								left=Empty;
								right=Empty
							};
					right=Node {value=Var($2);
								left=Empty;
								right=Empty
							}
					}
			}
;

dessin:
  DRAWING VAR BEGIN_BRACE NUMBER COMMA NUMBER END_BRACE
  BEGIN_EMBRACE instruction END_EMBRACE {
  Node {value=Drawing; 
		left=Node {value=Var($2);
					left=Empty;
					right=Empty
				};
		right=Node{value=DrawingSize;
					left=Node{value=Comma;
							left=Node{value=Number($4);
								left=Empty;
								right=Empty
								};
							right=Node{value=Number($6);
								left=Empty;
								right=Empty
								}
							};
					right=Node{value=BlocEmbrace;
								left=$9;
								right=Empty
								}
					}
		}
}
;

instruction:
  declaration instruction {
    Node{value=Instruction;
	  left=$1;
	  right=$2
	  }
  }
| declaration {
    Node{value=Instruction;
	  left=$1;
	  right=Empty
	  }
  }

| dessine instruction {
    Node{value=Instruction;
	  left=$1;
	  right=$2
	  }
  }
| dessine {
    Node{value=Instruction;
	  left=$1;
	  right=Empty
	  }
  }
| funcUse instruction {
    Node{value=Instruction;
	  left=$1;
	  right=$2
	  }
  }
| funcUse {
    Node{value=Instruction;
	  left=$1;
	  right=Empty
	  }
  }
;



funcUse:
	VAR BEGIN_PAR funcUsePars END_PAR SEMICOLON {
		Node{value=FunctionUse;
			left=Node{value=Var($1);
					left=Empty;
					right=Empty
					};
			right=$3			
		}
	}
;

funcUsePars:
funcUsePar COMMA funcUsePars {
    Node{value=ParametersUse;
		left=$1;
		right=$3
	  }
	 }
| funcUsePar{
    Node{value=ParametersUse;
		left=$1;
		right=Empty
	  }
	 }
;

funcUsePar:
	VAR {Node {value=ParameterUse;
				left=Node{value=Var($1);
					left=Empty;
					right=Empty
					};
				right=Empty
				}
		}
;

arithm_expr:
	var_or_number {$1}
	| arithm_expr PLUS arithm_expr {Node{value = Plus;left= $1;right = $3}}
	| arithm_expr MULT arithm_expr {Node{value = Mult;left= $1;right = $3}}
	| arithm_expr DIV arithm_expr {Node{value = Div;left= $1;right = $3}}
	| arithm_expr MOINS arithm_expr {Node{value = Moins;left= $1;right = $3}}
	| BEGIN_PAR arithm_expr END_PAR {Node{value = BlocPar;left= $2;right = Empty}}
;

var_or_number:
	NUMBER {Node{value=Number($1);left=Empty;right=Empty}}
	| VAR {Node{value=Var($1);left=Empty;right=Empty}}
;

declaration:
  POINT VAR BEGIN_PAR arithm_expr COMMA arithm_expr END_PAR SEMICOLON {
    Node{value=Declaration;
	left=Node{value=Var($2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Point;
		  left=Node{value=BlocPar;
			    left=Node{value=Arithm_expr;
				      left=$4;
				      right=Empty
				      };
			    right=Node{value=Parameters;
					left=Node{value=Arithm_expr;
						  left=$6;
						  right=Empty
						  };
					right=Empty
					}
			    };
		  right=Empty
		}
    }
}

| LINE VAR BEGIN_PAR VAR COMMA VAR END_PAR SEMICOLON {
    Node{value=Declaration;
	left=Node{value=Var($2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Line;
		  left=Node{value=BlocPar;
			    left=Node{value=Var($4);
				      left=Empty;
				      right=Empty
				      };
			    right=Node{value=Parameters;
					left=Node{value=Var($6);
						  left=Empty;
						  right=Empty
						  };
					right=Empty
					}
			    };
		  right=Empty
		}
    }
}
| FLOAT VAR BEGIN_PAR arithm_expr END_PAR SEMICOLON {
					Node{value=Declaration;
						left=Node{value=Var($2);
									left=Empty;
									right=Empty
									};
						right=Node{value=Float;
							  left=Node{value=Arithm_expr;
								left=$4;
								right=Empty			
								};
						  	right=Empty
						  }
					
					}
				}
;

dessine:
  DRAW VAR SEMICOLON {
    Node{value=Draw;
	  left=Node{value=Var($2);
		    left=Empty;
		    right=Empty
		    };
	  right=Empty
	  }
    }
;
