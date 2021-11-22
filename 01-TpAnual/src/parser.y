%{
  #include <stdio.h>
  int yylex();
  void yyerror(const char* s);  

%}

%union {
  int valor_entero;
}

%token OP_MENOR OP_MAYOR OP_ASIGNACION OP_SUMA OP_RESTA OP_MULTIPLICACION OP_PARENTESIS_ABIERTO OP_PARENTESIS_CERRADO OP_BLOQUE_ABIERTO OP_BLOQUE_CERRADO OP_FIN_DE_LINEA OP_SEPARADOR_PARAM IF ELSE RETURN WHILE INT BOOL ESTADO_BOOL IDENTIFICADOR CONSTANTE

%left OP_SUMA OP_RESTA
%left OP_MULTIPLICACION

%start programa

%%

programa		                : principal | principal funciones;

principal                   : INT MAIN OP_PARENTESIS_ABIERTO OP_PARENTESIS_CERRADO bloquecodigo;

bloquecodigo                : OP_BLOQUE_ABIERTO lineascodigo OP_BLOQUE_CERRADO;

lineascodigos               : lineascodigo |;

lineascodigo                : lineascodigo linea | linea;

linea                       : invocarmetodo OP_FIN_DE_LINEA 
                              | crearvariable OP_FIN_DE_LINEA 
                              | cambiarvalor OP_FIN_DE_LINEA 
                              | crearmetodo OP_FIN_DE_LINEA;

parametros                  : OP_PARENTESIS_ABIERTO parametro OP_PARENTESIS_CERRADO;

invocarmetodo               : IDENTIFICADOR parametros OP_FIN_DE_LINEA;

valor                       : IDENTIFICADOR 
                              | CONSTANTE;

parametro                   : valor
                              | parametro OP_SEPARADOR_PARAM parametro
                              | ;

tipodedato                  : INT | BOOL;

crearvariable               : tipodedato IDENTIFICADOR 
                              | tipodedato IDENTIFICADOR asignarvalor; 

asignarvalor                : OP_ASIGNACION valor 
                              | OP_ASIGNACION asignacion;

asignacion                  : invocarmetodo | aritmetico;

aritmetico                  : operacioncomun | operacioncomun operacionconresto;

operacioncomun              : valor operacionmat valor;

operacionconresto           : opcomun | operacionconresto opcomun;

opcomun                     : operacionmat valor;

operacionmat                : OP_SUMA | OP_RESTA | OP_MULTIPLICACION;

cambiarvalor                : IDENTIFICADOR asignarvalor;

operacioncomunbool          : valor operacionbool valor;

operacionconrestobool       : opbool | operacionconrestobool opbool;

opbool                      : operacionbool valor;

operacionbool               : OP_MAYOR | OP_MENOR | OP_IGUAL | OP_AND | OP_OR | OP_DISTINTO;

aritmeticobool              : operacioncomunbool | operacioncomunbool operacionconrestobool;

condicionsi                 : IF OP_PARENTESIS_ABIERTO aritmeticobool OP_PARENTESIS_CERRADO bloquecodigo;

condicionno                 : ELSE bloquecodigo;

condicional                 : condicionsi | condicionsi condicionno ;

crearmetodo                 : tipodedato IDENTIFICADOR parametros bloquecodigo;


