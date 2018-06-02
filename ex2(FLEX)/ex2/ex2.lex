%{
	using namespace std;
	#include <vector>
   	#include <iostream>
  	vector<char> main_vector;//where the pointer is
 	int indexArrayPointer=0;//the pointer
	
	vector<char> whileVector;
	int indexOfWhile=0;
	int counterPlusOrMinus=1;

	int lastLetterInt;
	char* inputChar={0};
	int counterOfEndBrackets=0;
	int indexOfBrackets=0;	
	vector<char> whileArray2;
	int indexOfWhile2=0;	
	void while_method(vector<char> whileVector, int index);
	int recursiveLenght(vector<char>whileVector, int index);
%}

DIGIT [0-9]
NUMBER [1-9][0-9]*|0
%x INPUT_STATE
%x PLUS_STATE
%x MINUS_STATE
%x WHILESTATE
%x WHILESTATEINPUT
%x WHILESTATE2
%x WHILESTATEINPUT2
%x GO_LEFT
%x BACK_TO_WHILESTATE
%x BACK_TO_START_WHILE
%%

[,] 		{

		BEGIN(INPUT_STATE);}
<PLUS_STATE>["+"] {counterPlusOrMinus++;}
<PLUS_STATE>["."] {
			/*cout<<"\n  one my pointer is to"<<main_vector.at(indexArrayPointer);*/
		main_vector.at(indexArrayPointer)+=counterPlusOrMinus;
		cout << main_vector.at(indexArrayPointer);
			/*cout<<"\n two my pointer is to"<<main_vector.at(indexArrayPointer);*/
		counterPlusOrMinus=1;
		BEGIN(INITIAL);}


<PLUS_STATE>["<"]	{
		if(indexArrayPointer-1<0){
			cout << "Index Out Of Range";
			return 0;}
		else{ indexArrayPointer--;}
		BEGIN(INITIAL);
}
<PLUS_STATE>[">"]	{
			if(indexArrayPointer>=main_vector.size()-1){
				main_vector.push_back('0');
			}			
			indexArrayPointer++;
			BEGIN(INITIAL); 
}
<PLUS_STATE>"["	{whileVector.push_back('[');
		indexOfWhile++;
		indexOfBrackets++;
		main_vector.at(indexArrayPointer)+=counterPlusOrMinus;
		counterPlusOrMinus=1;
		BEGIN(WHILESTATE); 
}


<PLUS_STATE>[^"+"] {
		cout<<"\nbefore "<<main_vector.at(indexArrayPointer);
		main_vector.at(indexArrayPointer)+=counterPlusOrMinus;
		cout<<"\nafter "<<main_vector.at(indexArrayPointer);
		counterPlusOrMinus=1;
		BEGIN(INITIAL);}

<MINUS_STATE>"-" {counterPlusOrMinus++;
		int num=main_vector.at(indexArrayPointer)-counterPlusOrMinus;
		if(num<0){
			cout << " case 4 Invalid – command";
			counterPlusOrMinus=1;
			return 0;
			}

}

<MINUS_STATE>["."] {
		int num=main_vector.at(indexArrayPointer)-counterPlusOrMinus;
		if(num>=0){
			main_vector.at(indexArrayPointer)-=counterPlusOrMinus;
			cout << main_vector.at(indexArrayPointer);
			counterPlusOrMinus=1;
		}
		else{cout << "case1 Invalid – command";
		}
		BEGIN(INITIAL);}

<MINUS_STATE>["<"]		{
		if(indexArrayPointer-1<0){
			cout << "Index Out Of Range";
			return 0;}
		else{ indexArrayPointer--;}

		BEGIN(INITIAL);}

<MINUS_STATE>[">"]	{
			if(indexArrayPointer>=main_vector.size()-1){
				main_vector.push_back('0');
			}
			indexArrayPointer++;
			BEGIN(INITIAL); }

<MINUS_STATE>"["	{
			whileVector.push_back('[');
			indexOfWhile++;
			indexOfBrackets++;
			main_vector.at(indexArrayPointer)-=counterPlusOrMinus;
			counterPlusOrMinus=1;
			BEGIN(WHILESTATE); 
}
<MINUS_STATE>[^"-"] {
		main_vector.at(indexArrayPointer)-=counterPlusOrMinus;
		counterPlusOrMinus=1;
		BEGIN(INITIAL);
}
<INPUT_STATE>[a-zA-z]	{
			if(main_vector.size()==0){
				main_vector.push_back(yytext[0]);
			
			}
			else if(indexArrayPointer>main_vector.size()-1){
				main_vector.push_back(yytext[0]);
				/*cout<<"case 2";*/
			}
			else {main_vector.at(indexArrayPointer)=yytext[0];
				/*cout<<"case 3";*/			
			}

			BEGIN(INITIAL);
}
<INPUT_STATE>[a-zA-z]"["	{
			if(main_vector.size()==0){
				main_vector.push_back(yytext[0]);
			
			}
			else if(indexArrayPointer>main_vector.size()-1){
				main_vector.push_back(yytext[0]);
				/*cout<<"case 2";*/
			}
			else {main_vector.at(indexArrayPointer)=yytext[0];
				/*cout<<"case 3";*/			
			}
			whileVector.push_back('[');
			indexOfWhile++;
			indexOfBrackets++;
			BEGIN(WHILESTATE);
}
<INPUT_STATE>[a-zA-z][0-9]+	{
		cout << "Unknown command";
		return 0;}
<INPUT_STATE>[A-za-z][a-zA-z]*	{
		cout << "Unknown command";
		return 0;
}


<INPUT_STATE>[0-9][0-9]*	{
		int num= atoi(yytext);

		if((num>=0)&&(num<=9)){

			main_vector.push_back((char)num+48);
			
			}
		else{
			main_vector.push_back((char)num);
			
			}

		BEGIN(INITIAL);
}


[">"]		{
		/*cout<<"\nindexArrayPointer"<<indexArrayPointer;
		cout<<"\n hi main_vector"<<main_vector.size();*/
		if(indexArrayPointer>=main_vector.size()-1){
			main_vector.push_back('0');
		}
		indexArrayPointer++; 
		
		}

["<"]		{

		if(indexArrayPointer-1<0){
			printf("Index Out Of Range");
			return 0;}
		else{ indexArrayPointer--;}
}

"-"		{
/*cout<<"\nminus main_vector.size()"<<main_vector.size(); */
		if(main_vector.size()==0){
		main_vector.push_back('0');
		cout<<"case 2Invalid – command";
			return 0;
		}
		counterPlusOrMinus=1;
		/*cout<<"indexArrayPointer"<< indexArrayPointer;*/
		int num=(int)main_vector.at(indexArrayPointer)-counterPlusOrMinus;
		/*cout<<"num"<< num;*/
		
		if(num<0){
			cout<<"case 2Invalid – command";
			return 0;
			}
		else{BEGIN(MINUS_STATE);}		
}

["+"]		{
		counterPlusOrMinus=1;
		if(main_vector.size()==0){
		main_vector.push_back('0');
		}
		BEGIN(PLUS_STATE);
}

"[" {	whileVector.push_back('[');
	indexOfWhile++;
	indexOfBrackets++;
	cout<<"start while";
 	BEGIN(WHILESTATE);
}
<WHILESTATE>"-" { 
		whileVector.push_back('-');
		indexOfWhile++;	
}
<WHILESTATE>[">"] {
		whileVector.push_back('>');
		indexOfWhile++;
}
<WHILESTATE>"." {
		whileVector.push_back('.');
		indexOfWhile++;
		}
<WHILESTATE>["+"] {
		whileVector.push_back('+');
		indexOfWhile++;
}
<WHILESTATE>["<"] {
		whileVector.push_back('<');
		indexOfWhile++;
}

<WHILESTATE>"[" {
		whileVector.push_back('[');
		indexOfWhile++;
		indexOfBrackets++;
}
<WHILESTATE>"," {
		whileVector.push_back(',');
		indexOfWhile++;
		BEGIN(WHILESTATEINPUT);
}

<WHILESTATEINPUT>[a-zA-Z] {
		whileVector.push_back(yytext[0]);
		indexOfWhile++;
		BEGIN(WHILESTATE);
}
<WHILESTATEINPUT>[0-9] {
		whileVector.push_back(yytext[0]);
		indexOfWhile++;
		BEGIN(WHILESTATE);
}

<WHILESTATE>"]" {	

		whileVector.push_back(']');
		indexOfWhile++;
		indexOfBrackets--;
		if(indexOfBrackets==0){
			/*cout<<"go to while_method(whileVector)";*/
			while_method(whileVector,1);	
			BEGIN(INITIAL);
		}
}





"." 	{


	if(main_vector.size()==0){
	cout<<"0";}
	else {
		if(indexArrayPointer>=0){
		cout  <<main_vector.at(indexArrayPointer);
		}
	}
 }

[\n]* 			{/* */}
[ ]* 			{/* */}
[^a-zA-z0-9\n" "]	{
		cout<<"Unknown command";
		return 0;
}




%%
void while_method(vector<char> whileVector, int index){
	int finish=0;			
	int i;
	while(finish!=1){
		for( i=index; i<whileVector.size(); i++){//bli first [
		/*cout<<"\n current val while"<<whileVector.at(i);*/
		if(whileVector.at(i)=='+'){
			main_vector.at(indexArrayPointer)+=1;
			/*cout<<"\nplus my new val is"<<main_vector.at(indexArrayPointer);*/
		}
		else if(whileVector.at(i)=='-'){
			/*cout<<"\n current val main_vector.size()"<<main_vector.size();
			cout<<"\n current val indexArrayPointer"<<indexArrayPointer;*/
			if(main_vector.size()<=indexArrayPointer){
				main_vector.push_back('0');
				cout<<"Invalid – command";
					return ;
			}

			int num=(int)main_vector.at(indexArrayPointer)-1;
			/*cout<<"\n num"<<num;*/
			if(num<0){
				cout<<"\nwhile minus Invalid – command";
				return ;
			}
			else{main_vector.at(indexArrayPointer)-=1;
				/*cout<<"\nminus my new val is"<<main_vector.at(indexArrayPointer);*/
				}

		}
		else if(whileVector.at(i)=='>'){
			if(indexArrayPointer>=main_vector.size()-1){
				main_vector.push_back(0);
			}
		/*cout<<"\nbefore indexArrayPointer" <<indexArrayPointer;*/
			indexArrayPointer++;
		/*cout<<"\nafter indexArrayPointer" <<indexArrayPointer;*/
		}
		else if(whileVector.at(i)=='<'){
			if(indexArrayPointer-1<0){
				printf("Index Out Of Range");
				return ;}
			else{indexArrayPointer--;
			/*cout<<"**********************";*/
			/*cout<<"\n < my pointer is to"<<main_vector.at(indexArrayPointer);*/
			}
		}
		else if(whileVector.at(i)=='.'){
		cout <<main_vector.at(indexArrayPointer);
		}
		else if(whileVector.at(i)==','){
		i++;
		main_vector.at(indexArrayPointer)=whileVector.at(i);
		/*cout<<"\n current val while"<<whileVector.at(i);*/
		}
		else if(whileVector.at(i)==']'){
			/*cout<<"\ni saw soger] this";*/
			/*cout<<"\n < my pointer is to"<<(int)main_vector.at(indexArrayPointer);*/
			if(((int)main_vector.at(indexArrayPointer)==48)||
				((int)main_vector.at(indexArrayPointer)==0)){/*zero=48*/
				finish=1;
			/*cout<<"\nprint enddddddddddd while";	*/		
			return;
			}
		i=index-1;
		/*cout<<"\nbye to this one";*/
		

		}
		else if(whileVector.at(i)=='['){
			/*cout<<"\ngo into recursia index        "<<i <<"\n";*/
			/*cout<<"first"<<whileVector.at(i);*/
			while_method(whileVector,i+1);
			/*cout<<"\ni before "<<i;*/
			i+=recursiveLenght(whileVector,i)-1;
			/*cout<<"\ni after "<<i;*/
			/*cout<<"sec"<<whileVector.at(i);*/

		}else{
			cout<<"Unknown command";
		}

	}
	}return;
}
int recursiveLenght(vector<char>whileVector, int index){
	int counter=0;
	for(int i=index; i<whileVector.size(); i++){
		counter++;		
		if(whileVector.at(i)==']'){
		return counter;
		}
	}
return counter;
}
int yywrap(){
	return 1;
}
int main(){
	yylex();

}
