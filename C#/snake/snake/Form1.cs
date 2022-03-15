using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace snake
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        string key_name = "start";   //记录键盘状态
        Label[] l_b = new Label[30];   //贪吃蛇身体数组
        Random r = new Random();    //随机数
        int a = 0, b = 0;           //变量，记录坐标   
        private void Form1_Load(object sender, EventArgs e)
        {
            //设定初始界面状态
            this.Top = 120;
            this.Left = 120;
            this.Width = 800;
            this.Height = 600;
            this.BackColor = Color.Black;
            //造 蛇 身体，长度为5
            for (int i = 0; i < 5; i++)
            {
                Label lb = new Label();
                lb.Width = lb.Height = 20;
                lb.Top = 400;
                lb.Left = 400 - i * 20;
                lb.BackColor = Color.Red;
                lb.Text = "O";
                lb.Font = new System.Drawing.Font("宋体", 18);
                lb.Tag = i;
                l_b[i] = lb;
                this.Controls.Add(lb);
            }
            //控件Timer
            dt.Tick += new EventHandler(dt_Tick);
            //键盘敲击事件
            this.KeyDown += new KeyEventHandler(Form1_KeyDown);

            snake_food();    //造 蛇 的食物函数
            dt.Start();    //Timer 开始
        }
        void dt_Tick(object sender, EventArgs e)
        {
            int x_1, y_1;
            x_1 = l_b[0].Left;
            y_1 = l_b[0].Top;
            if (key_name == "start")     //键盘状态处于初始状态
            {
                l_b[0].Left = x_1 + 20;
                snake_move(x_1, y_1);
            }
            if (key_name == "Right")   //键盘状态处于  向右 状态
            {
                l_b[0].Left = x_1 + 20;
                snake_move(x_1, y_1);
            }
            if (key_name == "Up")     //键盘状态处于  向上  状态
            {
                l_b[0].Top = y_1 - 20;
                snake_move(x_1, y_1);
            }
            if (key_name == "Down")   //键盘状态处于  向下  状态
            {
                l_b[0].Top = y_1 + 20;
                snake_move(x_1, y_1);
            }
            if (key_name == "Left")    //键盘状态处于   向左 状态
            {
                l_b[0].Left = x_1 - 20;
                snake_move(x_1, y_1);
            }
            //          穿墙设置
            if (x_1 > 800)            
            {
                l_b[0].Left = 0; ;
            }
            if (x_1 < 0)
            {
                l_b[0].Left = 800;
            }
            if (y_1 > 600)
            {
                l_b[0].Top = 0;
            }
            if (y_1 < 0)
            {
                l_b[0].Left = 600;
            }
            //每动一次，判断是否与食物重合
            eat_time();
        }
        //敲击键盘响应
        void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            //记录蛇头坐标
            int x_1, y_1;
            x_1 = l_b[0].Left;
            y_1 =l_b[0].Top;
            //获取按了什么键
            key_name = e.KeyCode.ToString();

            if (e.KeyCode.ToString() == "Right")   //向右
            {
                l_b[0].Left= x_1 + 20;
                snake_move(x_1, y_1);
            }
            if (e.KeyCode.ToString() == "Up")    //向上
            {
                l_b[0].Top= y_1 - 20;
                snake_move(x_1, y_1);
            }
            if (e.KeyCode.ToString() == "Down")     //向下
            {
                l_b[0].Top= y_1 + 20;
                snake_move(x_1, y_1);
            }
            if (e.KeyCode.ToString() == "Left")    //向左
            {
                l_b[0].Left= x_1 - 20;
                snake_move(x_1, y_1);
            }
            //每按一次，判断是否与食物重合
            eat_time();
        }
        //吃的一瞬间
        void eat_time()
        {
            double x1 = 20, y1 = 20, x2 = 20, y2 = 20;
            foreach (Label lb in this.Controls)
            {
                if (lb.Tag.ToString() == "food".ToString())
                {
                    x2 = lb.Left;
                    y2 = lb.Top;
                }
                if (lb.Tag.ToString() == "0".ToString())
                {
                    x1 = lb.Left;  //左
                    y1 = lb.Top;  //上
                }
            }
            if (x2==x1&&y2==y1)
            {
                snake_eat();
                foreach (Label lb in this.Controls)
                {
                    if (lb.Tag.ToString() == "food".ToString())
                    {
                        lb.Top = r.Next(1, 30) * 20;
                        lb.Left = r.Next(1, 30) * 20;
                    }
                }
            }
        }
        //蛇移动函数
        /*主要思路：保证 蛇 的每一块，移动的下次方向为这块（第N块）的前一块（N-1）*/

        void snake_move(int x_1, int y_1)
        {
            int xx = 0;
            int yy = 0;
            for (int i = 1; l_b[i] != null; i++)
            {
                if (i >= 3)
                {
                    xx = a;
                    yy = b;
                }
                if (i == 1)
                {
                    xx =l_b[i].Left;
                    yy = l_b[i].Top;
                    l_b[i].Left= x_1;
                    l_b[i].Top= y_1;
                }
                else
                {
                    a =l_b[i].Left;
                    b = l_b[i].Top;
                    l_b[i].Left= xx;
                    l_b[i].Top= yy;
                }
            }
        }
        //制造食物
        void snake_food()
        {
            double xx = l_b[0].Left;
            double yy = l_b[0].Top;
            Label lb = new Label();
            lb.Width = 20;
            lb.Height = 20;
            lb.Top= r.Next(1, 30) * 20;
            lb.Left= r.Next(1, 30) * 20;
            lb.Tag = "food";
            lb.BackColor = Color.Yellow;
            this.Controls.Add(lb);
        }

        //吃过的食物，变为 蛇 的一部分
        void snake_eat()
        {
            int i = 0;
            for (; l_b[i] != null; i++);
            Label lb = new Label();
            lb.Width = lb.Height = 20;
            lb.Top = b;
            lb.Left = a;
            lb.BackColor = Color.Red;
            lb.Text = "O";
            lb.Font = new System.Drawing.Font("宋体", 18);
            lb.Tag = i;
            l_b[i] = lb;
            this.Controls.Add(lb);
        }
    }
}
