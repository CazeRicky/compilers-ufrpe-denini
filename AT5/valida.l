%{
#include "valida.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%

[ \t\n\r]+              { /* Ignora espaços, tabulações e quebras de linha */ }

"true"                  { return TRUE_TOK; }
"false"                 { return FALSE_TOK; }
"null"                  { return NULL_TOK; }

/* Strings: aspas duplas, sem quebras de linha ou aspas duplas no interior */
\"[^\"\n]*\"            { return STRING_TOK; }

/* Números: sinal opcional, parte inteira obrigatória, parte fracionária opcional */
-?(0|[1-9][0-9]*)(\.[0-9]+)? { return NUMBER_TOK; }

"{"                     { return '{'; }
"}"                     { return '}'; }
"["                     { return '['; }
"]"                     { return ']'; }
":"                     { return ':'; }
","                     { return ','; }

.                       { return ERROR_TOK; }

%%
