using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace mine
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            __init__(10);
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
          Button[,] btns;
        int level;
        void __init__(int lev)
        {
            this.level = lev;
            btns = new Button[level+2, level+2];
            for (int i = 0; i < level+2; i++)
            {
                for (int j = 0; j < level+2; j++)
                {
                    Button btn = new Button();
                    btn.Size = new Size(40, 40);
                    btn.Location = new Point(40 + 40 * j, 40 + 40 * i);
                    Controls.Add(btn);
                    btn.Click += new EventHandler(mine_click);
                    btn.Tag = i.ToString() + "," + j.ToString() + ",#";
                    btns[i, j] = btn;
                    if (i == 0 || i == level + 1 || j == 0 || j == level + 1)
                    {
                        btn.Tag = i.ToString() + "," + j.ToString() + ",*";
                        //btn.Visible = false;
                        btn.Enabled = false;
                        btn.Text = "*";
                    }
                }
            }
            mine_make();
        }

        void mine_make()
        {
            Random rd = new Random();
            int num = 0;
            while (true)
            {
                int rd1 = rd.Next(level);
                int rd2 = rd.Next(level);
                if (btns[rd1, rd2].Tag.ToString().Split(',')[2] != "*")
                {
                    btns[rd1, rd2].Tag = rd1.ToString() + "," + rd2.ToString() + ",*";
                    num++;
                }
                if (num == 30)
                    break;
            }
        }

        void mine_click(object sender, EventArgs e)
        {
            Button click_btn = (Button)sender;
            string[] tag = click_btn.Tag.ToString().Split(',');
            if(tag[2]=="*")
            {
                for(int i = 1; i < level + 1; i++)
                {
                    for(int j = 1; j < level + 1; j++)
                    {
                        btns[i, j].Enabled = false;
                        if (btns[i, j].Tag.ToString().Split(',')[2] == "*")
                            btns[i, j].Text = "*";
                    }
                }
            }
            else
                digui(int.Parse(tag[0]), int.Parse(tag[1]));
        }

        void digui(int x, int y)
        {
            string tag = btns[x, y].Tag.ToString().Split(',')[2];
            if (tag != "*")
            {
                btns[x, y].Enabled = false;
                int num = 0;
                for (int i = x - 1; i <= x + 1; i++)
                {
                    for (int j = y - 1; j <= y + 1; j++)
                    {
                        string tag_temp = btns[i, j].Tag.ToString().Split(',')[2];
                        if (tag_temp == "*")
                            num++;
                        else
                        {
                            if (i == x || j == y)
                            {
                                if (btns[i, j].Enabled == true)
                                {
                                    digui(i, j);
                                }

                            }

                        }
                    }
                }
                btns[x, y].Text = num.ToString();
            }
        }
    }
}
