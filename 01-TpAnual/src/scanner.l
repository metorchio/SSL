%top{
	#include <stdio.h>
  #include "tokens.h"
}

%{
  int yylineno;
	int errlex;
	char msg[120];
%}

%option outfile="scanner.c"
%option yylineno
%option header-file="scanner.h"

SALTO               [\n]
DIGITO              [0-9]
CARACTER            [_a-zA-Z]

%%

{SALTO}                            return yylineno;
"<"                                return OP_MENOR;
">"                                return OP_MAYOR;
"="                                return OP_ASIGNACION;
"+"                                return OP_SUMA;
"-"                                return OP_RESTA;
"*"                                return OP_MULTIPLICACION;
"\("                               return OP_PARENTESIS_ABIERTO;
"\)"                               return OP_PARENTESIS_CERRADO;
"\{"                               return OP_BLOQUE_ABIERTO;
"\}"                               return OP_BLOQUE_CERRADO;
";"                                return OP_FIN_DE_LINEA;
","                                return OP_SEPARADOR_PARAM;
"if"                               return IF;
"else"                             return ELSE;
"return"                           return RETURN;
"while"                            return WHILE;
"int"                              return INT;
"bool"                             return BOOL;
"true"|"false"                     return ESTADO_BOOL;
{CARACTER}({CARACTER}|{DIGITO})*   return IDENTIFICADOR;
{DIGITO}+                          return CONSTANTE;

%%

int main (int argc, char** argv) {
  yyin = fopen(argv[1], "r");
  int token = yylex();
  while( token ){
    printf("Linea: %d token: %d \t lexema %s \n", yylineno, token, yytext);
    token = yylex();
  }
  return 0;
}