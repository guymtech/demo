%{
    #include "y.tab.h"
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
%}

%option noyywrap

%%
"while"                     return WHILE;
[0-9]+                      {yylval.num=atoi(yytext); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]*       {yylval.str=strdup(yytext); return ID;}
"+"                         return PLUS;
"*"                         return MUL;
"<"                         return LT;
">"                         return GT;
"="                         return ASSIGN;
"("                         return LP;
")"                         return RP;
"{"                         return LB;
"}"                         return RB;
";"                         return SC;
[ \t\r\n]+                  ;
"."                         {printf("Unknown Lexical Character %s\n",yytext);}
%% 