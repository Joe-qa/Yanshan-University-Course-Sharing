%{
#include<unistd.h>
#include<stdio.h>   
#include "gramtree.h"
int error=0;
%}

%union{
struct ast* a;
double d;
}
/*declare tokens*/
%token  <a> INTEGER FLOAT
%token <a> TYPE STRUCT RETURN IF ELSE WHILE ID SPACE SEMI COMMA ASSIGNOP RELOP PLUS
MINUS STAR DIV AND OR DOT NOT LP RP LB RB LC RC AERROR
%token <a> EOL
%type  <a> Program ExtDefList ExtDef ExtDecList Specifire StructSpecifire 
OptTag  Tag VarDec  FunDec VarList ParamDec Compst StmtList Stmt DefList Def DecList Dec Exp Args

/*priority*/
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT 
%left LP RP LB RB DOT
%%

Program:|ExtDefList {$$=newast("Program",1,$1);
if(error==0){
printf("打印syntax tree:\n");
eval($$,0);
printf("syntax tree打印完毕!\n\n");}
}
    ;
ExtDefList:ExtDef ExtDefList {$$=newast("ExtDefList",2,$1,$2);}
	| {$$=newast("ExtDefList",0,-1);}
	;
ExtDef:Specifire ExtDecList SEMI    {$$=newast("ExtDef",3,$1,$2,$3);}    
	|Specifire SEMI	{$$=newast("ExtDef",2,$1,$2);}
	|Specifire FunDec Compst	{$$=newast("ExtDef",3,$1,$2,$3);}
	;
ExtDecList:VarDec {$$=newast("ExtDecList",1,$1);}
	|VarDec COMMA ExtDecList {$$=newast("ExtDecList",3,$1,$2,$3);}
	;
/*Specifire*/
Specifire:TYPE {$$=newast("Specifire",1,$1);}
	|StructSpecifire {$$=newast("Specifire",1,$1);}
	;
StructSpecifire:STRUCT OptTag LC DefList RC {$$=newast("StructSpecifire",5,$1,$2,$3,$4,$5);}
	|STRUCT Tag {$$=newast("StructSpecifire",2,$1,$2);}
	;
OptTag:ID {$$=newast("OptTag",1,$1);}
	|{$$=newast("OptTag",0,-1);}
	;
Tag:ID {$$=newast("Tag",1,$1);}
	;
/*Declarators*/
VarDec:ID {$$=newast("VarDec",1,$1);}
	| VarDec LB INTEGER RB {$$=newast("VarDec",4,$1,$2,$3,$4);}
	;
FunDec:ID LP VarList RP {$$=newast("FunDec",4,$1,$2,$3,$4);}
        |ID error VarList RP{gramerror("(");error++;}
        |ID LP VarList error{gramerror(")");error++;}
	|ID LP RP {$$=newast("FunDec",3,$1,$2,$3);}
        |ID error RP {gramerror("(");error++;}
        |ID LP error {gramerror(")");error++;}
	;
VarList:ParamDec COMMA VarList {$$=newast("VarList",3,$1,$2,$3);}
	|ParamDec {$$=newast("VarList",1,$1);}
	;
ParamDec:Specifire VarDec {$$=newast("ParamDec",2,$1,$2);}
    ;

/*Statement*/
Compst:LC DefList StmtList RC {$$=newast("Compst",4,$1,$2,$3,$4);}
	;
StmtList:Stmt StmtList{$$=newast("StmtList",2,$1,$2);}
	| {$$=newast("StmtList",0,-1);}
	;
Stmt:Exp SEMI {$$=newast("Stmt",2,$1,$2);}
        |Exp error{gramerror(";");error++;}
	|Compst {$$=newast("Stmt",1,$1);}
	|RETURN Exp SEMI {$$=newast("Stmt",3,$1,$2,$3);}
	|IF LP Exp RP Stmt {$$=newast("Stmt",5,$1,$2,$3,$4,$5);}
	|IF LP Exp RP Stmt ELSE Stmt {$$=newast("Stmt",7,$1,$2,$3,$4,$5,$6,$7);}
	|IF error Exp RP Stmt {gramerror("(");error++;}
	|IF LP Exp error Stmt ELSE Stmt {gramerror(")");error++;}
        |WHILE LP Exp RP Stmt {$$=newast("Stmt",5,$1,$2,$3,$4,$5);}
        |WHILE error Exp RP Stmt{ gramerror("(");error++;}
        |WHILE LP Exp error Stmt{ gramerror(")");error++;}
	;
/*Local Definitions*/
DefList:Def DefList{$$=newast("DefList",2,$1,$2);}
	| {$$=newast("DefList",0,-1);}
	;
Def:Specifire DecList SEMI {$$=newast("Def",3,$1,$2,$3);}
	;
DecList:Dec {$$=newast("DecList",1,$1);}
	|Dec COMMA DecList {$$=newast("DecList",3,$1,$2,$3);}
	;
Dec:VarDec {$$=newast("Dec",1,$1);}
	|VarDec ASSIGNOP Exp {$$=newast("Dec",3,$1,$2,$3);}
	;
/*Expressions*/
Exp:Exp ASSIGNOP Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp AND Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp OR Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp RELOP Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp PLUS Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp MINUS Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp STAR Exp{$$=newast("Exp",3,$1,$2,$3);}
        |Exp DIV Exp{$$=newast("Exp",3,$1,$2,$3);}
        |LP Exp RP{$$=newast("Exp",3,$1,$2,$3);}
        |MINUS Exp {$$=newast("Exp",2,$1,$2);}
        |NOT Exp {$$=newast("Exp",2,$1,$2);}
        |ID LP Args RP {$$=newast("Exp",4,$1,$2,$3,$4);}
        |ID LP RP {$$=newast("Exp",3,$1,$2,$3);}
        |Exp LB Exp RB {$$=newast("Exp",4,$1,$2,$3,$4);}
        |Exp DOT ID {$$=newast("Exp",3,$1,$2,$3);}
        |ID {$$=newast("Exp",1,$1);}
        |INTEGER {$$=newast("Exp",1,$1);}
        |FLOAT{$$=newast("Exp",1,$1);}
        ;
Args:Exp COMMA Args {$$=newast("Args",3,$1,$2,$3);}
        |Exp {$$=newast("Args",1,$1);}
        ;
%%

