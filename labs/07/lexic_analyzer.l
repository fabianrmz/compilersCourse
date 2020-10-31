
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
#include "y.tab.h"
#include <string.h>
%}

%%
f   {return floatdcl;}
i   {return intdcl;}
p   {return print;}
[a-e]|[g-h]|[j-o]|[q-z]  {yylval.id = yytext[0]; return id;}
=   {return assign;}
[0-9]+.[0-9]+   {yylval.floatNumber = atof(yytext); return ifloat;}
[0-9]+   {yylval.integer = atoi(yytext); return inum;}
\+  {return plus;}
-    {return minus;}
\/  {return division;}
\*   {return multiplication;}
\/\/(.+) ;
%%
