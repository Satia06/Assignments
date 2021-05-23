%{
#include <stdio.h>
#include <string.h>
int char_count = 0,word_count = 0,space_count = 0,line_count = 0;
%}
%%
.|([ ])|\t  char_count++;	printf("No of characters:%d\n",char_count);
([a-zA-Z0-9])*  word_count++ ;      printf("No of words:%d\n",word_count);
([ ])+ space_count++ ;       printf("No of spaces:%d\n",space_count);
\n line_count++ ;   printf("No of lines:%d\n",line_count);

%%
int yywrap(void){
return 1;
}
int main(int argc, char *argv[]){
	yyin = fopen(argv[1],"r");
	yylex();
	
	/*printf("No of words:%d\n",word_count);
	printf("No of characters:%d\n",char_count);
	printf("No of spaces:%d\n",space_count);
	printf("No of lines:%d\n",line_count);*/
	return 0;
}
	
