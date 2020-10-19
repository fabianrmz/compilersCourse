%{
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+				{ yylval = atoi(yytext); return NUM; }
\(       {return OPENP;}
\)       {return CLOSEP;}
[ \t] ; 			/* ignore whitespace */
\n return 0; 		/* logical EOF */
. return yytext[0];
%%