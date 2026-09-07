%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;
%}

%token TRUE_TOK FALSE_TOK NULL_TOK STRING_TOK NUMBER_TOK ERROR_TOK

%%

inicio:
    valor
    ;

valor:
    STRING_TOK
    | NUMBER_TOK
    | TRUE_TOK
    | FALSE_TOK
    | NULL_TOK
    | objeto
    | array
    ;

objeto:
    '{' '}'
    | '{' membros '}'
    ;

membros:
    par
    | membros ',' par
    ;

par:
    STRING_TOK ':' valor
    ;

array:
    '[' ']'
    | '[' elementos ']'
    ;

elementos:
    valor
    | elementos ',' valor
    ;

%%

void yyerror(const char *s) {
    printf("JSON COM ERRO\n");
    exit(0);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            printf("JSON COM ERRO\n");
            return 0;
        }
        yyin = f;
    }
    
    if (yyparse() == 0) {
        printf("JSON OK\n");
        return 0;
    } else {
        printf("JSON COM ERRO\n");
        return 0;
    }
}
