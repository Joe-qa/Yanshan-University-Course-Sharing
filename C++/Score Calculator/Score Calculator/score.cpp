#include<iostream>
#include<string>
#include<cmath>
#include<iomanip>
#include<fstream>
#include<sstream>
#include<process.h>
using namespace std;


class Integer{
public:
	Integer(){}
	Integer(int xx){x=xx;}
	Integer(Integer &p){x=p.x;}
	~Integer(){}
	void display(){cout<<"The integer is "<<x<<endl;}
	int getInteger(){return x;}
	void setInteger(int xx){x=xx;}
private:
	int x;
};
class Fractions:public Integer{
public:
	Fractions(int a=0,int b=1){above=a;below=b;}
	~Fractions(){}
  friend ostream & operator<<(ostream &out,const Fractions &f);
  friend istream & operator>>(istream &input, Fractions &f);
	Fractions add(Fractions);//加法计算
	Fractions subtract(Fractions);//减法计算
	Fractions multiply(Fractions);//乘法计算
	Fractions divide(Fractions);//除法计算
	Fractions power(int);//乘方计算
	Fractions Fractions::operator +( Fractions &f);
	Fractions Fractions::operator -( Fractions &f);
	Fractions Fractions::operator *( Fractions &f);
	Fractions Fractions::operator /( Fractions &f);
	void reduction();//约分
	void makeCommond(Fractions&);//通分
	int getAbove(){return above;}
	int getBelow(){return below;}
private:
	int above;
	int below;
};

void  Fractions::reduction(){
int a,b,temp,divisor;
a=abs(above);
b=abs(below);
while(a%b){//辗转相除法求最大公约数
	temp=a;
	a=b;
	b=temp%b;
}
divisor=b;
above/=divisor;
below/=divisor;
}
void Fractions::makeCommond( Fractions &f){//通分
int temp;
reduction();
f.reduction();
above*=f.below;
f.above*=below;
temp=below*f.below;
below=f.below=temp;
}

Fractions Fractions::add(Fractions f){
Fractions p;
makeCommond(f);
p.above=above+f.above;
p.below=below;
p.reduction();
return p;
}
Fractions Fractions::subtract(Fractions f){
	Fractions p;
makeCommond(f);
p.above=above-f.above;
p.below=below;
p.reduction();
return p;
}
Fractions Fractions::multiply(Fractions f){
	Fractions p;
makeCommond(f);
p.above=above*f.above;
p.below=below*f.below;
p.reduction();
return p;
}
Fractions Fractions::divide(Fractions f){
	Fractions p;
makeCommond(f);
p.above=above*f.below;
p.below=below*f.above;
p.reduction();
return p;
}
Fractions Fractions::power(int x){
	Fractions p;
p.above=above;
p.below=below;
for(int i=1;i<x;i++){
	p.above=p.above*above;
	p.below=p.below*below;
}
p.reduction();
return p;
}

ostream & operator<<(ostream &out,const Fractions &f){//输出，对流提取运算符的重载
	if(f.below==1)
		out<<f.above<<endl;
	else
	out<<f.above<<"/"<<f.below;
	return out;
}
istream & operator>>(istream & input, Fractions &f){//输入，对流插入运算符的重载
	cout<<"请依次输入分数的分母和分子，以空格隔开（eg：1 2）";
	input>>f.above;
		input>>f.below;
		if(f.below==0)
			throw f;
	return input;
}


Fractions Fractions::operator +( Fractions &f){
Fractions p;
makeCommond(f);
p.above=above+f.above;
p.below=below;
p.reduction();
return p;
};
Fractions Fractions::operator -( Fractions &f){
	Fractions p;
makeCommond(f);
p.above=above-f.above;
p.below=below;
p.reduction();
return p;
};
Fractions Fractions::operator *( Fractions &f){
	Fractions p;
makeCommond(f);
p.above=above*f.above;
p.below=below*f.below;
p.reduction();
return p;
}
Fractions Fractions::operator /( Fractions &f){
Fractions p;
makeCommond(f);
p.above=above*f.below;
p.below=below*f.above;
p.reduction();
return p;
}


void inttostr(const int&int_temp,string &string_temp){
stringstream stream;
stream<<int_temp;
string_temp=stream.str();
}
void Menu(int a){
	cout<<"*****************************************分数计算器*************************************************  "<<endl;
	cout<<"*******    ********          **            *******   *********  ******     *****       **        **   "<<endl;
	cout<<"**         **     **       **  **         **            **        **     **    **      ** **     **  " <<endl;    
	cout<<"*******    ********       ********       **             **        **    **      **     **   **   ** "<<endl;
	cout<<"**         ****          **      **      **             **        **    **      **     **    **  **     "<<endl;
	cout<<"**         **  **       **        **      **            **        **     **    **      **     ** **    "<<endl;
	cout<<"**         **    **    **          **       ******      **      ******     *****       **       ***       "<<endl;
	if(a==1){
		string p,a,b,c,d;
Fractions f1;Fractions f2;Fractions f3;
char x;
try{cin>>f1;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f1;
		}
		inttostr(f1.getAbove(),a);
inttostr(f1.getBelow(),b);
p+=a+"/"+b;
cout<<"请输入运算符号：";
cin>>x;
while(x!='=')
{
try{cin>>f2;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f2;
		}
if(x=='+')
{
f3=f2+f1;
f1.reduction();
f2.reduction();
inttostr(f2.getAbove(),c);
inttostr(f2.getBelow(),d);
p+="+"+c+"/"+d;
}
else if(x=='-')
{
f3=f1-f2;
f1.reduction();
f2.reduction();
inttostr(f2.getAbove(),c);
inttostr(f2.getBelow(),d);
p+="-"+c+"/"+d;
}if(x=='*')
{
f3=f2*f1;
f1.reduction();
f2.reduction();
inttostr(f2.getAbove(),c);
inttostr(f2.getBelow(),d);
p+="*"+c+"/"+d;
}if(x=='/')
{
f3=f2+f1;
f1.reduction();
f2.reduction();
inttostr(f2.getAbove(),c);
inttostr(f2.getBelow(),d);
p+="/"+c+"/"+d;
}
	cout<<"请输入运算符号：";
cin>>x;
f1=f3;
}
ofstream outFile;
outFile.open("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt",ios::app);
outFile <<p<<"="<<f3<<endl;
	outFile.close();
cout<<p<<"="<<f3<<endl;
	}
	else if(a==2){
		Fractions f1;
		Fractions f2;
		int a;
		cout<<"请输入需要乘方的分数： ";
		try{cin>>f1;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f1;
		}
		cout<<"请输入幂：";cin>>a;
		cout<<"乘方后的分数为 ："<<f1.power(a)<<endl;
		ofstream outFile;
outFile.open("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt",ios::app);
outFile <<f1<<"的"<<a<<"次方为 "<<f1.power(a)<<endl;
	outFile.close();
	}
	else if(a==3){
	Fractions f1;
	Fractions f2;
	cout<<"请输入需要化简的分数： ";
	try{cin>>f1;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f1;
		}
	f2=f1;
	f1.reduction();
	if(f2.getAbove()==f1.getAbove()&&f2.getBelow()==f1.getBelow()){
	cout<<"您输入的分数已经是最简的了，无需化简。"<<endl;
	}
	else{
	cout<<f2<<"化简后为 "<<f1<<endl;
	}
	ofstream outFile;
outFile.open("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt",ios::app);
outFile <<f1<<"化简为"<<f2<<endl;
	outFile.close();
	}
	else if(a==4){
Fractions f1;Fractions f2;Fractions f3;
char x;
try{cin>>f1;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f1;
		}
cout<<"请输入运算符号：";
cin>>x;
try{cin>>f2;}
		catch(Fractions &p){
			cout<<"分数的分母不能为 "<<p.getBelow()<<" 请重新输入。"<<endl;
		cin>>f2;
		}
if(x=='+')
{
f3=f2+f1;
f1.reduction();
f2.reduction();
cout<<f1<<"+"<<f2<<"="<<f3<<endl;
}
else if(x=='-')
{
f3=f1-f2;
f1.reduction();
f2.reduction();
cout<<f1<<"-"<<f2<<"="<<f3<<endl;
}if(x=='*')
{
f3=f2*f1;
f1.reduction();
f2.reduction();
cout<<f1<<"*"<<f2<<"="<<f3<<endl;
}if(x=='/')
{
f3=f2+f1;
f1.reduction();
f2.reduction();
cout<<f1<<"/"<<f2<<"="<<f3<<endl;
}
ofstream outFile;
outFile.open("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt",ios::app);
outFile <<f1<<x<<f2<<"="<<f3<<endl;
	outFile.close();
	}
	else if(a==5)
	{
	cout<<"欢迎您查看历史记录（本历史记录只包含当前操作的计算记录）"<<endl;
	string str;
	ifstream fin;
	fin.open("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt",ios::in);
	stringstream buf;
	buf<<fin.rdbuf();
	str=buf.str();
	cout<<str<<endl;
	fin.close();
	}
	}//菜单功能
void cleartxt(string filename)
{
ofstream text;
text.open(filename,ios::out);
text.close();
}
int main(){
	int a=0,b=0;
	cout<<"*****************************************分数计算器*************************************************  "<<endl;
	cout<<"*******    ********          **            *******   *********  ******     *****       **        **   "<<endl;
	cout<<"**         **     **       **  **         **            **        **     **    **      ** **     **  " <<endl;    
	cout<<"*******    ********       ********       **             **        **    **      **     **   **   ** "<<endl;
	cout<<"**         ****          **      **      **             **        **    **      **     **    **  **     "<<endl;
	cout<<"**         **  **       **        **      **            **        **     **    **      **     ** **    "<<endl;
	cout<<"**         **    **    **          **       ******      **      ******     *****       **       ***       "<<endl;
	cout<<"*********************************************Menu**************************************************"<<endl;
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            1、多个分数的运算                                     |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            2、乘方计算                                           |"<<"\n";
	cout<<"--------------------------------------------------------------------------------------------------- "<<"\n";
	cout<<"|                                            3、化简分数                                           |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            4、两个分数间的四则运算功能                           |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            5、查看历史计算记录                                   | "<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            6、退出                                               |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"***************************************************************************************************"<<endl;
	cout<<"请输入您需要执行的功能前的序号 ";
		cin>>a;
	while(a!=6){
    system("cls");
	Menu(a);
	cout<<"是否还要执行其他功能（按0退出；按6返回主菜单）"<<endl;
	cin>>b;
	if(b==0)
		break;
	else
	{
	   system("cls");	
	cout<<"*****************************************分数计算器*************************************************  "<<endl;
	cout<<"*******    ********          **            *******   *********  ******     *****       **        **   "<<endl;
	cout<<"**         **     **       **  **         **            **        **     **    **      ** **     **  " <<endl;    
	cout<<"*******    ********       ********       **             **        **    **      **     **   **   ** "<<endl;
	cout<<"**         ****          **      **      **             **        **    **      **     **    **  **     "<<endl;
	cout<<"**         **  **       **        **      **            **        **     **    **      **     ** **    "<<endl;
	cout<<"**         **    **    **          **       ******      **      ******     *****       **       ***       "<<endl;
	cout<<"*********************************************Menu**************************************************"<<endl;
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            1、多个分数的运算                                     |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            2、乘方计算                                           |"<<"\n";
	cout<<"--------------------------------------------------------------------------------------------------- "<<"\n";
	cout<<"|                                            3、化简分数                                           |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            4、两个分数间的四则运算功能                           |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            5、查看历史计算记录                                   | "<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"|                                            6、退出                                               |"<<"\n";
	cout<<"---------------------------------------------------------------------------------------------------"<<"\n";
	cout<<"***************************************************************************************************"<<endl;
	cout<<"请输入您需要执行的功能前的序号 ";
		cin>>a;
	}
		}
	cleartxt("C:\\Users\\qa\\Desktop\\C++\\Fractions.txt");
	system("cls");
cout<<"谢谢使用"<<endl;
	return 0;
}



