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

%token POINT
%token LINE

%token <string> VAR 
%token <int> NUMBER

%start main
%type <Functions.t_arbreB> main


%%

main:
  dessin EOF {$1}
;

dessin:
  DRAWING VAR BEGIN_BRACE NUMBER VAR NUMBER END_BRACE
  BEGIN_EMBRACE instruction END_EMBRACE {
  Node {value=Drawing; 
	left=Node {value=Var($2); 
		    left=Empty; 
		    right=Empty
		    };
	right=Node{value=DrawingSize; 
		  left=Node{value=Var($5); 
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
;

declaration:
  POINT VAR BEGIN_PAR NUMBER COMMA NUMBER END_PAR SEMICOLON {
    Node{value=Declaration;
	left=Node{value=Var($2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Point;
		  left=Node{value=BlocBrace;
			    left=Node{value=Number($4);
				      left=Empty;
				      right=Empty
				      };
			    right=Node{value=Parameters;
					left=Node{value=Number($6);
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

| LINE VAR BEGIN_PAR VAR COMMA VAR END_PAR SEMICOLON {
    Node{value=Declaration;
	left=Node{value=Var($2); 
		  left=Empty; 
		  right=Empty
		  };
	right=Node{value=Line;
		  left=Node{value=BlocBrace;
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
