# include<stdio.h>
# include<stdlib.h>
# include<stdarg.h>
# include"gramtree.h"
# include"syntax.tab.h"
int i;
struct ast *newast(char* name,int num,...)//语法树建立
{
    va_list valist; //变长参数列表
    struct ast *a=(struct ast*)malloc(sizeof(struct ast));//新生成的父节点
    struct ast *temp=(struct ast*)malloc(sizeof(struct ast));
  
    a->name=name;//语法单元名字
    va_start(valist,num);//初始化变长参数为num后的参数
    if(num>0)//num>0代表当前词法单元为非终结符，变长参数为语法树结点
    {
        temp=va_arg(valist, struct ast*);//变长参数列表中第一个结点为左儿子
        a->l=temp;
        a->line=temp->line;
        if(num>=2) 
        {
            for(i=0; i<num-1; ++i)//变长参数列表中的剩余结点设置成兄弟结点
            {
                temp->r=va_arg(valist,struct ast*);
                temp=temp->r;
            }
        }
    }
    else //当前词法单元为终结符或空
    {
        int t=va_arg(valist, int); 
        a->line=t;
        if((!strcmp(a->name,"ID"))||(!strcmp(a->name,"TYPE")))//union保存yytext的值
        {char*t;t=(char*)malloc(sizeof(char* )*40);strcpy(t,yytext);a->type=t;}
        else if(!strcmp(a->name,"INTEGER")) {a->i=atoi(yytext);}
        else {}
    }
    return a;
}
void eval(struct ast *a,int level)//先序遍历抽象语法树
{
    if(a!=NULL)
    {
        for(i=0; i<level; ++i)//孩子结点相对父节点缩进2个空格
            printf("  ");
        if(a->line!=-1){ //产生空的语法单元不需要打印信息
            printf("%s ",a->name);//打印语法单元名字，ID/TYPE/INTEGER要打印yytext的值
            if((!strcmp(a->name,"ID"))||(!strcmp(a->name,"TYPE")))printf(":%s ",a->type);
            else if(!strcmp(a->name,"INTEGER"))printf(":%d",a->i);
            else
                printf("(%d)",a->line);
        }
        printf("\n");
        eval(a->l,level+1);//遍历左子树
        eval(a->r,level);//遍历右子树
    }
}

void gramerror(char*s)//自己编写的错误处理函数，输出错误（Error type B）
{
printf("Error type B at line %d:Missing : %s\n",yylineno,s);
}
int main()
{
    return yyparse(); 
}

