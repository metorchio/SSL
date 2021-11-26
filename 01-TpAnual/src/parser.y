%code top {
  #include <stdio.h>
  #include "scanner.h"
  #define YYERROR_VERBOSE
}

%code provides {
  extern int errlex;
	extern int yynerrs;
  int yylex();
  void yyerror(char const *s);
}

%define api.value.type{char *}
%define parse.error verbose

%token OP_MENOR OP_MAYOR OP_ASIGNACION OP_SUMA OP_RESTA OP_MULTIPLICACION OP_PARENTESIS_ABIERTO OP_PARENTESIS_CERRADO OP_BLOQUE_ABIERTO OP_BLOQUE_CERRADO OP_FIN_DE_LINEA OP_SEPARADOR_PARAM IF ELSE RETURN INT BOOL ESTADO_BOOL IDENTIFICADOR CONSTANTE MAIN OP_IGUAL OP_AND OP_OR OP_DISTINTO OP_NEGACION

%left OP_SUMA OP_RESTA
%left OP_MULTIPLICACION


%start programa

%%

programa		                : principal | principal funciones {if(yynerrs || errlex) YYABORT; else YYACCEPT;};

funciones                   : funciones crearmetodo | crearmetodo ;

principal                   : INT MAIN OP_PARENTESIS_ABIERTO OP_PARENTESIS_CERRADO bloquecodigo;

bloquecodigo                : OP_BLOQUE_ABIERTO lineascodigos OP_BLOQUE_CERRADO;

lineascodigos               : lineascodigo | ;

lineascodigo                : lineascodigo linea | linea;

linea                       : invocarmetodo OP_FIN_DE_LINEA  
                              | crearvariable OP_FIN_DE_LINEA  
                              | cambiarvalor OP_FIN_DE_LINEA  
                              | condicional 
                              | error OP_FIN_DE_LINEA { yyerrok; };

invocarmetodo               : IDENTIFICADOR OP_PARENTESIS_ABIERTO parametrosenvio OP_PARENTESIS_CERRADO OP_FIN_DE_LINEA;

parametrosenvio             : paramenvio | ;

paramenvio                  : paramenvio OP_SEPARADOR_PARAM valor | valor;

valor                       : IDENTIFICADOR 
                              | CONSTANTE
                              | ESTADO_BOOL;


tipodedato                  : INT | BOOL ;

crearvariable               : tipodedato IDENTIFICADOR
                              | tipodedato IDENTIFICADOR asignarvalor
                              ; 

asignarvalor                  : OP_ASIGNACION invocarmetodo 
                                | OP_ASIGNACION expresionaritmetica;

expresionaritmetica         : termino 
                              | expresionaritmetica OP_SUMA termino 
                              | expresionaritmetica OP_RESTA termino;

termino                     : factor 
                              | termino OP_MULTIPLICACION factor;

factor                      : valor 
                              | OP_PARENTESIS_ABIERTO expresionaritmetica OP_PARENTESIS_CERRADO;

cambiarvalor                : IDENTIFICADOR asignarvalor
                              ;

condicion                   : valor operacionbool valor | valor;

condicional                 : condicionsi | condicionsi condicionno ;

condicionno                 : ELSE bloquecodigo;

condicionsi                 : IF OP_PARENTESIS_ABIERTO condicion OP_PARENTESIS_CERRADO bloquecodigo 
                              ;

operacionbool               : OP_NEGACION | OP_MAYOR | OP_MENOR | OP_IGUAL | OP_AND | OP_DISTINTO;

crearmetodo                 : tipodedato IDENTIFICADOR parametrosentrada bloquecodigo
                              | error bloquecodigo { yyerrok; } ;

parametrosentrada           : OP_PARENTESIS_ABIERTO parametros OP_PARENTESIS_CERRADO 
                              | OP_PARENTESIS_ABIERTO OP_PARENTESIS_CERRADO;

parametros                  : parametros OP_SEPARADOR_PARAM parametro | parametro ;

parametro                   : tipodedato IDENTIFICADOR ;

%%

void yyerror(char const *s){
		printf("\nLínea #%d  \t %s", yylineno, s);
}