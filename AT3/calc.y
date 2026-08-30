%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;

struct Variavel {
    char *name;
    double value;
};

#define MAX_VARS 1024
struct Variavel variaveis[MAX_VARS];
int total_variaveis = 0;

int buscar_variavel(const char *name) {
    for (int i = 0; i < total_variaveis; i++) {
        if (strcmp(variaveis[i].name, name) == 0) {
            return i;
        }
    }
    return -1;
}

void definir_variavel(const char *name, double val) {
    int idx = buscar_variavel(name);
    if (idx != -1) {
        variaveis[idx].value = val;
    } else {
        if (total_variaveis < MAX_VARS) {
            variaveis[total_variaveis].name = strdup(name);
            variaveis[total_variaveis].value = val;
            total_variaveis++;
        }
    }
}

double obter_valor_variavel(const char *name) {
    int idx = buscar_variavel(name);
    if (idx != -1) {
        return variaveis[idx].value;
    }
    return 0.0;
}

void imprimir_variaveis() {
    for (int i = 0; i < total_variaveis; i++) {
        printf("%s >>> %g\n", variaveis[i].name, variaveis[i].value);
    }
}

void liberar_variaveis() {
    for (int i = 0; i < total_variaveis; i++) {
        free(variaveis[i].name);
    }
}
%}

%union {
    double real_val;
    char *texto_val;
}

%destructor { free($$); } <texto_val>

%token <real_val> NUMBER
%token <texto_val> IDENTIFIER
%token ASSIGN ">>>"
%token POWER "**"
%token PRINT_VARS "printar_variaveis"

%type <real_val> exp

/* Precedência dos operadores: do mais fraco para o mais forte */
%left '+' '-'
%left '*' '/'
%right POWER
%nonassoc UMINUS

%%

input:
    /* vazio */
    | input line
    ;

line:
    '\n'
    | exp '\n'                          { printf("= %g\n", $1); }
    | IDENTIFIER ASSIGN exp '\n'        { definir_variavel($1, $3); free($1); }
    | PRINT_VARS '\n'                  { imprimir_variaveis(); }
    | exp                               { printf("= %g\n", $1); }
    | IDENTIFIER ASSIGN exp             { definir_variavel($1, $3); free($1); }
    | PRINT_VARS                        { imprimir_variaveis(); }
    ;

exp:
    NUMBER                              { $$ = $1; }
    | IDENTIFIER                        { $$ = obter_valor_variavel($1); free($1); }
    | exp '+' exp                       { $$ = $1 + $3; }
    | exp '-' exp                       { $$ = $1 - $3; }
    | exp '*' exp                       { $$ = $1 * $3; }
    | exp '/' exp                       { $$ = $1 / $3; }
    | exp POWER exp                     { $$ = pow($1, $3); }
    | '-' exp %prec UMINUS              { $$ = -$2; }
    | '(' exp ')'                       { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            fprintf(stderr, "Erro ao abrir o arquivo %s\n", argv[1]);
            return 1;
        }
        yyin = f;
    }
    yyparse();
    liberar_variaveis();
    return 0;
}