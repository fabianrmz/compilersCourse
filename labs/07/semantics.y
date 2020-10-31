%{
#include <stdio.h>
#include <stdlib.h>
%}

%union {
int integer;
float floatNumber;
char id;
}

%token assign
%token floatdcl intdcl print ID
%token plus minus inum fnum division multiplication
%left multiplication division
%type <floatNumber>fnum
%type <id>ID
%type <integer>inum
%left plus minus

%%

list: /*empty */
        |
      list stat
      {printf("List -> {List, Stat}\n");}

stat:   
        ID assign expr {printf("Stat -> {%c, \"=\", Expr}\n", $1);}
        |
        intdcl ID {printf("Stat -> {intdcl, %c}\n", $2);}
        |
        
        floatdcl ID {printf("Stat -> {floatdcl, %c}\n",$2);}
        |
        print ID {printf("Stat -> {print, %c}\n", $2);}
        ;
expr:    '(' expr ')'
        |
        expr multiplication expr {printf("Expr -> {Expr, \"*\" Expr}\n");}
        |
        expr division expr {printf("Expr -> {Expr, \"/\" Expr}\n");}
        |       
        expr plus expr {printf("Expr -> {Expr, \"+\" Expr}\n");}
        |
        expr minus expr {printf("Expr -> {Expr, \"-\" Expr}\n");}
        |
        ID {printf("Expr -> {%c}\n", $1);}
        |
        number {printf("Expr -> {Number}\n");}
        ;
        
number: inum{printf("Number -> {%d}\n", $1);}
        |
        fnum{printf("Number -> {%f}\n", $1);}
          ;

%%

extern int yylex();
extern int yyparse();
extern FILE *yyin; 


int main(int argc, char** argv) {
  if(argc != 2)
  {
    printf("Error, Missing parameters!\n");
    return 0;
  }

  FILE *myfile = fopen(argv[1], "r");
	// make sure it is valID:
	if (!myfile) {
		printf("Error wrong file");
		return -1;
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
  /* digraph D {
  A -> {B, C, D} -> {F}
} */

  printf("digraph D {\n");
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));

  printf("}\n");

  
  return 0;
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap(){
  return(1);
}