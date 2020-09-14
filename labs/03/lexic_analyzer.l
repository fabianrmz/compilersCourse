%{
#include <stdio.h>  
#include <stdio.h> 
#include <stdlib.h> 
#include <ctype.h>
//for open
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
//for close
#include <unistd.h>
%}

%%
f   {fprintf(yyout, "floatdcl");}
i   {fprintf(yyout, "intdcl");}
p   {fprintf(yyout, "print");}
[a-e]|[g-h]|[j-o]|[q-z]  {fprintf(yyout, "id");}
=   {fprintf(yyout, "assign");}
[0-9]+.[0-9]+   {fprintf(yyout, "fnum");}
[0-9]+   {fprintf(yyout, "inum");}
\+  {fprintf(yyout, "plus");}
-    {fprintf(yyout, "minus");}
\/  {fprintf(yyout, "division");}
\*   {fprintf(yyout, "multiplication");}
\/\/(.+)  {fprintf(yyout, "comments");}
%%

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