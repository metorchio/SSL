%top{
	#include <stdio.h>
}

%{
	int errlex;
	char msg[120];
%}

%option outfile="scanner.c"
%option yylineno
%option noinput
%option nounput
%option header-file="scanner.h"

ESTADOS_BOOLEANOS   [true|false]
DIGITO              [0-9]
CARACTER            [_a-zA-Z]
ENTERO              int
BOOLEANO            bool
/*OTROS               [_<>=+-(){};]*/

%%

'_'                                return "_";
'>'                                return ">";
'<'                                return "<";
'='                                return "=";
'+'                                return "+";
'-'                                return "-";
'\('                               return "(";
'\)'                               return ")";
'*'                                return "*";
'\{'                               return "{";
'\}'                               return "}";
';'                                return ";";
'if'                               return IF;
'else'                             return ELSE;
"return"                           return RETURN;
"while"                            return WHILE;
"int"                              return INT;
"bool"                             return BOOL;
'{ENTERO}|{BOOLEANO}'              return TIPODATO;
{CARACTER}+{DIGITO}*               return IDENTIFICADOR;
{DIGITO}*{ESTADOS_BOOLEANOS}*      return CONSTANTE;

%%

int yywrap(){}
int main () {
  yylex();
  printf("\nHola hola");
  return 0;
}
