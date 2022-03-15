#include<iostream>
#include<queue>
#include <windows.h>
#include<ctime>


using namespace std;

static const int item_total = 100; //总共要生产 item_total个item

// 缓存结构体, 使用队列当做缓存
struct Buffer 
{
   queue<int> buffer;
    int in;
    int out;
}buffer_res;

typedef struct Buffer Buffer;

void porduce_item(Buffer *b, int item)
{
    // 向缓存中添加item
    b->buffer.push(item);
    b->in++;
    Sleep(200);
}

int consume_item(Buffer *b)
{
	if(b->buffer.size()>0){
    int item=b->buffer.front();
    b->out++;
    b->buffer.pop();
    Sleep(200);
    return item;
}
}

//生产者任务
void producer() {
    for (int i = 1; i<= item_total;i++) {
        cout << "prodece the " << i << "^th item ..." << endl;
        porduce_item(&buffer_res, i);
    }
}

//消费者任务
void consumer()
{
    static int cnt = 0;
    while(1) {
        Sleep(1);
        int item = consume_item(&buffer_res);
        cout << "consume the " << item << "^th item" << endl;
        if (++cnt == item_total)
            break;
    }
}

//初始化 buffer
void init_buffer(Buffer *b)
{
    b->in = 0;
    b->out = 0;
}

int main()
{
	clock_t startTime, endTime;
	startTime = clock();//计时开始
    init_buffer(&buffer_res);
    producer();
    consumer();
    endTime = clock();//计时结束
	cout << "The run time is: " << (double)(endTime - startTime) / CLOCKS_PER_SEC << "s" << endl;
    getchar();
}

