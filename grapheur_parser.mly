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
%type <Fonctions.t_arbreB arbre> main


%%

main:
  dessin EOF {$1}
;

dessin:
  DRAWING VAR BEGIN_BRACE NUMBER VAR NUMBER END_BRACE
  BEGIN_EMBRACE corps END_EMBRACE {Node {value=Drawing; left=Node {value=$2; left=Empty; right=Empty}; right=Node{value=DrawingSize; left=Node{value=$5; left=Node{value=$4; left=Empty; right=Empty}; right=Node{value=$6; left=Empty; right=Empty}}; right=Node{value=BlocEmbrace; left=$9; right=Empty}}}}
;

corps:
  POINT VAR BEGIN_PAR NUMBER COMMA NUMBER END_PAR SEMICOLON {Node {value=Declaration; left=Node{value=Point; left=Node{value=BlocBrace; left=Node{value=$4; left=Empty; right=Empty}, right=Node{value=Parameter; left=Node{value=$6; left=Empty; right=Empty}; right=Empty}; right=Empty}; rigth=Node{value=$2; left=Empty; right=Empty}}}}
;
