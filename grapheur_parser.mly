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
  BEGIN_EMBRACE corps END_EMBRACE {
  Node {value=Drawing; 
    left=Node {value=Var($2); left=Empty; right=Empty};
    right=Node{value=DrawingSize; 
      left=Node{value=Var($5); 
	left=Node{value=Number($4); left=Empty; right=Empty}; 
	right=Node{value=Number($6); left=Empty; right=Empty}
	}; 
      right=Node{value=BlocEmbrace; left=$9; right=Empty}
    }
  }
}
;

corps:
  POINT VAR BEGIN_PAR NUMBER COMMA NUMBER END_PAR SEMICOLON { 
  Node {value=Declaration;
    left=Empty; 
    right= Node{
      left= Empty;
      right = Node{value=Var($2); left=Empty; right=Empty}
    }
  } 
}
;
