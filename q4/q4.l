%{
#include <stdio.h>
#include <stdlib.h> 
%}

%%

"else"                  { printf("ELSE\n"); }
"if"                    { printf("IF\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }
"//".*                  {  } 

[ \t\n]+                {  }
.                       { printf("SIMBOLO %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char **argv) {
    /* (a) */
    if (argc < 2) {
        fprintf(stderr, "Erro: Uso correto: %s <nome_do_arquivo>\n", argv[0]);
        exit(1);
    }

    /* (b) */
    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        exit(1);
    }


    yyin = arquivo;


    yylex();

    fclose(arquivo); 
    return 0;
}