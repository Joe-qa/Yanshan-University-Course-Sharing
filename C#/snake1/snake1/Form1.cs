using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace snake1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.Top = 200;
            this.Left = 200;
            this.Width = 800;
            this.Height = 800;
            this.BackColor = Color.Black;
            this.Text = "贪吃蛇";
            this.KeyDown += new KeyEventHandler(Form1_KeyDown);
            dt.Tick += new EventHandler(dt_Tick);
            dt.Start(); 
            CreatSnake();
            Move();
            Eat();
        }
       public static Label[] lal = new Label[100];
        Random rd=new Random();
        public int length=4;
           void CreatSnake()
        {
            for (int i = 0; i < length; i++)
            {
                Label l = new Label();
                l.Width = l.Height = 20;
                l.Top = 400;
                l.Left = 200 - i * 20;
                l.BackColor = Color.Red;
                l.Text = i.ToString();
                lal[i] = l;
                Controls.Add(l);
            }
               
       }
         Label s = new Label();
           void CreatFood()
           {
               s.Width = s.Height = 20;
               s.Top = rd.Next(1, 800);
               s.Left = rd.Next(1, 800);
               s.BackColor = Color.Yellow;
               Controls.Add(s);
           }
           void Eat()
           {
               if (lal[0].Top == s.Top && lal[0].Left == s.Left)
               {
                   length++;
                   for (int i = 1; i < length; i++)
                   {
                       lal[i].Left = lal[i - 1].Left;
                       lal[i].Top = lal[i - 1].Top;
                   }
                   lal[0].Left = s.Left;
                   lal[0].Top = s.Top;
                   Controls.Remove(s);
                   lal[length - 1].Width = lal[length - 1].Height = 20;
                   lal[length- 1].BackColor = Color.Red;
                   lal[length - 1].Text = (length - 1).ToString();
                   Controls.Add(lal[length - 1]);
               }
               CreatFood();
           }
        public string direction="right";
        void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if ((int)e.KeyCode == 37)
                direction = "left";
            if ((int)e.KeyCode == 38)
                direction = "up";
            if ((int)e.KeyCode == 399)
                direction = "right";
            if ((int)e.KeyCode == 40)
                direction = "down";
        }
        void Move()
    {
        switch ("direction")
        {
            case "left":
                {
                    for (int i = 0; i < length; i++)
                        lal[i].Left -= 20;
                }
                break;
            case "right":
                {
                    for (int i = 0; i < length; i++)
                        lal[i].Left += 20;
                }
                break;
            case "up":
                {
                    for (int i = 0; i < length; i++)
                        lal[i].Top -= 20;
                }
                break;
            case "down":
                {
                    for (int i = 0; i < length; i++)
                        lal[i].Left += 20;
                }
                break;
        }
    }

        private void dt_Tick(object sender, EventArgs e)
        {
            CreatSnake();
            Move();
        }
    }
}
