%{
#include <stdio.h>
#include <string.h>

int comment_count = 0, keyword_count = 0, identifier_count = 0;
int word_count = 0, line_count = 0, space_count = 0;

char *keywords[] = {
    "int", "float", "char", "return", "if", "else", "while", "for", "void", "main", NULL
};

int is_keyword(const char* word) {
    for (int i = 0; keywords[i] != NULL; i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
COMMENT_SINGLE \/\/[^\n]*
COMMENT_MULTI  \/[*][^*]*[*]+([^/*][^*]*[*]+)*\/
WORD           [a-zA-Z]+

%%
{COMMENT_SINGLE}   { comment_count++; }
{COMMENT_MULTI}    { comment_count++; }
{IDENTIFIER}       {
                    if (is_keyword(yytext))
                        keyword_count++;
                    else
                        identifier_count++;
                    word_count++;
                  }
[ \t]+             { space_count += yyleng; }
\n                 { line_count++; }
.                  { /* Ignore other characters */ }
%%

int yywrap() {
    return 1;
}
int main() {
    printf("Enter your code below (Ctrl+D to finish):\n\n");
    yylex();
    printf("\n==== Token Counts ====\n");
    printf("Comments     : %d\n", comment_count);
    printf("Keywords     : %d\n", keyword_count);
    printf("Identifiers  : %d\n", identifier_count);
    printf("Words        : %d\n", word_count);
    printf("Lines        : %d\n", line_count);
    printf("Spaces       : %d\n", space_count);
    return 0;
}
