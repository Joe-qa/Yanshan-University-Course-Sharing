测试环境
1) GNU Linux Release: Ubuntu 12.04, kernel version 3.2.0-29； 
2) GCC version 4.6.3； 
3) GNU Flex version 2.5.35；

使用步骤：
1、使用flex对lexical.l进行编译
flex lexical.l
编译好的文件会保存在当前目录下的lex.yy.c文件中
2、编译C源文件（输出程序名为scanner）
gcc lex.yy.c -lfl -o scanner
3、测试（测试文件名为test.c）
./scanner test.c