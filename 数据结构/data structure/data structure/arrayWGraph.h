#pragma once
#include"graph.h"
#include<stack>
#include "myExceptions.h"
#include"node.h"
#include<vector>
#include<iostream>
#include<sstream>
#include <iterator>
#include<string>
#include<queue>
#define MaxNode 200
const int &INF = 100000000;
const int maxn = 100;
int path[maxn];
using namespace std;

string s[41] = { "燕大后海","第四体育场","十一组团","十组团","燕园餐厅","九组团","八组团","七组团","六组团",
"燕大驾校","美术馆","西五教","经管楼","美术馆","西区浴池","西区大食堂","五组团","四组团","三组团","二组团",
"一组团","燕飞湖","理学楼","自控馆","材料馆","花坛","西一教","西二教","西三教","西四教","竹海","中心湖体",
"新图书馆","塔山公园","里仁行政楼","西大活","里仁教学楼","里仁图文信息中心","里仁阶教","里仁综合楼","三体" };

class adjacencyWDigraph : public graph {
protected:
	int n;                      // number of vertices
	int e;                      // number of edges
	vector<node> *a;             //adjacency 
public:
	adjacencyWDigraph(int numberOfVertices = 0) {
		// Constructor.
			 // validate number of vertices
		if (numberOfVertices < 0)
			throw illegalParameterValue("number of vertices must be >= 0");
		n = numberOfVertices;
		e = 0;
		a = new vector<node>[numberOfVertices + 1];
	}
	~adjacencyWDigraph() {}
	int numberOfVertices() const { return n; }

	int numberOfEdges() const { return e; }

	bool directed() const { return false; }

	bool weighted() const { return true; }


	void checkVertex(int theVertex) const
	{// Verify that i is a valid vertex.
		if (theVertex < 0 || theVertex >= n)
		{
			ostringstream s;
			s << "no vertex " << theVertex;
			throw illegalParameterValue(s.str());
		}
	}
	int degree(int theVertex) const
	{
		checkVertex(theVertex);
		return a[theVertex].size();
	}

	int outDegree(int theVertex) const
	{
		throw undefinedMethod("outdegree() undefined");
	}

	int inDegree(int theVertex) const
	{
		throw undefinedMethod("indegree() undefined");
	}
	bool existsEdge(int i, int j) const
	{
		if (i < 0 || i >= n || j < 0 || j >= n) {
			return false;
		}
		for (int x = 0; x < a[i].size(); x++)
			if (a[i][x].next == j)
				return true;
		return false;
	}
	void eraseEdge(int x, int y)
	{// Delete the edge (i,j).
		if (x < 0 || x >= n || y < 0 || y >= n || !existsEdge(x, y)) {
			return;
		}
		vector<node>::iterator it;
		for (it = a[x].begin(); it != a[x].end(); it++) {
			if (it->next == y) {
				e--;
				a[x].erase(it);
				return;
			}
		}
		for (it = a[y].begin(); it != a[y].end(); it++) {
			if (it->next == x) {
				e--;
				a[y].erase(it);
				return;
			}
		}
	}

	void insertEdge(edge & theEdge) {
		int v1 = theEdge.x;
		int v2 = theEdge.y;
		int w = theEdge.weight;
		if (v1 < 0 || v2 < 0 || v1 >=n || v2 >=n || v1 == v2)
		{
			ostringstream s;
			s << "(" << v1 << "," << v2
				<< ") is not a permissible edge";
			throw illegalParameterValue(s.str());
		}
		if (v1 < 0 || v1 >= n || v2 < 0 || v2 >= n) {
			return;
		}
		if (!existsEdge(v1, v2)) {
			e++;
			node tem;
			tem.next = v2;
			tem.weight = w;
			a[v1].push_back(tem);
			node tem2;
			tem2.next = v1;
			tem2.weight = w;
			a[v2].push_back(tem2);
		}
		else {
			for (int i = 0; i < a[v1].size(); i++) {
				if (a[v1][i].next == v2) {
					a[v1][i].weight = w;
					break;
				}
			}
			for (int i = 0; i < a[v2].size(); i++) {
				if (a[v2][i].next == v1) {
					a[v2][i].weight = w;
					break;
				}
			}
		}
	}

	void output(ostream& out) const
	{// Output 
		out << "图邻接数组为：" << endl;
		for (int i = 0; i < n; i++)
		{
			out << i << " ";
			for (int j = 0; j < a[i].size(); j++)
			{
				out << a[i][j].next << "," << a[i][j].weight << " ";
			}
			out << endl;
		}

	}
	bool circle()
	{
		int *prenode = new int[MaxNode];
		int visited[MaxNode], s_top;
		for (int i = 0; i < MaxNode; i++)
		{
			prenode[i] = -1;
			visited[i] = 0;
		}
		stack<int>s;
		s.push(0);
		while (!s.empty())
		{
			s_top = s.top();
			visited[s_top] = 1;
			s.pop();
			for (int i = 0; i < a[s_top].size(); i++)
			{
				if (!visited[a[s_top][i].next])
				{
					visited[a[s_top][i].next] = 1;
					s.push(a[s_top][i].next);
					prenode[a[s_top][i].next] = s_top;
				}
				else if (a[s_top][i].next != prenode[s_top])
					return true;
			}
		}
		return false;
	}
	void dfs(int start)
	{
		int num = 1;
		int visited[MaxNode], s_top;
		for (int i = 0; i < MaxNode; i++)
		{
			visited[i] = 0;
		}
		visited[start] = 1;
		stack<int>s;
		cout << start << "->";
		for (int i = 0; i < a[start].size(); i++)
		{
			visited[a[start][i].next] = 1;
			s.push(a[start][i].next);
		}
		while (!s.empty())
		{
			s_top = s.top();
			visited[s_top] = 1;
			if (num == n - 1)
				cout << s_top;
			else
				cout << s_top << "->";
			num++;
			s.pop();
			for (int i = 0; i < a[s_top].size(); i++)
			{
				if (!visited[a[s_top][i].next])
				{
					visited[a[s_top][i].next] = 1;
					s.push(a[s_top][i].next);
				}
			}
		}
	}
	void bfs(int start)
	{
		int num = 0;
		bool ver[200] = { 0 };
		queue<int>q;
		ver[start] = 1;
		q.push(start);
		while (!q.empty())
		{
			int u = q.front();
			q.pop();
			if (num == n - 1)
				cout << u;
			else
				cout << u << "->";
			num++;
			for (int i = 0; i < a[u].size(); i++)
			{
				if (ver[a[u][i].next] == 0)
				{
					ver[a[u][i].next] = 1;
					q.push(a[u][i].next);
				}
			}
		}

	}
	void print(const int &beg, const int &end,
		const vector<vector<int> > &path)//传引用，避免拷贝，不占用内存空间
		//也可以用栈结构先进后出的特性来代替函数递归 
	{
		if (path[beg][end] >= 0)
		{
			print(beg, path[beg][end], path);
			print(path[beg][end], end, path);
		}
		else cout << "->" <<s[ end];
	}
	void floyd(vector<vector<int> > &distmap,//可被更新的邻接矩阵，更新后不能确定原有边
		vector<vector<int> > &path) {
		const int &NODE = distmap.size();//用邻接矩阵的大小传递顶点个数，减少参数传递
		path.assign(NODE, vector<int>(NODE, -1));//初始化路径数组 
		for (int k = 1; k != NODE; ++k)//对于每一个中转点
			for (int i = 0; i != NODE; ++i)//枚举源点
				for (int j = 0; j != NODE; ++j)//枚举终点
					if (distmap[i][j] > distmap[i][k] + distmap[k][j])//不满足三角不等式
					{
						distmap[i][j] = distmap[i][k] + distmap[k][j];//更新
						path[i][j] = k;//记录路径
					}
	}
	void shortallpath() {
		int n_num, e_num, beg, end;//含义见下
		n_num = n;
		e_num = e;
		vector<vector<int> > path,
			distmap(n_num, vector<int>(n_num, INF));//默认初始化邻接矩阵
		for (int i = 0; i < n; i++)
		{
			for (int j = 0; j < a[i].size(); j++)
			{
				int p, q;
				p = i;
				q = a[i][j].next;
				distmap[p][q] = a[i][j].weight;
			}
		}
		floyd(distmap, path);

		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
			{
				if (i != j) {
					cout << s[i] << "->" << s[j] << "最短距离为" << distmap[i][j] << "，打印路径：" << s[i];
					print(i, j, path);
					cout << endl;
				}
			}
	}
	void print(int x)//x为终点
	{
		if (x == -1) return;
		//递归
		print(path[x]);
	cout<<s[x]<<"->";
	}
void Dijkstra(int start, int end) {
	
	
	/*int map[maxn][maxn];*/
	int dis[maxn];
	
	int vis[maxn];//记录更新过的点
		//初始化
	    memset(path, -1, sizeof(path));
		memset(dis, 0x3f, sizeof(dis)); //初始化为无穷大
		memset(vis, 0, sizeof(vis));
		dis[start] = 0; //自身到自身的距离为0
		int num = 0;
		int k = 0;
		while (1)
		{
			k = 0;
			for (int j = 0; j < n; j++)
			{
				if (!vis[j]&&!vis[k])//找未收录顶点中dis值最小的
					k = dis[j]<dis[k] ?j:k;//这里第一次找到的是起点
				else if (vis[k])
				{
					k++;
				}
			}
			//没有未收录的点，则返回
			vis[k] = 1;
			num++;
			for (int j = 0; j < a[k].size(); j++)
			{
				//第一次循环只有起点的邻接点距离被更新，每次都更新新找到的点的邻接点
				if (dis[a[k][j].next] > dis[k] + a[k][j].weight&&!vis[a[k][j].next])
				{
					dis[a[k][j].next] = dis[k] + a[k][j].weight;
					path[a[k][j].next] = k;//路径被改变，重新记录前驱，最短路是由最短路+某一条固定路组成，所以前驱是有效的
				}
			}
			if(num==n)break;
		}
		print(path[end]);
		cout<< s[end]<<endl;
		//打印最短距离
		printf("%d\n", dis[end]);
}
};
