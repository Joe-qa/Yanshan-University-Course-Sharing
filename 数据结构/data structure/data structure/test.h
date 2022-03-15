#pragma once
#include"arrayWGraph.h"

int num = 41;
adjacencyWDigraph mygraph(num);
void creategragh() {
	string s[41] = { "燕大后海","第四体育场","十一组团","十组团","燕园餐厅","九组团","八组团","七组团","六组团",
"燕大驾校","美术馆","西五教","经管楼","美术馆","西区浴池","西区大食堂","五组团","四组团","三组团","二组团",
"一组团","燕飞湖","理学楼","自控馆","材料馆","花坛","西一教","西二教","西三教","西四教","竹海","中心湖体",
"新图书馆","塔山公园","里仁行政楼","西大活","里仁教学楼","里仁图文信息中心","里仁阶教","里仁综合楼","三体" };
	    edge e;
		e.x = 0; e.y = 1; e.weight = 2; mygraph.insertEdge(e);
		e.x = 0; e.y = 9; e.weight = 5; mygraph.insertEdge(e);
		e.x = 0; e.y = 10; e.weight = 7; mygraph.insertEdge(e);
		e.x = 1; e.y = 10; e.weight = 3; mygraph.insertEdge(e);
		e.x = 1; e.y = 13; e.weight = 8; mygraph.insertEdge(e);
		e.x = 2; e.y = 3; e.weight = 1; mygraph.insertEdge(e);
		e.x = 2; e.y = 4; e.weight = 2; mygraph.insertEdge(e);
		e.x = 3; e.y = 4; e.weight = 3; mygraph.insertEdge(e);
		e.x = 5; e.y = 3; e.weight = 3; mygraph.insertEdge(e);
		e.x = 6; e.y = 5; e.weight = 1; mygraph.insertEdge(e);
		e.x = 7; e.y = 6; e.weight = 1; mygraph.insertEdge(e);
		e.x = 8; e.y = 7; e.weight = 1; mygraph.insertEdge(e);
		e.x = 13; e.y = 10; e.weight = 1; mygraph.insertEdge(e);
		e.x = 11; e.y = 10; e.weight = 4; mygraph.insertEdge(e);
		e.x = 11; e.y = 9; e.weight = 2; mygraph.insertEdge(e);
		e.x = 12; e.y = 11; e.weight = 2; mygraph.insertEdge(e);
		e.x = 13; e.y = 12; e.weight = 2; mygraph.insertEdge(e);
		e.x = 14; e.y = 6; e.weight = 2; mygraph.insertEdge(e);
		e.x = 14; e.y = 5; e.weight = 2; mygraph.insertEdge(e);
		e.x = 15; e.y = 14; e.weight = 3; mygraph.insertEdge(e);
		e.x = 15; e.y = 8; e.weight = 2; mygraph.insertEdge(e);
		e.x = 15; e.y = 7; e.weight = 2; mygraph.insertEdge(e);
		e.x = 15; e.y = 6; e.weight = 2; mygraph.insertEdge(e);
		e.x = 16; e.y = 15; e.weight = 3; mygraph.insertEdge(e);
		e.x = 17; e.y = 16; e.weight = 1; mygraph.insertEdge(e);
		e.x = 1; e.y = 2; e.weight = 4; mygraph.insertEdge(e);
		e.x = 18; e.y = 16; e.weight = 3; mygraph.insertEdge(e);
		e.x = 19; e.y = 18; e.weight = 1; mygraph.insertEdge(e);
		e.x = 19; e.y = 17; e.weight = 3; mygraph.insertEdge(e);
		e.x = 19; e.y = 16; e.weight = 3; mygraph.insertEdge(e);
		e.x = 20; e.y = 19; e.weight = 1; mygraph.insertEdge(e);
		e.x = 20; e.y = 17; e.weight = 3; mygraph.insertEdge(e);
		e.x =21; e.y = 20; e.weight = 5; mygraph.insertEdge(e);
		e.x = 21; e.y = 19; e.weight = 4; mygraph.insertEdge(e);
		e.x = 18; e.y = 21; e.weight = 3; mygraph.insertEdge(e);
		e.x = 14; e.y = 22; e.weight = 8; mygraph.insertEdge(e);
		e.x = 22; e.y = 23; e.weight = 1; mygraph.insertEdge(e);
		e.x = 14; e.y = 23; e.weight = 8; mygraph.insertEdge(e);
		e.x = 23; e.y = 24; e.weight = 1; mygraph.insertEdge(e);
		e.x = 15; e.y = 24; e.weight = 10; mygraph.insertEdge(e);
		e.x = 24; e.y = 25; e.weight = 3; mygraph.insertEdge(e);
		e.x = 25; e.y = 21; e.weight = 2; mygraph.insertEdge(e);
		e.x = 22; e.y = 26; e.weight = 3; mygraph.insertEdge(e);
		e.x = 27; e.y = 26; e.weight = 2; mygraph.insertEdge(e);
		e.x = 27; e.y = 23; e.weight = 3; mygraph.insertEdge(e);
		e.x = 23; e.y = 28; e.weight = 7; mygraph.insertEdge(e);
		e.x = 27; e.y = 28; e.weight = 2; mygraph.insertEdge(e);
		e.x = 25; e.y = 29; e.weight = 1; mygraph.insertEdge(e);
		e.x = 24; e.y = 29; e.weight = 4; mygraph.insertEdge(e);
		e.x = 28; e.y = 29; e.weight = 2; mygraph.insertEdge(e);
		e.x = 31; e.y = 30; e.weight = 5; mygraph.insertEdge(e);
		e.x = 31; e.y = 26; e.weight = 3; mygraph.insertEdge(e);
		e.x = 30; e.y = 32; e.weight = 2; mygraph.insertEdge(e);
		e.x = 33; e.y = 32; e.weight = 4; mygraph.insertEdge(e);
		e.x = 33; e.y = 31; e.weight = 7; mygraph.insertEdge(e);
		e.x = 33; e.y = 29; e.weight = 1; mygraph.insertEdge(e);
		e.x = 35; e.y = 34; e.weight = 4; mygraph.insertEdge(e);
		e.x = 35; e.y = 21; e.weight = 2; mygraph.insertEdge(e);
		e.x = 36; e.y = 34; e.weight = 1; mygraph.insertEdge(e);
		e.x = 36; e.y = 33; e.weight = 5; mygraph.insertEdge(e);
		e.x = 37; e.y = 36; e.weight = 2; mygraph.insertEdge(e);
		e.x = 37; e.y = 34; e.weight = 5; mygraph.insertEdge(e);
		e.x = 37; e.y = 35; e.weight = 2; mygraph.insertEdge(e);
		e.x = 37; e.y = 38; e.weight = 3; mygraph.insertEdge(e);
		e.x = 36; e.y = 38; e.weight = 1; mygraph.insertEdge(e);
		e.x = 38; e.y = 39; e.weight = 1; mygraph.insertEdge(e);
		e.x = 37; e.y = 39; e.weight = 2; mygraph.insertEdge(e);
		e.x =40; e.y = 33; e.weight = 7; mygraph.insertEdge(e);
		e.x = 40; e.y = 39; e.weight = 2; mygraph.insertEdge(e);
}
