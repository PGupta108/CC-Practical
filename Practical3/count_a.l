%{
#include <stdio.h>
#include <string.h>
int count = 0;
%}

%%
[Aa][a-zA-Z]*     { count++; }
[a-zA-Z0-9_]+     { }
[ \t\n]+          { }
.

%%

int main(void) {
    yylex();
    printf("Number of words starting with 'A' or 'a': %d\n", count);
    return 0;
}

