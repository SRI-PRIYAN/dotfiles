%{
    // Roll Number: 2019103065
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
%}
%option noyywrap
%%

[a-zA-Z_][a-zA-Z0-9_]* {
    return IDENTIFIER;
}

[0-9]+ {
    yylval = atoi(yytext);
    return INTEGER;
}

[ \t] ;

.|\n { return *yytext; }

%%
int main() {
    yylex();
    return 0;
}
