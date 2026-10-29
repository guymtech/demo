%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <string.h>
%}
%option noyywrap

%%
"for"                   return FOR;
"while"                 return WHILE;
"if"                    return IF;
"else"                  return ELSE;
[0-9]+                  {yylval.num=atoi(yytext); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]*  {yylval.str=strdup(yytext); return ID;}
"="                     return ASSIGN;
"+"                     return PLUS;
"*"                     return MUL;
"<"                     return LT;
">"                     return GT;
"("                     return LP;
")"                     return RP;
"{"                     return LB;
"}"                     return RB;
";"                     return SC;
"<="                    return LE;
"++"                    return INC;
[ \t\r\n]+              ;
.                       {printf("Invalid token:%s\n",yytext);}
%%