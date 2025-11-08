%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
int printedHeader = 0; // flag to print header only once

char* newTemp() {
    char* temp = malloc(8);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

void printHeader() {
    if (!printedHeader) {
        printf("\nThree Address Code:\n");
        printedHeader = 1;
    }
}

void yyerror(const char* s) {
    printf("Error: %s\n", s);
}

int yylex();
%}

%union {
    char* sval;
}

%token <sval> ID NUM
%type <sval> E T F

%%
program : stmt_list
        ;

stmt_list : stmt_list stmt
          | stmt
          ;

stmt : ID '=' E '\n'  { printHeader(); printf("%s = %s\n", $1, $3); }
     | ID '=' E        { printHeader(); printf("%s = %s\n", $1, $3); }
     ;

E : E '+' T {
        char* t = newTemp();
        printHeader();
        printf("%s = %s + %s\n", t, $1, $3);
        $$ = t;
    }
  | E '-' T {
        char* t = newTemp();
        printHeader();
        printf("%s = %s - %s\n", t, $1, $3);
        $$ = t;
    }
  | T { $$ = $1; }
  ;

T : T '*' F {
        char* t = newTemp();
        printHeader();
        printf("%s = %s * %s\n", t, $1, $3);
        $$ = t;
    }
  | T '/' F {
        char* t = newTemp();
        printHeader();
        printf("%s = %s / %s\n", t, $1, $3);
        $$ = t;
    }
  | F { $$ = $1; }
  ;

F : '(' E ')' { $$ = $2; }
  | ID { $$ = $1; }
  | NUM { $$ = $1; }
  ;

%%

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}

