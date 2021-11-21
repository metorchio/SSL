### Para el scanner ejecutar:

flex scanner.l

gcc -o scanner_prueba scanner.c -lfl

./scanner_prueba input.txt



### Ejecutar:
flex scanner.l
bison parser.y
gcc -Wall *.c -o compilador -lfl

