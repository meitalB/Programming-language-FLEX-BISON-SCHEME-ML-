/*Name : meital birka
ID: 311124283
group:04
user name:birkame*/
%{
	#include "ex3.tab.h"
%}
%x MAP_STATE
INT [1-9][0-9]*|0
VAR [a-zA-Z_][a-zA-Z0-9_]*
STR \"[^\"]*\"
WS [ \t]*
Equal "=="
NotEqual "!="
AND "&&"
OR "||"
NameOfVar "var"
Search "=~"
MAP "{"
END_MAP "}"
MAP_VAR [a-zA-Z_][a-zA-Z0-9_]*:
MAP_INT [1-9][0-9]*|0
MAP_P ","
MAP_s " "

%%
{INT} {
		yylval.int_val = atoi(yytext);
		return T_INT;
		}
{STR}  { char text2[strlen(yytext)-1];
		int counter2=0;
		int i;
		 for(i=1; yytext[i]!='"'; i++)
			    {
				text2[counter2] = yytext[i];
				counter2++;
			    }

			    //Makes sure that the string is NULL terminated
			    text2[counter2] = '\0';
		//printf("fffffsssssssss    %s\n",text2);
		
	 yylval.str_val = strdup(text2);
	/*yylval.str_val = strdup(yytext);*/
	 return T_STR;}



{Search} { return T_SEARCH;}

{NameOfVar} { 	return T_NameOfVar;}
{VAR}	{yylval.str_val = strdup(yytext); 
		return T_VAR;}

{Equal}	{	return T_Equal;}
{NotEqual} {	return T_NotEqual;}
{AND}	{	return T_AND;}
{OR}	{	return T_OR;}

 /* {MAP} {		//printf("map start     ");
		BEGIN(MAP_STATE);}
<MAP_STATE>{MAP_VAR} {char text2[strlen(yytext)];
		int counter2=0;
		int i;
		 for(i=0; yytext[i]!=':'; i++)
			    {
				text2[counter2] = yytext[i];
				counter2++;
			    }

			    //Makes sure that the string is NULL terminated
			    text2[counter2] = '\0';
		//printf("ttttttt    %s\n",text2);
		
	 yylval.str_val = strdup(text2);
	return T_MAP_VAR;
			
			}
<MAP_STATE>{MAP_INT}  {
			yylval.int_val = atoi(yytext);
			return T_MAP_INT;

}
<MAP_STATE>{MAP_P} /* ignore */
 /*<MAP_STATE>{MAP_s} /* ignore */
 /* <MAP_STATE>{END_MAP} {
			//printf("      map end");			
			BEGIN(INITIAL);}*/

{WS} 	/* ignore */
.|[\n]		{return yytext[0];}
%%
int yywrap() { return 1;}
