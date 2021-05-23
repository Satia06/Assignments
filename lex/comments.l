%{
#include <stdio.h>
int comm_count = 0;
%}
%s COMMENT
%%
"/*"[^*/]*"*/" comm_count++;
\/\/.* comm_count++;
.|\n {fprintf(yyout,"%s",yytext);};
%%

void main(int argc, char *argv[]){
	if(argc!=3){
	printf("usage:./a.out input.c output.c \n");
	exit(0)
	}
	yyin = fopen(argv[1],"r");
	yyout = fopen(argv[2],"w");
	yylex()
	printf("\n Number of Comments:%d",comm_count);
	}
int yywrap(){return 1;}
