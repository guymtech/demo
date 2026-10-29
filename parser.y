%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int temp=0;

    char *newtemp(void){
        char b[20];
        sprintf(b,"t%d",++temp);
        return strdup(b);
    }

    void yyerror(const char *s){
        printf("Syntax Error: %s\n",s);
    }

    int yylex(void);
%}

%union{
    int num;
    char *str;
}

%token WHILE PLUS ASSIGN MUL LP RP LB RB SC LT GT
%token <num> NUM 
%token <str> ID 
%type <str> expr

%left PLUS
%left MUL

%%
program:
    stmt_list WHILE LP{
        printf("-------THREE ADDRESS CODE-------\n L1:");
    }condition RP LB stmt_list RB{
        printf("goto L1\n");
        printf("L2:\n");
    }
    ;
condition:
    expr LT expr{
        printf("ifFalse %s<%s goto L2\n",$1,$3);
    }
    ;
stmt_list:
    stmt_list statement
    |statement
    ;

statement:
    ID ASSIGN expr SC {
        printf("%s=%s\n",$1,$3);
    }
    ;

expr:
    expr PLUS expr {
        char *t=newtemp();
        printf("%s=%s+%s\n",t,$1,$3);
        $$=t;
    }
    |expr MUL expr {
        char *t=newtemp();
        printf("%s=%s*%s\n",t,$1,$3);
        $$=t;
    }
    |LP expr RP{
        printf("(%s)\n",$2);
    }
    |NUM{
        char b[20];
        sprintf(b,"%d",$1);
        $$=strdup(b);
    }
    |ID{
        $$=$1;
    }
    ;

%%

int main(){
    if(yyparse()==0){
        printf("Compilation Sucessful\n");
    }
    return 0;
}

