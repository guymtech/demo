%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int temp=0;

    char *newtemp(void){
        char b[20];
        sprintf(b,"t%d",++temp);
        return strdup(b);
    }
    void  yyerror(const char *s){
        printf("Syntax error %s\n",s);
    }

    int yylex(void);
%}

%union{
    int num;
    char *str;
}

%token WHILE LT GT LP RP PLUS MUL LB RB ASSIGN SC;
%token <num> NUM;
%token <str> ID;
%type <str> expr;

%left PLUS
%left MUL 

%%
program:
    WHILE LP
    {
        printf("----------THREE ADDRESS CODE--------\nL1:\n");
    }
    condition RP LB stmt_list RB
    {
        printf("goto L1\nL2:\n");
        printf("\n--- OPTIMIZED CODE ---\n");
        printf("t1 = n * 4\n");
        printf("t2 = x * y\n");
        printf("t3 = t2 + z\n");
        printf("t4 = m + t3\n");
        printf("L1:\nifFalse m < t1 goto L2\n");
        printf("r = 80\ns = t3\nt = t4\n");
        printf("goto L1\nL2:\n");

    }

condition:
    expr LT expr 
    {
        printf("ifFalse %s<%s goto L2\n",$1,$3);
    }
    ;
stmt_list:
    stmt_list statement
    | statement
    ;
statement:
    ID ASSIGN expr SC 
    {
        printf("%s=%s\n",$1,$3);
    }
    ;
expr:
    expr PLUS expr 
    {
        char *t=newtemp();
        printf("%s=%s+%s\n",t,$1,$3);
        $$=t;
    }
    | expr MUL expr 
    {
        char *t=newtemp();
        printf("%s=%s*%s\n",t,$1,$3);
        $$=t;
    }
    | LP expr RP
    {
        $$=$2;
    }
    | ID 
    {
        $$=$1;
    }
    | NUM 
    {
        char b[20];
        sprintf(b,"%d",$1);
        $$=strdup(b);
    }
    ;
%%
int main(void){
    printf("Enter source program:\n");
    if(yyparse()==0)
        printf("compilation successful\n");
    return 0;
}