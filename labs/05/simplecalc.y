// E -> T | T  + E
// T -> int | int * T| ( E )

%{
#include <stdio.h>
%}

%token NUM OPENP CLOSEP
%left '*'
%left '+'
%%

expression:  T
            {
              $$ = $1;
            }
            |
            T '+' expression
            {
              $$ = $1 + $3;
            } 
            ;
T:  OPENP expression CLOSEP
            {
              $$ = ($2);
        
            }
            | NUM '*' expression
            {
              $$ = $1 * $3;
            }
            | NUM 
            ;
%%
main(){
  if(yyparse()!=0){
    return 1;
  }
  printf("Parse sucessful\n");
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap(){
  return(1);
}