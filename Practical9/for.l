
%{
#include "y.tab.h"
#include <string.h>
%}

%%

"for"           { return FOR; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LTE; }
">="            { return GTE; }
"="             { return ASSIGN; }
"++"            { return INC; }
"--"            { return DEC; }
";"             { return SEMI; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
[0-9]+          { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
[ \t\n]         { /* skip whitespace */ }
.               { return yytext[0]; }

%%

int yywrap() { return 1; }

