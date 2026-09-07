%{
#include <stdio.h>
%}


DIGITO  [0-9]
ESPACO  [ \t]

%%

{DIGITO}+                      { printf("NUMBER %s\n", yytext); }

"<=" { printf("REL_OP <=\n"); }
">=" { printf("REL_OP >=\n"); }
"==" { printf("REL_OP ==\n"); }
"!=" { printf("REL_OP !=\n"); }
"<" { printf("REL_OP <\n"); }
">" { printf("REL_OP >\n"); }

"+"                            { printf("PLUS\n"); }
"-"                            { printf("MINUS\n"); }
"*"                            { printf("TIMES\n"); }
"/"                            { printf("DIVIDE\n"); }
"|"                            { printf("ABS\n"); }
"("                            { printf("LPAREN\n"); }
")"                            { printf("RPAREN\n"); }
"%"                            { printf("MOD\n"); }
"^"                            { printf("POWER\n"); }

\n                             { printf("NEWLINE\n"); }
{ESPACO}+                      { /* Ignora espacin e tabs de forma legivel */ }
.                              { printf("Mystery character %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}