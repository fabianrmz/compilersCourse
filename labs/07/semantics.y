%{
#include <stdio.h>
#include <stdlib.h>

%}


%token floatdcl intdcl print assign
%token plus minus division multiplication fnum inum
%left multiplication division
%left multiplication division
%type <floatNumber>fnum
%type <id>id
%type <integer>innum

%left PLUS MINUS

%%

list: /*empty */
        |
      list stat
      {printf("List -> {List, Stat}\n");}

stat:   
        ID ASSIGN expr {printf("Stat -> {%c, \"=\", Expr}\n", $1);}
        |
        INTDCL ID {printf("Stat -> {INTDCL, %c}\n", $2);}
        |
        
        FLOATDCL ID {printf("Stat -> {FLOATDCL, %c}\n",$2);}
        |
        PRINT ID {printf("Stat -> {Print, %c}\n", $2);}
        ;
expr:    '(' expr ')'
        |
        expr MULTIPLICATION expr {printf("Expr -> {Expr, \"*\" Expr}\n");}
        |
        expr DIVISION expr {printf("Expr -> {Expr, \"/\" Expr}\n");}
        |       
        expr PLUS expr {printf("Expr -> {Expr, \"+\" Expr}\n");}
        |
        expr MINUS expr {printf("Expr -> {Expr, \"-\" Expr}\n");}
        |
        ID {printf("Expr -> {%c}\n", $1)}
        |
        number {printf("Expr -> {Number}\n");}
        ;
        
number: INUM{printf("Number -> {%d}\n", $1);}
        |
        FNUM{printf("Number -> {%f}\n", $1);}
          ;

%%

extern int yylex();
extern int yyparse();
extern FILE *yyin; 


int main(int argc, char** argv) {
  if(argc < 2)
  {
    printf("Error, Missing parameters!\n");
    return 1;
  }

  FILE *fi; 
  FILE *fo; 

  fi = fopen(argv[1],"r");

  if(!fi)
  {
    printf("Error, File not found\n");
    return 1;
  }

  fo=fopen("lex.out","w"); 

  if(!fo)
  {
    printf("Error while writing file lex.out \n");
  }
  yyin = fi;
  yyout = fo;

  yylex();
  fclose(yyin);
  fclose(yyout);


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