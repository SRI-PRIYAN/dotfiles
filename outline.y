%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"

    int yylex();
    void yyerror(char *msg);
%}
%token IDENTIFIER
%token INTEGER
%%



%%
int main() {
    while (1) yyparse();

    return 0;
}
void yyerror(char *msg) {
    exit(1);
}
