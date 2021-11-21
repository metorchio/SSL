%{
  #include <stdio.h>
  #define YY_DECL extern "C" int yylex()
  void yyerror(const char* s);  
%}


%token IF ELSE RETURN INT BOOL WHILE CARACTER DIGITO

%start palabra_reservada

%%

palabra_reservada		    : IF | ELSE | RETURN | INT | BOOL | WHILE;
identificador           : CARACTER'+''('DIGITO'+'CARACTER'+'DIGITO')''*';
constante               : DIGITO'+';


