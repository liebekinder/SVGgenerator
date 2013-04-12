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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Functions.t_arbreB
