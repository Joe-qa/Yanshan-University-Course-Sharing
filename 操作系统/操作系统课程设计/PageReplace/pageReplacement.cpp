#include <iostream>  
#include <map>
#include <set>
#include <algorithm>
#include <cstdio>
#include <cstring> 
#include <cmath>
#define N 200
using namespace std;  
 
int page[N];
int block[N];
int dist[N][N];

int n;
int m;
int page_max;

int pre[N];//page[i]在page中的索引
int OPT(){
	cout<<"*********OPT*********"<<endl;
    int page_lack = 0;
    memset(pre, 0, sizeof(pre));
    memset(dist, 9999, sizeof(dist));
    memset(block, -1, sizeof(block));
    for(int i=n; i>=1; --i){
         for(int j=0; j<=page_max; ++j) 
             if(pre[j])
                dist[i][j] = pre[j] - i;
         pre[page[i]] = i; 
    }
    
    for(int i=1; i<=n; ++i){ 
        int j;
        int max_dist = 0, p; 
        for(j=1; j<=m; ++j){
            if(block[j] == -1){
                block[j] = page[i]; 
                page_lack++;
                break;
            } else if(block[j] == page[i])
                break;
            
            if(max_dist < dist[i][block[j]]){
                max_dist = dist[i][block[j]];
                p = j;
            }
        }
        if(j > m){
             block[p] = page[i];
             page_lack++; 
        }
        for(int k=1; k<=m; ++k)
            cout<<block[k]<<" ";
        cout<<endl;
    }
    return page_lack;
} 

int LRU(){
	cout<<"*********LRU*********"<<endl;
    int page_lack = 0;
    memset(pre, 0, sizeof(pre));
    memset(dist, 99999, sizeof(dist));
    memset(block, -1, sizeof(block));
    for(int i=1; i<=n; ++i){
         for(int j=0; j<=page_max; ++j) 
             if(pre[j])
                dist[i][j] = i - pre[j];
         pre[page[i]] = i; 
    }
    
    for(int i=1; i<=n; ++i){
        int j;
        int max_dist = 0, p; 
        for(j=1; j<=m; ++j){
            if(block[j] == -1){
                block[j] = page[i]; 
                page_lack++;
                break;
            } else if(block[j] == page[i])
                break;
            
            if(max_dist < dist[i][block[j]]){
                max_dist = dist[i][block[j]];
                p = j;
            }
        }
        if(j > m){
             block[p] = page[i];
             page_lack++; 
        }
        for(int k=1; k<=m; ++k)
            cout<<block[k]<<" ";
        cout<<endl;
    }
    return page_lack;
} 

set<int>page_set;
int FIFO(){
	cout<<"*********FIFO*********"<<endl;
    int page_lack = 0; 
    memset(block, -1, sizeof(block));
    int index = 1;
    for(int i=1; i<=n; ++i){
        if(index > m) index = 1;
        set<int>::iterator it;
        it = page_set.find(page[i]);  
        if(it == page_set.end()){
            if(block[index] != -1)
                page_set.erase(block[index]);
            page_set.insert(page[i]);
            block[index++] = page[i];
            ++page_lack;
        } 
        for(int k=1; k<=m; ++k)
            cout<<block[k]<<" ";
        cout<<endl;
    } 
    return page_lack;
}

int nru[N];
int page_in_block[N];
int CLOCK(){
	cout<<"*********CLOCK*********"<<endl;
    int index = 1;
    int page_lack = 0;
    memset(block, -1, sizeof(block));
    for(int i=1; i<=n; ++i){
        if(page_in_block[page[i]]){ 
            nru[page_in_block[page[i]]] = 1;
        }
        else {
            while(true){
                if(index > m) index = 1;
                if(block[index] == -1) {
                    nru[index] = 1;
                    page_in_block[page[i]] = index;
                    block[index++] = page[i];
                    ++page_lack;
                    break;
                }
                if(block[index] == page[i]){
                    nru[index++] = 1;
                    break;
                } else {
                    if(nru[index] == 0){
                        nru[index] = 1;
                        page_in_block[block[index]] = 0;
                        page_in_block[page[i]] = index;
                        block[index++] = page[i];
                        ++page_lack;
                        break;
                    } else
                        nru[index++] = 0;
                }
            } 
        }
        for(int k=1; k<=m; ++k)    
            cout<<block[k]<<" ";
        cout<<endl;
    }
    return page_lack;
}

int main(){
	cout<<"请输入访问的页面数以及物理块个数"<<endl;
    cin>>n>>m;
    cout<<"请输入页面页号："<<endl;
    for(int i=1; i<=n; ++i){ 
        cin>>page[i];
        page_max = max(page_max, page[i]) ;
    } 
     cout<<"OPT缺页中断次数:"<<OPT()<<endl;
     cout<<"LRU缺页中断次数:"<<LRU()<<endl;
     cout<<"FIFO缺页中断次数:"<<FIFO()<<endl;
     cout<<"CLOCK缺页中断次数:"<<CLOCK()<<endl;
     return 0;
} 

