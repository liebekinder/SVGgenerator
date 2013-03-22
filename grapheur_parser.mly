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
%token NEW

%token POINT
%token LINE

%token <string> VAR 
%token <int> NUMBER

%start main
%type <string> main

%%

main:
  dessin EOF {$1}
;

dessin:
  DRAWING VAR BEGIN_BRACE NUMBER VAR NUMBER END_BRACE
  BEGIN_EMBRACE corps END_EMBRACE {$9}
;

corps:
  POINT VAR AFFECT NEW POINT BEGIN_PAR NUMBER COMMA NUMBER END_PAR SEMICOLON {$2}
;
