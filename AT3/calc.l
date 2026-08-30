%{
#include "calc.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

[ \t]                   { /* Ignora espaços em branco e tabulações */ }

"printar_variaveis"     { return PRINT_VARS; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.texto_val = strdup(yytext); return IDENTIFIER; }

[1-9]+(\.[1-9]+)?       { yylval.real_val = atof(yytext); return NUMBER; }

">>>>"                  { return ASSIGN; }
"**"                    { return POWER; }

"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"("                     { return '('; }
")"                     { return ')'; }
"\n"                    { return '\n'; }

.                       { /* Ignora outros caracteres */ }

%%