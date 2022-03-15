#ifndef node_
#define node_
#include<ostream>
struct node
{
	// data members
	int  next;
	int  weight;
	// methods
	node() {}
	node(const int& next, const int& weight)
	{
		this->next = next;
		this->weight = weight;
	}
};
ostream& operator<<(ostream& out, const node &x)
{
	out << x.next << " " << x.weight << " "; return out;
}
#endif