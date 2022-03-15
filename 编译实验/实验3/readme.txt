实验环境：
1) GNU Linux Release: Ubuntu 12.04, kernel version 3.2.0-29； 
2) GCC version 4.6.3； 
3) GNU Flex version 2.5.35； 
4) GNU Bison version 2.5
运行步骤：
1、bison -d syntax.y
2、flex lexical.l
3、gcc syntax.tab.c lex.yy.c main.c -lfl -ly -o parser
4、./parser test.c