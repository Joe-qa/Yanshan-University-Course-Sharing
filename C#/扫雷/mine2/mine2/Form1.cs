using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace mine2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.Text = "扫雷";
            this.Width = 800;
            this.Height = 600;//界面
        }
        public Button[,] mine;//按扭二维数组
        void Mine()//产生界面
        {
            mine = new Button[h, l];
            for (int i = 0; i < h; i++)
            {
                for (int j = 0; j < l; j++)
                {
                    mine[i, j] = new Button();
                    mine[i, j].Tag = "0";//无雷
                    mine[i, j].Height = mine[i, j].Width = 30;
                    mine[i, j].Location = new Point(100 + i * 30, 100 + j * 30);//方格的位置
                    mine[i, j].Text = "";
                    mine[i, j].Enabled = true;
                    mine[i, j].Click += new EventHandler(B_Click);
                    mine[i, j].MouseDown += new MouseEventHandler(MouseDownRight_1);//右键事件委托
                    Controls.Add(mine[i, j]);
                }
            }
        }
        void Bomb()//埋雷
        {
            Random rd = new Random();
            for (int i = 0; i < d; i++)
            {
                int x = rd.Next(0, h);
                int y = rd.Next(0, l);
                switch (mine[x, y].Tag.ToString())
                {
                    case "0":
                        mine[x, y].Tag = "1";//有雷
                        mine[x, y].Text = "炸";
                        break;
                    case "1":
                        do
                        {
                            x = rd.Next(0, h);
                            y = rd.Next(0, l);
                        }
                        while (mine[x, y].Tag.ToString() == "1");
                        mine[x, y].Tag = "1";
                        mine[x, y].Text = "炸";
                        break;
                }
            }
        }
        //核心算法
        int[] offsetX = new int[8] { -1, -1, -1, 0, 0, 1, 1, 1 };
        int[] offsetY = new int[8] { -1, 0, 1, -1, 1, -1, 0, 1 };
        void doo(int x, int y)//递推判断周围是否有雷
        {
            if (mine[x, y].Enabled == false)
            {
                return;
            }
            int Bombnum = 0;
            for (int i = 0; i < 8; i++)
            {
                if (x + offsetX[i] < 0 || x + offsetX[i] >= h || y + offsetY[i] < 0 || y + offsetY[i] >= l)//边缘位置
                {
                    continue;
                }
                if (mine[x + offsetX[i], y + offsetY[i]].Name == "1" || mine[x + offsetX[i], y + offsetY[i]].Tag.ToString() == "1")
                {
                    Bombnum++;
                }
            }
            if (Bombnum == 0)
            {
                for (int i = 0; i < 8; i++)
                {
                    if (x + offsetX[i] < 0 || x + offsetX[i] >= h || y + offsetY[i] < 0 || y + offsetY[i] >= l || mine[x + offsetX[i], y + offsetY[i]].Tag.ToString() == "2")
                    {
                        continue;
                    }
                    else
                    {
                        mine[x, y].Enabled = false;
                        doo(x + offsetX[i], y + offsetY[i]);
                    }
                }
            }
            else
            {
                mine[x, y].Enabled = false;
                mine[x, y].Text = Bombnum.ToString();
            }
        }
        public int l, h, d;
        private void button1_Click(object sender, EventArgs e)
        {
            l = 9; h = 9; d = 10;
            Mine();
            Bomb();
        }
        private void MouseDownRight_1(object sender, MouseEventArgs e)//鼠标右键单击事件
        {
            Button b = (Button)sender;
            if (e.Button == MouseButtons.Right)
            {
                if (b.Tag.ToString() == "0" || b.Tag.ToString() == "1")
                {
                    b.Name = b.Tag.ToString();
                }
                if (b.Tag.ToString() == "3")
                {
                    b.Tag = b.Name;
                    b.Text = "炸";
                    return;
                }
                if (b.Tag.ToString() == "2")
                {
                    b.Text = "?";
                    b.Tag = "3";
                }
                if (b.Tag.ToString() == "0" || b.Tag.ToString() == "1")
                {
                    b.Text = "";
                    b.Tag = "2";
                }
            }
            Win();
        }
        public int m,n;
        public void B_Click(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            if (b.Tag.ToString() == "1")
            {
                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        if (mine[i, j].Tag.ToString() == "1")
                        {
                            mine[i, j].Text = "";
                        }
                    }
                }
                    MessageBox.Show("你输了", "失败", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Warning);
                    for (int i = 0; i < h; i++)
                    {
                        for (int j = 0; j < l; j++)
                        {
                            Controls.Remove(mine[i, j]);
                        }
                    }
                    Mine();
                    Bomb();
                    return;
                }
            else if (b.Tag.ToString() == "2" || b.Tag.ToString() == "3")
            {
                return;
            }
            for (int i = 0; i < h; i++)
            {
                for (int j = 0; j < l; j++)
                {
                    if (b == mine[i, j])
                    {
                        n = i;
                        m = j;
                    }
                }
            }
            doo(n, m);
            Win();
        }
        void Win()
        {
            bool ifwin = true;
            for (int i = 0; i < h; i++)
            {
                if (ifwin == false)
                    break;
                for (int j = 0; j < l; j++)
                {
                    if (mine[i, j].Enabled == true && mine[i, j].Tag.ToString() == "0")
                    {
                        ifwin = false;
                        break;
                    }
                }
            }
            if (ifwin)
            {
                //for (int i = 0; i < h; i++)
                //{
                //    for (int j = 0; j < l; j++)
                //    {
                //        if (mine[i, j].Tag.ToString() == "1" || mine[i, j].Name == "1")
                //        {
                //            mine[i, j].Text = "";
                //        }
                //    }

                    MessageBox.Show("你赢了", "成功", MessageBoxButtons.OK);
                
                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        Controls.Remove(mine[i, j]);
                    }
                }
                Mine();
                Bomb();
            }
            return;
        }
        private void button1_Click_1(object sender, EventArgs e)
        {
            l = 9; h = 9; d = 10;
            Mine();
            Bomb();
        }
    }

}
