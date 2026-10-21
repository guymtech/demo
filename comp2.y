%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int temp=0;

    char *newtemp(){
        char b[20];
        sprintf(b,"t%d",++temp);
        return strdup(b);
    }
    void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
    }
    int yylex();
%}

%union{
    int num;
    char *str;
}

%token FOR LP RP LB RB LT GT LE SC ASSIGN PLUS MUL INC WHILE

%token <num> NUM
%token <str> ID

%type <str> expr
%type <str> oper

%left PLUS
%left MUL 

%%
program:
    FOR LP
    {
        printf("----------THREE ADDRESS CODE-------\n");
    }
    condition RP LB stmt_list RB
    {
        printf("goto L1\nL2:\n");
    }
    ;
condition:
    ID ASSIGN expr SC ID oper expr SC ID INC
    {
        printf("%s=%s\n",$1,$3);
        printf("L1:\n");
        printf("ifFalse %s%s%s goto L2\n",$5,$6,$7);
        printf("%s++\n",$9);
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
oper:
    LT{
        $$="<";
    }
    | LE
    {
        $$="<=";
    }
    |GT{
        $$=">";
    }
    ;
expr:
    expr PLUS expr
    {
        char *t=newtemp();
        printf("%s=%s+%s\n",t,$1,$3);
        $$=t ;
    }
    | expr MUL expr
    {
        char *t=newtemp();
        printf("%s=%s*%s\n",t,$1,$3);
        $$=t ;
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

int main(){
    if(yyparse()==0){
        printf("sucessfully compiled\n");
    }
}




