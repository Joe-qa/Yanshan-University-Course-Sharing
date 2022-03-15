extern int yylineno;
extern char* yytext;


/*语法树结点*/
struct ast
{
    int line; //行号
    char* name;//语法单元的名字
    struct ast *l;//左孩子
    struct ast *r;//右孩子
    union//用来存放ID/TYPE/INTEGER/FLOAT结点的值
    {
    char* type;
    int i;
    float f;
    };
};

/*构造抽象语法树,name:语法单元名字；num为变长参数中语法结点个数*/
struct ast *newast(char* name,int num,...);

/*先序遍历语法树*/
void eval(struct ast*,int level);
