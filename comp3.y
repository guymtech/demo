
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int temp = 0;
    int label = 0;

    char *newtemp() {
        char b[20];
        sprintf(b, "t%d", ++temp);
        return strdup(b);
    }

    void yyerror(const char *s) {
        printf("Syntax error: %s\n", s);
    }

    int yylex();
%}

%union {
    int num;
    char *str;
}

%token IF ELSE LP RP LB RB LT GT LE SC ASSIGN PLUS MUL
%token <num> NUM
%token <str> ID

%type <str> expr cond

%left PLUS
%left MUL

%%

program:
    stmt
    ;

stmt:
    IF LP cond RP
    {
        printf("ifFalse %s goto L%d\n", $3, ++label);
    }
    LB stmt_list RB
    {
        printf("L%d:\n", label);
    }
    |
    IF LP cond RP
    {
        printf("ifFalse %s goto L%d\n", $3, label + 1);
        label++;
    }
    LB stmt_list RB ELSE
    {
        printf("goto L%d\n", label + 1);
        printf("L%d:\n", label);
        label++;
    }
    LB stmt_list RB
    {
        printf("L%d:\n", label);
        label++;
    }
    ;

stmt_list:
    stmt_list statement
    | statement
    ;

statement:
    ID ASSIGN expr SC
    {
        printf("%s=%s\n", $1, $3);
    }
    ;

cond:
    ID LT expr
    {
        char *t = malloc(100);
        sprintf(t, "%s<%s", $1, $3);
        $$ = t;
    }
    | ID GT expr
    {
        char *t = malloc(100);
        sprintf(t, "%s>%s", $1, $3);
        $$ = t;
    }
    ;

expr:
    expr PLUS expr
    {
        char *t = newtemp();
        printf("%s=%s+%s\n", t, $1, $3);
        $$ = t;
    }
    | expr MUL expr
    {
        char *t = newtemp();
        printf("%s=%s*%s\n", t, $1, $3);
        $$ = t;
    }
    | ID
    {
        $$ = $1;
    }
    | NUM
    {
        char *t = malloc(20);
        sprintf(t, "%d", $1);
        $$ = t;
    }
    ;

%%

int main() {
    printf("THREE ADDRESS CODE\n");
    return yyparse();
}
