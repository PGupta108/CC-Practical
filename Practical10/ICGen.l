%{
#include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]*    { yylval.sval = strdup(yytext); return ID; }
[0-9]+                  { yylval.sval = strdup(yytext); return NUM; }
[+\-*/=();:]            { return yytext[0]; }
\n                      { return '\n'; }
[ \t]                   { /* skip whitespace */ }
.                       { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() { return 1; }

