/*Name : meital birka
ID: 311124283
group:04
user name:birkame*/
%{
	#include <stdio.h>
	#include <string>
	#include <string.h>
	#include <map>
	#include <math.h>
	#include <vector>
	using namespace std;
	int yylex();
	void yyerror(const char*);
	char buf[100];
	int pos=0;
	map<string,int> vars_map;//for regular varibales
	int errorC=0;
	map<string,int> myMapToRemember;//for the map cheacking
	int dontPrint=0;
	vector<char*> myvector;
	int indexVector=0;
%}
%left T_SEARCH
%left T_OR
%left T_AND
%left T_Equal T_NotEqual
%left '+' '-' 
%right '['  
%left '*' '/'
%left UMINUS UPLUS
%left ','
%left ':'
%left '{'



%union
{
	int int_val;
	char* str_val;

}

%token <int_val> T_INT
%token <str_val> T_NameOfVar
%token <str_val> T_VAR
%token <str_val> T_Power;
%token <str_val> T_Equal;
%token <str_val> T_NotEqual;
%token <str_val> T_AND;
%token <str_val> T_OR;
%token <str_val> T_SEARCH;
%token <str_val> T_STR
%token <str_val> T_MAP_VAR
%token <str_val> T_MAP_INT
%token <str_val> T_FOR_MAP
%token <str_val> T_FOR_MAP2

%type <int_val> expr
%type <str_val> myStr
%type <str_val> map


%right '^'

%%
lines: |
     line lines;

line: 
	expr '\n' {if ($1!=-9999999){printf("Expr = %d\n", $1); }}
	|map '\n'	
	|assign '\n'
	|myStr '\n' {char* temp=strdup("!!!!!!!!!!");
			if((strcmp($1,temp)!=0)&&(errorC!=1)){printf("Str = %s\n",$1);}
			else{printf("Error - Index out of range! \n");
				errorC=0;}}
;
map: 
	'{' '}' {}
	|'{' map '}' {
		/*printf("the variables are: \n");*/
	if(dontPrint==0){
	for (int i=0; i<indexVector; i++){
    	printf("%s : %d\n", myvector.at(i) , myMapToRemember[string(myvector.at(i))]);
		}
		}
}
	|map ',' T_VAR ':' expr   {
			int twice=0;
			//printf("The indexVarsArr %d ",indexVarsArr);
				for (map<string,int>::iterator it=myMapToRemember.begin(); it!=myMapToRemember.end(); ++it){
			if(strcmp(it->first.c_str(),$3)==0){
				printf("The key %s already exist!\n",$3);
				twice=1;
				dontPrint=1;
				break;
				}
			}
			if(twice==0){//printf("%s:%d   hi\n",$3,$5);
			//printf("%s : %d\n",$3,$5);
			myMapToRemember[string($3)]=$5;
			myvector.push_back($3);
			indexVector++;
			}
			}
	| T_VAR ':' expr{//printf("The key %s !\n",$1);
			int twice=0;
			//printf("The indexVarsArr %d ",indexVarsArr);
				for (map<string,int>::iterator it=myMapToRemember.begin(); it!=myMapToRemember.end(); ++it){
			if(strcmp(it->first.c_str(),$1)==0){
				printf("The key %s already exist!\n",$1);
				twice=1;
				dontPrint=1;
				break;
				}
			}
			if(twice==0){
			//printf("%s : %d\n",$1,$3);
			myMapToRemember[string($1)]=$3;
			myvector.push_back($1);
			indexVector++;
			}
}
		
			
;
assign:
	T_NameOfVar T_VAR '=' expr {vars_map[string($2)]=$4;}
	;
expr: expr '-' expr {$$= $1 - $3;}
	|expr '+' expr {$$= $1 + $3;}	
	|expr '*' expr {$$= $1 * $3;}
	|expr '/' expr {if($3==0){ printf("Error - Zero Division\n");
				   return 1;}
			$$= $1 / $3;}
	|expr '^' myStr { int num =atoi($3);
			$$ = (int)(pow($1,num) + 0.5); }
	|expr '^' expr { $$ = (int)(pow($1,$3) + 0.5); }
	|'{' map '}'  '[' T_STR ']' {
			int exist=0;
			for (map<string,int>::iterator it=myMapToRemember.begin(); it!=myMapToRemember.end(); ++it){
			if(strcmp(it->first.c_str(),$5)==0){
				$$=myMapToRemember[string($5)];
				exist=1;
				break;
				}
			}
			if(exist==0){
			printf("The key %s doesn't exist!\n",$5);
			$$=-9999999;
			}
				}
	|'(' expr ')' {$$= $2;}
	| '-' expr %prec UMINUS	{$$=$2*(-1);}	
	| '+' expr %prec UPLUS	{$$=$2*1;}
	|expr T_Equal expr {if($1==$3){$$= 1;}
			else{$$=0;} }
	|expr T_NotEqual expr {if($1!=$3){$$= 1;}
			else{$$=0;} }
	|expr T_AND expr {if(($1==0)||($3==0)){$$= 0;}
			else{$$=1;} }
	|expr T_OR expr {if(($1!=0)||($3!=0)){$$= 1;}
			else{$$=0;} }
	|T_INT { $$ = $1; }
	| T_VAR {//printf("hiiiiiiiiiiiiiiiiii%d",vars_map[string($1)]);
		int thereIsVar=0;
for (std::map<string,int>::iterator it=vars_map.begin(); it!=vars_map.end(); ++it){
	if(strcmp(it->first.c_str(),$1)==0){
	thereIsVar=1;
		}
}

			if(thereIsVar==1){
			$$=vars_map[string($1)];} 
		else {printf("The variable %s doesn't exist!\n",$1);$$=-9999999;}
			}
| myStr  T_SEARCH  myStr  {			//printf("myStr  T_SEARCH  myStr");
						char * longStr=$1;
						char * shortStr=$3;
						int firstIndex=-1;
						int longIndex=0;
						int shortIndex=0;
						int found=0;
		while((found==0)&&(longIndex<strlen(longStr))){
			if(longStr[longIndex]==	shortStr[shortIndex]){
				int long2index=longIndex;
				int mayBeGood =longIndex;
				int short2index=0;
				int trueVal=1;
				while((trueVal==1)&&(short2index<strlen(shortStr))){
					if(longStr[long2index]==shortStr[short2index]){
						short2index++;	long2index++;	
						}else{trueVal=0;
							long2index=0;
						}
					}
				if(trueVal==1){
				found=1;
				firstIndex=mayBeGood;
				}
			
				}
			longIndex++;
			}

					//printf("kkkkkk");
					//char str[20];
 					 //sprintf(str, "%d", firstIndex);
					//printf("hiiiiii %s",str);
					$$=firstIndex;
					
					}
	/*|myStr '+' expr {
			int num=atoi($1);
			$$= num + $3;}*/
	
	
	
;

myStr:  myStr  '+'  myStr  {		
					char * str3 = (char *) malloc(1 + strlen($1)+ strlen($3) );
			      		strcpy(str3, $1);
			      		strcat(str3, $3);
					$$=str3;
					
      					}
		|myStr '[' expr ']'	{ 
				char* src=$1;
				char *pChar; 
				int a =$3;
				int strSrc=strlen($1);			
				//printf("myStr %d",a);
				if(a>=strSrc){
				char * temp;
					for(int i=0; i<10; i++){
					temp[i]='!';
					}
					$$=strdup(temp);
				}else{
				 	//pChar[0]=;
					//pChar[1]='\0';
					string name ;
					name[0]=src[a];
					name[1]='\0';
					//printf("myStr %s",name.c_str());
					char * temp4;
					temp4=(char*)name.c_str();
					$$=temp4;
				}
				}
	|myStr '+' T_INT 	{
						int num=atoi($1);
						if(num==0){printf("Error: syntax error\n"); return 0;}
						num += $3;
						char str[20];
 					 sprintf(str, "%d", num);
					
					$$=str;
}
	
	| T_STR{ $$=$1;	 } 
	|'<' expr '>' {
			char label[100] = {"0"};
			int number = $2;
			sprintf(label,"%d",number);
			char * str3 = (char *) malloc(1 + strlen(label) );
	      		strcat(str3, label);
			$$=str3;	


}
	/*|myStr '+' '<' expr '>'	{
				char label[100] = {"0"};
   				int number = $4;
   				sprintf(label,"%d",number);
 				char * str3 = (char *) malloc(1 + strlen($1)+ strlen(label) );
			      		strcpy(str3, $1);
			      		strcat(str3, label);
					$$=str3;
					}*/
	
	|'^' myStr		{ 
				char * str3 = (char *) malloc( strlen($2) );
				char * src = $2;
				int counter3=strlen($2)-1;
				int counter1=0;
				for( counter1=0; counter1<strlen($2); counter1++){
				str3[counter3]=src[counter1];
				counter3--;
				}
				$$=str3;

				}
	|myStr '[' T_INT '.' '.' T_INT']' {	
						int start=$3;
						int end=$6;
				//printf("start%d    end %d",start,end);
				if((start>=strlen($1))||(end>=strlen($1))){
					errorC=1;
					//printf("error hereeeeeeeeee");
					
					/*char * temp3;
					for(int i3=0; i3<10; i3++){
					temp3[i3]='!';
					}
					$$=strdup(temp3);
					}*/
					
				}
				else{
					char* src1=$1;
					string name;
					int counter1=0;
					for(int i1=start; i1<=end; i1++){
					name[counter1]=src1[i1];
					counter1++;
					}
					name[counter1]='\0';
					//printf("string %s",pChar1);
					char * temp4;
					temp4=(char*)name.c_str();
					$$=temp4;

				}



				}
	
	
	|'(' myStr ')' {$$= $2;}

		
;

%%

void yyerror(const char* err){
	printf("Error: %s\n", err);
}

int main()
{
yyparse();
}
