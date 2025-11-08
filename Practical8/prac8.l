
%{
#include "y.tab.h"
#include <stdlib.h>
%}

digit   [0-9]+

%%

{digit}     { yylval = atoi(yytext); return NUMBER; }
[ \t]       { /* skip whitespace */ }
\n          { return '\n'; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"("         { return '('; }
")"         { return ')'; }
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
