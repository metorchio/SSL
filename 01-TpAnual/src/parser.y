%{
  #include <stdio.h>
  int yylex();
  void yyerror(const char* s);  

%}

%union {
  int valor_entero;
}

%left OP_SUMA OP_SUMA
%left OP_MULTIPLICACION
%token IF ELSE RETURN INT BOOL WHILE CARACTER DIGITO

%start palabra_reservada

%%

expresion		    : IF | ELSE | RETURN | INT | BOOL | WHILE;


