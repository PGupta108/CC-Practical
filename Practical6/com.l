%{
#include <stdio.h>
int line_num = 0;
int found = 0;
%}

%%
.*\.com$    {
                found = 1;
                printf("Line %d: %s\n", line_num, yytext);
            }
.*\n       { line_num++; }
.|\n       { line_num++; }
%%

int main() {
    printf("Enter text lines (Ctrl+D to end):\n");
    yylex();
    if (!found) {
        printf("not found\n");
    }
    return 0;
}
