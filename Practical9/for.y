
%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
    int num;
}

%token <str> ID
%token <num> NUM
%token FOR LT GT ASSIGN INC DEC LTE GTE SEMI LPAREN RPAREN LBRACE RBRACE

%%

program:
    for_loop
    ;

for_loop:
    FOR LPAREN init SEMI cond SEMI update RPAREN statement_opt
    { printf("Valid for loop syntax\n"); }
    ;

init:
    ID ASSIGN NUM
    ;

cond:
    ID LT NUM
    | ID GT NUM
    | ID LTE NUM
    | ID GTE NUM
    ;

update:
    ID INC
    | ID DEC
    ;

statement_opt:
    /* empty */
    | statement
    ;

statement:
    LBRACE RBRACE
    | SEMI
    | LBRACE statements RBRACE
    ;

statements:
    statement
    | statements statement
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main() {
    printf("Enter your for loop:\n");
    yyparse();
    return 0;
}
