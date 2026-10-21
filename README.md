bison -dy compiler.y
flex lexer.l
gcc y.tab.c lex.yy.c -o compiler -lfl
./compiler
