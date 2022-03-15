/*
*Name:gramtree_v1.y
*Author:WangLin
*Created on:2015-10-03
*Version 2.0
*Function:bison语法分析&语义分析
*/
%{
#include<unistd.h>
#include<stdio.h>
#include "gramtree_v1.h"//语法树&符号表创建和查询函数
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
Program:ExtDefList {$$=newast("Program",1,$1);}
        ;
ExtDefList:ExtDef ExtDefList {$$=newast("ExtDefList",2,$1,$2);}
        | {$$=newast("ExtDefList",0,-1);}
        ;
ExtDef:Specifire ExtDecList SEMI //变量定义:检查是否重定义Error type 3
        {
        $$=newast("ExtDef",3,$1,$2,$3);
        if(exitvar($2)) printf("Error type 3 at Line %d:Redefined Variable '%s'\n",yylineno,$2->content);
        else newvar(2,$1,$2);
        }
        |Specifire SEMI {$$=newast("ExtDef",2,$1,$2);}
        |Specifire FunDec Compst  //函数定义:检查实际返回类型与函数类型是否匹配Error type 8
        {
        $$=newast("ExtDef",3,$1,$2,$3);
        newfunc(4,$1);
        }
        ;
ExtDecList:VarDec {$$=newast("ExtDecList",1,$1);}
        |VarDec COMMA ExtDecList {$$=newast("ExtDecList",3,$1,$2,$3);}
        ;

/*Specifire*/
Specifire:TYPE {$$=newast("Specifire",1,$1);}
        |StructSpecifire {$$=newast("Specifire",1,$1);}
        ;

StructSpecifire:STRUCT OptTag LC DefList RC  //结构体定义:检查是否重定义Error type 16
        {
        $$=newast("StructSpecifire",5,$1,$2,$3,$4,$5);
        if(exitstruc($2))	printf("Error type 16 at Line %d:Duplicated name '%s'\n",yylineno,$2->content);
        else newstruc(1,$2);
        }
        |STRUCT Tag  //结构体引用:检查是否未定义就引用Error type 17
		{
        $$=newast("StructSpecifire",2,$1,$2);
        if(!exitstruc($2)) printf("Error type 17 at Line %d:undefined structure '%s'\n",yylineno,$2->content);
        }
        ;

OptTag:ID {$$=newast("OptTag",1,$1);}
        |{$$=newast("OptTag",0,-1);}
        ;
Tag:ID {$$=newast("Tag",1,$1);}
        ;
/*Declarators*/
VarDec:ID {$$=newast("VarDec",1,$1);$$->tag=1;}
        | VarDec LB INTEGER RB {$$=newast("VarDec",4,$1,$2,$3,$4);$$->content=$1->content;$$->tag=4;}
        ;
FunDec:ID LP VarList RP //函数定义:检查是否重复定义Error type 4
        {
		$$=newast("FunDec",4,$1,$2,$3,$4);$$->content=$1->content;
        if(exitfunc($1)) printf("Error type 4 at Line %d:Redefined Function '%s'\n",yylineno,$1->content);
        else newfunc(2,$1);
		}
        |ID LP RP //函数定义:检查是否重复定义Error type 4
        {
		$$=newast("FunDec",3,$1,$2,$3);$$->content=$1->content;
        if(exitfunc($1)) printf("Error type 4 at Line %d:Redefined Function '%s'\n",yylineno,$1->content);
        else newfunc(2,$1);}
        ;
VarList:ParamDec COMMA VarList {$$=newast("VarList",3,$1,$2,$3);}
        |ParamDec {$$=newast("VarList",1,$1);}
        ;
ParamDec:Specifire VarDec {$$=newast("ParamDec",2,$1,$2);newvar(2,$1,$2);newfunc(1);}
        ;

/*Statement*/
Compst:LC DefList StmtList RC {$$=newast("Compst",4,$1,$2,$3,$4);}
        ;
StmtList:Stmt StmtList{$$=newast("StmtList",2,$1,$2);}
        | {$$=newast("StmtList",0,-1);}
        ;
Stmt:Exp SEMI {$$=newast("Stmt",2,$1,$2);}
        |Compst {$$=newast("Stmt",1,$1);}
        |RETURN Exp SEMI {$$=newast("Stmt",3,$1,$2,$3);}
        |IF LP Exp RP Stmt ELSE Stmt {$$=newast("Stmt",7,$1,$2,$3,$4,$5,$6,$7);}
        |WHILE LP Exp RP Stmt {$$=newast("Stmt",5,$1,$2,$3,$4,$5);}
        ;
/*Local Definitions*/
DefList:Def DefList{$$=newast("DefList",2,$1,$2);}
        | {$$=newast("DefList",0,-1);}
        ;
Def:Specifire DecList SEMI //变量或数组定义:检查变量是否重定义 Error type 3
		{
		$$=newast("Def",3,$1,$2,$3);
        if(exitvar($2)||exitarray($2))  printf("Error type 3 at Line %d:Redefined Variable '%s'\n",yylineno,$2->content);
        else if($2->tag==4) newarray(2,$1,$2);
        else newvar(2,$1,$2);
		}
        ;
DecList:Dec {$$=newast("DecList",1,$1);}
        |Dec COMMA DecList {$$=newast("DecList",3,$1,$2,$3);$$->tag=$3->tag;}
        ;
Dec:VarDec {$$=newast("Dec",1,$1);}
        |VarDec ASSIGNOP Exp {$$=newast("Dec",3,$1,$2,$3);$$->content=$1->content;}
        ;
/*Expressions*/
Exp:Exp ASSIGNOP Exp{$$=newast("Exp",3,$1,$2,$3);//检查等号左右类型匹配判断Error type 5
        if(strcmp($1->type,$3->type))
{printf("Error type 5 at Line %d:Type mismatched for assignment.\n ",yylineno);}
}

        |Exp AND Exp{$$=newast("Exp",3,$1,$2,$3);}

        |Exp PLUS Exp{$$=newast("Exp",3,$1,$2,$3);//检查操作符左右类型Error type 7
        if(strcmp($1->type,$3->type)){printf("Error type 7 at Line %d:Type mismatched for operand.\n ",yylineno);}}

        |Exp STAR Exp{$$=newast("Exp",3,$1,$2,$3);//检查操作符左右类型Error type 7
        if(strcmp($1->type,$3->type)){printf("Error type 7 at Line %d:Type mismatched for operand.\n ",yylineno);}}

        |Exp DIV Exp{$$=newast("Exp",3,$1,$2,$3);//检查操作符左右类型Error type 7
        if(strcmp($1->type,$3->type)){printf("Error type 7 at Line %d:Type mismatched for operand.\n ",yylineno);}}

        |LP Exp RP{$$=newast("Exp",3,$1,$2,$3);}
        |MINUS Exp {$$=newast("Exp",2,$1,$2);}
        |NOT Exp {$$=newast("Exp",2,$1,$2);}

        |ID LP Args RP {$$=newast("Exp",4,$1,$2,$3,$4);//函数引用:检查是否未定义就调用Error type 2 
         if(!exitfunc($1)){printf("Error type 2 at Line %d:undefined Function %s\n ",yylineno,$1->content);}}

        |ID LP RP {$$=newast("Exp",3,$1,$2,$3);}

        |Exp LB Exp RB //数组引用：是否定义&标识误用&下标 Error type 10，Error type 12
        {$$=newast("Exp",4,$1,$2,$3,$4);
        if(strcmp($3->type,"int"))printf("Error type 12 at Line %d:%.1f is not a integer.\n",yylineno,$3->value);
        if((!exitarray($1))&&(exitvar($1)||exitfunc($1)))printf("Error type 10 at Line %d:'%s'is not an array.\n ",yylineno,$1->content);
        else if(!exitarray($1)){printf("Error type 2 at Line %d:undefined Array %s\n ",yylineno,$1->content);}}

        |Exp DOT ID //结构体引用:检查点号引用Error type 13
        {$$=newast("Exp",3,$1,$2,$3);if(!exitstruc($1))printf("Error type 13 at Line %d:Illegal use of '.'.\n",yylineno);}

        |ID //变量引用:检查是否定义Error type 1 
        {
        $$=newast("Exp",1,$1);
        if(!exitvar($1)&&!exitarray($1))
            printf("Error type 1 at Line %d:undefined variable %s\n ",yylineno,$1->content);
        else $$->type=typevar($1);
        }

        |INTEGER {$$=newast("Exp",1,$1);$$->tag=3;$$->type="int";} //整型常数
        |FLOAT{$$=newast("Exp",1,$1);$$->tag=3;$$->type="float";$$->value=$1->value;} //浮点型常数
        ;
Args:Exp COMMA Args {$$=newast("Args",3,$1,$2,$3);rpnum+=1;} //记录形参个数
        |Exp {$$=newast("Args",1,$1);rpnum+=1;} //记录形参个数
        ;
%%


