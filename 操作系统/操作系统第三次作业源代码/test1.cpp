#include<iostream>
#include <thread>
#include<Windows.h>
using namespace std;

int sum1,sum2,sum3;
int x;
void f1(){
	//cout<<"thread1 running..."<<endl;
    sum1=0;
	for(int i=x;i<=50;i++)
	sum1+=i;
   Sleep(100); 
   //	cout<<"thread1 ending..."<<endl;
}

void f2(){
	//	cout<<"thread2 running..."<<endl;
     sum2=0;
	for(int i=x;i<=500;i++)
	sum2+=i;
	Sleep(100);
	  //	cout<<"thread2 ending..."<<endl;
}


void f3(){
		//cout<<"thread3 running..."<<endl;
     sum3=1;
	for(int i=1;i<=x;i++)
	sum3*=i;
	Sleep(100);
	  	//cout<<"thread3 ending..."<<endl;
}

int main(){
	cin>>x;
	clock_t startTime,endTime;
	startTime=clock();
		thread f01(f1);
		thread f02(f2);
		thread f03(f3);
		f01.join();
		f02.join();
		f03.join();
		cout<<sum1+sum2+sum3<<endl;
//	for(int i=0;i<1000;i++)
//	{
//		thread f01(f1);
//		thread f02(f2);
//		thread f03(f3);
//		f01.join();
//		f02.join();
//		f03.join();
//        f1();f2();f3(); 
//		cout<<sum1+sum2+sum3<<endl;
//	}
	endTime=clock();
	cout<<"run time£º"<<(double)(endTime-startTime)/CLOCKS_PER_SEC<<"s"<<endl;

}
