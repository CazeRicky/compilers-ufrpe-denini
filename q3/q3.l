%{
#include <stdio.h>
%}

%%

"if"            { printf("IF\n"); }
"while"         { printf("WHILE\n"); }
"else"          { printf("ELSE\n"); }
"return"        { printf("RETURN\n"); }

[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
"//".*                  {  } /* faz nada */
[ \t\n]+                {  } /* Ignorar */
.                       { printf("SIMBOLO %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}