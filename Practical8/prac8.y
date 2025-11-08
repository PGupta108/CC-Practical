%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token NUMBER
%token PLUS MINUS MUL DIV

%left PLUS MINUS
%left MUL DIV
%left '(' ')'

%%

input:
      /* empty */
    | input line
    ;

line:
      expr '\n'        { printf("Result = %d\n", $1); }
    | error '\n'       { yyerror("Invalid expression, try again."); yyerrok; }
    ;

expr:
      expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr MUL expr    { $$ = $1 * $3; }
    | expr DIV expr    {
                          if ($3 == 0) {
                              yyerror("Division by zero");
                              $$ = 0;
                          } else {
                              $$ = $1 / $3;
                          }
                       }
    | '(' expr ')'     { $$ = $2; }
    | NUMBER           { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Desk Calculator (enter expressions, Ctrl+D to quit)\n");
    yyparse();
    return 0;
}







