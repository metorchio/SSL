%top{
	#include <stdio.h>
  //#include "tokens.h"
  #include "parser.h"
}

%{
  int yylineno;
	int errlex;
	char msg[120];

  /*void yyerror(char const *s) {
    fprintf (stderr, "%s\n", s);
  }*/
%}

%option outfile="scanner.c"
%option yylineno
%option noyywrap
%option header-file="scanner.h"

SALTO               [\n]
DIGITO              [0-9]
CARACTER            [_a-zA-Z]
OTRO                [[:punct:]]

%%

{SALTO}                              {yylineno;}
"!"                                  return OP_NEGACION;
"&&"                                 return OP_AND;
"||"                                 return OP_OR;
"=="                                 return OP_IGUAL;
"!="                                 return OP_DISTINTO;
"<"                                  return OP_MENOR;
">"                                  return OP_MAYOR;
"="                                  return OP_ASIGNACION;
"+"                                  return OP_SUMA;
"-"                                  return OP_RESTA;
"*"                                  return OP_MULTIPLICACION;
"\("                                 return OP_PARENTESIS_ABIERTO;
"\)"                                 return OP_PARENTESIS_CERRADO;
"\{"                                 return OP_BLOQUE_ABIERTO;
"\}"                                 return OP_BLOQUE_CERRADO;
";"                                  return OP_FIN_DE_LINEA;
","                                  return OP_SEPARADOR_PARAM;
"if"                                 return IF;
"else"                               return ELSE;
"return"                             return RETURN;
"start"                              return MAIN;
"int"                                {yylval = strdup(yytext); return INT;};
"bool"                               return BOOL;
"true"|"false"                       return ESTADO_BOOL;
{CARACTER}({CARACTER}|{DIGITO})*     {if( yyleng > 16){errlex++; sprintf(msg, "Error léxico. \t Identificador excede longitud maxima: %s", yytext);  yyerror(msg);}else{yylval = strdup(yytext); return IDENTIFICADOR;}}
{DIGITO}+                            {yylval = strdup(yytext); return CONSTANTE;};
{OTRO}                               {errlex++; sprintf(msg, "Error léxico. \t Constante inválida: %s",  yytext);  yyerror(msg);}

%%

void scanInput();
void parseInput();

int main(int argc, char** argv) {
  yyin = fopen(argv[2], "r");
  if( yyin == NULL ) {
    printf("No se pudo abrir el archivo : %s \n", argv[1]);
    return 1;
  }
  
  printf("\n\n");
  if( strcmp(argv[1], "--scan") == 0 ){
    scanInput();
  } else if( strcmp(argv[1], "--parse") == 0 ) {
    parseInput();
  } else if( strcmp(argv[1], "--all") == 0 ) {
    scanInput();
    fseek(yyin, 0, SEEK_SET);
    yylineno = 1;
    printf("\n");  
    parseInput();
  }

  //printf("Errores léxicos: %d ", errlex);
  printf("\n\n");
  fclose(yyin);
  return 0;
}

void scanInput() {
  int token = yylex();
  while( token ){
    printf("\nLinea: %d token: %d \t lexema %s", yylineno, token, yytext);
    token = yylex();
  }
}

void parseInput() {
  yyparse();
}
