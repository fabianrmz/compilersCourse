
%{
#include <stdio.h>  
#include "y.tab.h"
#include <string.h>
%}

comments \/\/(.+)
id [a-e]|[g-h]|[j-o]|[q-z]
inuum [0-9]+
fnuum [0-9]+.[0-9]+

%%
f  {return floatdcl;}
i  {return intdcl;}
p  {return print;}
{id}  {yylval.id = yytext[0]; return ID;}
"="  {return assign;}
{inuum}  {yylval.integer = atoi(yytext); return inum;}
{fnuum}  {yylval.floatNumber = atof(yytext); return fnum;}
"+"   {return plus;}
"-"    {return minus;}
"/"  {return division;}
"*"  {return multiplication;}
{comments} ;
%%