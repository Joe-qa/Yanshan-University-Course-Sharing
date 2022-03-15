result:gramtree_v1.y gramtree.l gramtree_v1.h
	bison -d gramtree_v1.y
	flex gramtree.l
	gcc gramtree_v1.tab.c lex.yy.c gramtree_v1.c
