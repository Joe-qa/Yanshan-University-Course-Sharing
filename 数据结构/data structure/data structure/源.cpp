#include"arrayWGraph.h"
#include"test.h"

int main() {
	
	creategragh();
		int something = 0;
		
		while (something!=-1)
		{
			system("cls");
			if (something == 0)
			{
				system("cls");
				cout << "**********************菜单************************" << endl;
				for (int i = 0; i <= 40; i++)
				{
					cout << i << ":" << s[i]<<"  ";
					if ((i+1) % 5 == 0)
						cout << endl;
				}
				cout << endl;
				cout << "1、测试该图是否是有权无向图" << endl;
				cout << "2、测试是否有这条边" << endl;
				cout << "3、广度优先搜索该图" << endl;
				cout << "4、深度优先搜索该图" << endl;
				cout << "5、节点个数" << endl;
				cout << "6、边个数" << endl;
				cout << "7、删除一条边" << endl;
				cout << "8、插入一条边" << endl;
				cout << "9、从A到B的最短路径" << endl;
				cout << "10、测试该图是否含有环" << endl;
				cout << "11、输出邻接数组" << endl;
				cout << "12、所有地方之间的最短距离" << endl;
				cout << "请输入您所想要实现的功能前的序号" << endl;
				cin >> something;
			}
			if (something == 1)
			{
				system("cls");
				bool flag = mygraph.weighted();
				if (flag)
					cout << "This is a weighted graph" << endl;
				else
					cout << "This is not a weighted graph" << endl;
				flag = mygraph.directed();
				if (flag)
					cout << "This is a directed graph" << endl;
				else
					cout << "This is a undirected graph" << endl;
			}
			if (something == 2)
			{
				system("cls");
				int i, j;
				cout << "cin the vertex of the edge" << endl;
				cin >> i >> j;
				bool flag = mygraph.existsEdge(i, j);
				if (flag)
					cout << "exsit the edge of " << i << "-" << j << endl;
				else
					cout << "Not exsit the edge of " << i << "-" << j << endl;
			}
			if (something == 3)
			{
				system("cls");
				cout << "cin the start place" << endl;
				int start;
				cin >> start;
				cout << "图的广度优先搜索——";
				mygraph.bfs(start);
				cout << endl;

			}
			if (something == 4)
			{
				system("cls");
				cout << "cin the start place" << endl;
				int start;
				cin >> start;
				cout << "图的深度优先搜索——";
				mygraph.dfs(start);
				cout << endl;
			}
			if (something == 5)
			{
				system("cls");
				int numofv = mygraph.numberOfVertices();
				cout << "点的数量为——" << numofv << endl;
			}
			if (something == 6)
			{
				system("cls");
				int numofe = mygraph.numberOfEdges();
				cout << "边的数量为——" << numofe << endl;
			}
			if (something == 7)
			{
				system("cls");
				int first, second;
				cout << "please cin the vertex of the edge" << endl;
				cin >> first >> second;
				mygraph.eraseEdge(first, second);
			}
			if (something == 8)
			{
				system("cls");
				int first, last, theweight;
				cout << "please cin the first last weight" << endl;
				
				edge e;
				cin >> e.x>> e.y >> e.weight;
				try
				{
					mygraph.insertEdge(e);
				}
				catch (illegalParameterValue)
				{
					cout << "It is not a permissible edge" << endl;
					system("pause");
					return 0;
				}
			}
			if (something == 9)
			{
				system("cls");
				int start, destination;
				cout << "cin the start and the destination" << endl;
				cin >> start >> destination;
				mygraph.Dijkstra(start, destination);
			}
			if (something == 10)
			{
				system("cls");
				bool flagloop = false;
				flagloop = mygraph.circle();
				if (flagloop == true)
				{
					cout << "This graph has a loop" << endl;
				}
				else
					cout << "This graph doesn't have a loop" << endl;
			}
			if (something == 12) {
				system("cls");
				mygraph.shortallpath();
			}
			if (something == 11)
			{
				system("cls");
				mygraph.output(cout);
			}
			cout << "press 0 :return menu" << endl;
			cout << "press -1:exit" << endl;
			cin >> something;
		}
		cout << "********  **    **        **         ****     **    **     **" << endl;
		cout << "   **     **    **      **  **       ** **    **    **   ** " << endl;
		cout << "   **     **    **     **    **      **  **   **    **  **" << endl;
		cout << "   **     ********    **********     **   **  **    ***" << endl;
		cout << "   **     **    **   **        **    **    ** **    **  **" << endl;
		cout << "   **     **    **  **          **   **     ****    **    **" << endl;
			
			
		return 0;
}
