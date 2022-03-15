%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define MAXWORD 10005
#define MAXTEXT 32
#define MAXTYPE 100
int error=0;
struct {
    char a[MAXTEXT];
    char type[MAXTYPE];
    int line;
    int flag;
} words[MAXWORD];
int num=0;
%}
%option yylineno
INT_DEX [1-9][0-9]*|[0]
INT_HEX [0][Xx]([1-9][0-9]*|[0])
INT_OCT [0][0-7]
FLOAT [0-9]*[.][0-9]+([eE][+-]?[0-9]*|[0])?f?
ID ([_|a-z|A-Z][_|a-z|A-Z|0-9]*){0,32}
SEMI [;]
COMMA [,]
ASSIGNOP [=]
RELOP [>]|[<]|[>][=]|[<][=]|[=][=]|[!][=](^[=])
PLUS [+]
MINUS [-]
STAR [*]
DIV [/]
AND [&][&]
OR [|][|]
DOT [.]
NOT [!]
TYPE int|float
LP \(
RP \)
LB \[
RB \]
LC \{
RC \}
STRUCT struct
RETURN return
IF if
ELSE else 
WHILE while
SPACE [ \n\r]+
NOTE \/\/.*
ERROR_ID ([0-9][_|a-z|A-Z|0-9]*){0,32}
%%
{SEMI} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"SEMI: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{COMMA} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"COMMA: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{ASSIGNOP} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"ASSIGNOP: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{INT_DEX} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"INT_DEX: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{INT_HEX} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"INT_HEX: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{INT_OCT} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"INT_OCT: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{FLOAT} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"FLOAT: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{PLUS} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"PLUS: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{MINUS} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"MINUS: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{DIV} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"DIV: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{STAR} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"STAR: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{RELOP} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"RELOP: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{AND} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"AND: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{OR} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"OR: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{NOT} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"NOT: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{DOT} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"DOT: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{STRUCT} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"STRUCT: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{RETURN} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"RETURN: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{IF} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"IF: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{ELSE} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"ELSE: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{WHILE} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"WHILE: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{TYPE} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"TYPE: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{LP} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"LP: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{RP} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"RP: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{LB} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"LB: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{RB} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"RB: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{LC} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"LC: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{RC} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"RC: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{SPACE} {/*printf("LINE: %d This is a space:%s\n",yylineno,yytext);*/}

{ID} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"ID: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{NOTE} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"NOTE: ");
words[num].flag=1;
words[num].line=yylineno;
num++;
}

{ERROR_ID} {
strcpy(words[num].a,yytext);
strcpy(words[num].type,"ERROR_ID: ");
words[num].flag=2;
words[num].line=yylineno;
num++;
error=1;
}

. {strcpy(words[num].a,yytext);
words[num].flag=0;
words[num].line=yylineno;
num++;
error=1;
}
%%
int yywrap() {
  return 1;
}
int main(int argc, char** argv) {
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {   
            perror(argv[1]);
            return 1;
        }
    }
    while (yylex());
    for(int i=0;i<num;i++)
    {
        if(error==1){
            if(words[i].flag==0)
                printf("Error type A at Line %d: Mysterious characters %s \n",words[i].line,words[i].a);
            if(words[i].flag==2)
                printf("Error type A at Line %d: invalid ID %s \n",words[i].line,words[i].a);
        }
        else{
            printf("%s%s\n",words[i].type,words[i].a);
        }
    }
    return 0;
}


