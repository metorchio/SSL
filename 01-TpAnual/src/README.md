### Para el scanner, ejecutar:

flex scanner.l

gcc -o scanner_prueba scanner.c -lfl

./scanner_prueba input.txt --parse

### Para el parser, ejecutar:

bison -d -o parser.c parser.y

gcc -o parser_prueba parser.c -lfl


### Ejecutar:
flex scanner.l

gcc -Wall *.c -o compilador -lfl



-----------
  if( argv[2] == "--scan" ){
    int token = yylex();
    while( token ){
      printf("Linea: %d token: %d \t lexema %s \n", yylineno, token, yytext);
      token = yylex();
    }
  } else if( argv[2] == "--parse" ) {
    yyparse();
  }