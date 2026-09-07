%{
int linha = 0;
int pontuacao = 0;
int palavra = 0;
int integers = 0;
int floats = 0;
int chars = 0;
%}

%%

[a-zA-Z]+               { palavra++; chars += yyleng; }
.                       { chars += yyleng; }
[0-9]+\.[0-9]+          { floats++; chars += yyleng; }
[.,;:!?]                { pontuacao++; chars += yyleng; }
\n                      { linha++; chars += yyleng; }
[0-9]+                  { integers++; chars += yyleng; }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    printf("linha: %d\n", linha);
    printf("palavra: %d\n", palavra);
    printf("chars: %d\n", chars);
    printf("integers: %d\n", integers);
    printf("floats: %d\n", floats);
    printf("pontuacao: %d\n", pontuacao);
    return 0;
}