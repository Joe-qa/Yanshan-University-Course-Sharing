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

namespace 扫雷尝试2
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
            this.Height = 600;
        }
        string buttonName = "";//级别名称
        public int l, h, d;//列，行，预定炸弹数
        private void primary_Click_1(object sender, EventArgs e)
        {
            Controls.Remove(primary);
            Controls.Remove(middle);
            Controls.Remove(zidingyi);
            Controls.Remove(zidingyi);
            l = 9; h = 9; d = 10;
            FangGe();
            Bomb();
            Menu();
            Face();
            buttonName = "primary";
        }//初级

        private void middle_Click(object sender, EventArgs e)
        {
            Controls.Remove(primary);
            Controls.Remove(middle);
            Controls.Remove(zidingyi);
            Controls.Remove(zidingyi);
            l = 16; h = 16; d = 40;
            FangGe();
            Bomb();
            Menu();
            Face();
            buttonName = "middle";
        }//中级

        private void premium_Click(object sender, EventArgs e)
        {
            Controls.Remove(primary);
            Controls.Remove(middle);
            Controls.Remove(zidingyi);
            Controls.Remove(zidingyi);
            l = 16; h = 30; d = 99;
            FangGe();
            Bomb();
            Menu();
            Face();
            buttonName = "premium";
        }//高级

        Button OK = new Button();//确定
        Label[] lb = new Label[3];//显示行，列，炸弹数
        TextBox[] tb = new TextBox[3];//用户输入行，列，炸弹数
        private void zidingyi_Click_1(object sender, EventArgs e)
        {
            Controls.Remove(primary);
            Controls.Remove(middle);
            Controls.Remove(zidingyi);
            Controls.Remove(zidingyi);
            for (int i = 0; i < 3; i++)
            {
                tb[i] = new TextBox();//动态创建textbox让用户输入信息
                tb[i].Location = new Point(200, 200 + i * 30);
                tb[i].Text = "";
                Controls.Add(tb[i]);
                lb[i] = new Label();//动态创建label让用户在相应的地方输入信息
                lb[i].Location = new Point(150, 200 + i * 30);
                Controls.Add(lb[i]);
            }
            lb[0].Text = "行"; lb[1].Text = "列"; lb[2].Text = "炸弹";
            OK.Location = new Point(200, 320);
            OK.Text = "确定";
            Controls.Add(OK);
            OK.Visible = true;
            OK.Click += new EventHandler(OK_Click_1);//事件委托
            buttonName = "zidingyi";
        }//自定义

        private void OK_Click_1(object sender, EventArgs e)
        {
            if (tb[0].Text == "" || tb[1].Text == "" || tb[2].Text == "")
            {
                MessageBox.Show("请输入数字");
            }
            else
            {
                l = int.Parse(tb[0].Text);
                h = int.Parse(tb[1].Text);
                d = int.Parse(tb[2].Text);
                for (int i = 0; i < 3; i++)
                {
                    Controls.Remove(tb[i]); Controls.Remove(lb[i]);
                }
                Controls.Remove(OK);
                FangGe();
                Bomb();
                Menu();
                Face();
                Controls.Remove(lishizuijia);
            }
        }//确定

        public Button[,] fangge;//方格数组
        void FangGe()
        {
            fangge = new Button[h, l];
            for (int i = 0; i < h; i++)
            {
                for (int j = 0; j < l; j++)
                {
                    fangge[i, j] = new Button();
                    fangge[i, j].Tag = "0";
                    fangge[i, j].Height = fangge[i, j].Width = 30;
                    fangge[i, j].Location = new Point(100 + i * 30, 100 + j * 30);
                    fangge[i, j].Text = "";
                    fangge[i, j].Enabled = true;
                    fangge[i, j].Click += new EventHandler(B_Click);
                    fangge[i, j].MouseDown += new MouseEventHandler(MouseDownRight_1);//右键事件委托
                    Controls.Add(fangge[i, j]);
                }
            }
        }//基础方格

        PictureBox face;//笑脸
        void Face()
        {
            face = new PictureBox();
            face.Location = new Point(400, 0);
            face.Size = new Size(50, 50);
            face.SizeMode = PictureBoxSizeMode.StretchImage;
            face.Image = imageList1.Images[6];
            Controls.Add(face);
            face.Click += face_Click;
        }

        void face_Click(object sender, EventArgs e)//笑脸单击事件
        {
            for (int i = 0; i < h; i++)
            {
                for (int j = 0; j < l; j++)
                {
                    Controls.Remove(fangge[i, j]);
                }
            }
            face.Image = imageList1.Images[6];
            FangGe();
            Bomb();
            sj = 0;
            Sj.Text = sj.ToString();
            timer1.Stop();
        }
        void Bomb()//安置炸弹
        {
            Random rd = new Random();
            for (int i = 0; i < d; i++)
            {
                int x = rd.Next(0, h);
                int y = rd.Next(0, l);
                switch (fangge[x, y].Tag.ToString())
                {
                    case "0":
                        fangge[x, y].Tag = "1";
                        fangge[x, y].Text = "炸";
                        break;
                    case "1":
                        do
                        {
                            x = rd.Next(0, h);
                            y = rd.Next(0, l);
                        }
                        while (fangge[x, y].Tag.ToString() == "1");
                        fangge[x, y].Tag = "1";
                        fangge[x, y].Text = "炸";
                        break;
                }
            }
        }

        //设置偏移量
        int[] offsetX = new int[8] { -1, -1, -1, 0, 0, 1, 1, 1 };
        int[] offsetY = new int[8] { -1, 0, 1, -1, 1, -1, 0, 1 };
        void doo(int x, int y)//递推核心
        {
            if (fangge[x, y].Enabled == false)
            {
                return;
            }
            int BombNum = 0;//周围雷数
            for (int i = 0; i < 8; i++)
            {
                if (x + offsetX[i] < 0 || x + offsetX[i] >= h || y + offsetY[i] < 0 || y + offsetY[i] >= l)//如果在边缘
                {
                    continue;
                }
                if (fangge[x + offsetX[i], y + offsetY[i]].Name == "1" || fangge[x + offsetX[i], y + offsetY[i]].Tag.ToString() == "1")//周围是否有雷
                {
                    BombNum++;
                }
            }
            if (BombNum == 0)
            {
                for (int i = 0; i < 8; i++)
                {
                    if (x + offsetX[i] < 0 || x + offsetX[i] >= h || y + offsetY[i] < 0 || y + offsetY[i] >= l || fangge[x + offsetX[i], y + offsetY[i]].Tag.ToString() == "2")
                    {
                        continue;
                    }
                    else
                    {
                        fangge[x, y].Enabled = false;
                        doo(x + offsetX[i], y + offsetY[i]);
                    }
                }
            }
            else
            {
                fangge[x, y].Enabled = false;
                fangge[x, y].Text = BombNum.ToString();
            }
        }

        private void MouseDownRight_1(object sender, MouseEventArgs e)//右键单击事件
        {
            timer1.Start();
            Button b = (Button)sender;
            if (e.Button == MouseButtons.Right)
            {
                face.Image = imageList1.Images[3];
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
                    b.ImageList = null;
                    b.Text = "?";
                    b.Tag = "3";//打问号(呆)
                }
                if (b.Tag.ToString() == "0" || b.Tag.ToString() == "1")
                {
                    b.ImageList = imageList1;
                    b.ImageIndex = 1;
                    b.Text = "";
                    b.Tag = "2";//安旗
                }
            }
            Win();
        }
        public int n, m;//位置坐标
        private void B_Click(object sender, EventArgs e)
        {
            timer1.Start();
            face.Image = imageList1.Images[6];
            Button b = (Button)sender;
            if (b.Tag.ToString() == "1")//如果踩雷
            {
                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        if (fangge[i, j].Tag.ToString() == "1")
                        {
                            fangge[i, j].Image = imageList1.Images[0];//显雷
                            fangge[i, j].Text = "";
                        }
                    }
                }
                face.Image = imageList1.Images[5];
                timer1.Stop();
                MessageBox.Show("         你输了！", "失败", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                //初始化
                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        Controls.Remove(fangge[i, j]);
                    }
                }
                FangGe();
                Bomb();
                face.Image = imageList1.Images[6];
                sj = 0;
                Sj.Text = sj.ToString();
                return;
            }
            else if (b.Tag.ToString() == "2" || b.Tag.ToString() == "3")
            {
                return;
            }
            //获得点击的按钮坐标
            for (int i = 0; i < h; i++)
            {

                for (int j = 0; j < l; j++)
                {
                    if (b == fangge[i, j])
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
                    if (fangge[i, j].Enabled == true && fangge[i, j].Tag.ToString() == "0")
                    {
                        ifwin = false;
                        break;
                    }
                }
            }
            int p = 0;
            for (int q = 0; q < h; q++)//遍历找旗数
            {
                for (int w = 0; w < l; w++)
                {
                    if (fangge[q, w].Tag.ToString() == "2" && fangge[q, w].Name.ToString() == "1")
                    {
                        p++;
                    }

                }
            }
            if (p == d)//判断插旗胜利
            {
                ifwin = true;
            }
            if (ifwin)
            {
                timer1.Stop();

                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        if (fangge[i, j].Tag.ToString() == "1" || fangge[i, j].Name == "1")
                        {
                            fangge[i, j].Image = imageList1.Images[0];//显雷
                            fangge[i, j].Text = "";
                        }
                    }
                }
                face.Image = imageList1.Images[4];
                MessageBox.Show("        你赢了！", "成功", MessageBoxButtons.OK);
                string lszj = "";
                switch (buttonName)
                {
                    case "primary":
                        StreamReader readerPrimary = new StreamReader("初.txt", Encoding.Default);
                        MessageBox.Show(readerPrimary.ReadToEnd().ToString());
                        MessageBox.Show("您的成绩" + sj);
                        readerPrimary.Close();
                        readerPrimary = new StreamReader("初.txt", Encoding.Default);
                        for (int i = 0; i < 3; i++)
                        {
                            lszj = readerPrimary.ReadLine();
                        }
                        readerPrimary.Close();
                        int minPrimary = Math.Min(sj, int.Parse(lszj));

                        if (minPrimary == sj)
                        {
                            MessageBox.Show("恭喜您，创造了奇迹");
                            FileStream fsPrimary = new FileStream("初.txt", FileMode.Open);
                            StreamWriter swPrimary = new StreamWriter(fsPrimary);
                            try
                            {
                                swPrimary.WriteLine("Primary");
                                swPrimary.WriteLine("the best of history");
                                swPrimary.WriteLine(sj);
                                swPrimary.WriteLine("finish");
                            }
                            finally
                            {
                                swPrimary.Flush();
                                swPrimary.Close();
                                fsPrimary.Close();
                            }
                        }
                        else
                        {
                            MessageBox.Show("可惜，没能打破记录，让我们一起仰望吧");
                        }
                        break;
                    case "middle":
                        StreamReader readerMiddle = new StreamReader("中.txt", Encoding.Default);

                        MessageBox.Show(readerMiddle.ReadToEnd().ToString());
                        MessageBox.Show("您的成绩" + sj);

                        readerMiddle.Close();
                        readerMiddle = new StreamReader("中.txt", Encoding.Default);
                        for (int i = 0; i < 3; i++)
                        {
                            lszj = readerMiddle.ReadLine();
                        }
                        readerMiddle.Close();
                        int minMiddle = Math.Min(sj, int.Parse(lszj));

                        if (minMiddle == sj)
                        {

                            MessageBox.Show("恭喜您，创造了奇迹");
                            FileStream fsMiddle = new FileStream("中.txt", FileMode.Open);
                            StreamWriter swMiddle = new StreamWriter(fsMiddle);
                            try
                            {
                                swMiddle.WriteLine("Middle");
                                swMiddle.WriteLine("the best of history");
                                swMiddle.WriteLine(sj);
                                swMiddle.WriteLine("finish");
                            }
                            finally
                            {
                                swMiddle.Flush();
                                swMiddle.Close();
                                fsMiddle.Close();
                            }
                        }
                        else
                        {
                            MessageBox.Show("可惜，没能打破记录，让我们一起仰望吧");
                        }
                        break;
                    case "premium":
                        StreamReader readerPrimium = new StreamReader("高.txt", Encoding.Default);
                        MessageBox.Show(readerPrimium.ReadToEnd().ToString());
                        MessageBox.Show("您的成绩" + sj);


                        readerPrimium.Close();
                        readerPrimium = new StreamReader("高.txt", Encoding.Default);
                        for (int i = 0; i < 3; i++)
                        {
                            lszj = readerPrimium.ReadLine();
                        }
                        readerPrimium.Close();
                        int minPrimium = Math.Min(sj, int.Parse(lszj));

                        if (minPrimium == sj)
                        {
                            MessageBox.Show("恭喜您，创造了奇迹");
                            FileStream fsPrimium = new FileStream("高.txt", FileMode.Open);
                            StreamWriter swPrimium = new StreamWriter(fsPrimium);
                            try
                            {
                                swPrimium.WriteLine("Premium");
                                swPrimium.WriteLine("the best of history");
                                swPrimium.WriteLine(sj);
                                swPrimium.WriteLine("finish");
                            }
                            finally
                            {
                                swPrimium.Flush();
                                swPrimium.Close();
                                fsPrimium.Close();
                            }
                        }
                        else
                        {
                            MessageBox.Show("可惜，没能打破记录，让我们一起仰望吧");
                        }
                        break;
                    case "zidingyi":
                        break;
                    default:
                        break;

                }
                //初始化
                for (int i = 0; i < h; i++)
                {
                    for (int j = 0; j < l; j++)
                    {
                        Controls.Remove(fangge[i, j]);
                    }
                }
                FangGe();
                Bomb();
                face.Image = imageList1.Images[6];
                sj = 0;
                Sj.Text = sj.ToString();
                return;//结束函数
            }
        }

        Button tuichu;//退出
        Button zhucaidan;//主菜单
        Button lishizuijia;//历史最佳
        new void Menu()
        {
            tuichu = new Button();
            tuichu.Text = "退出";
            tuichu.Location = new Point(1, 1);
            tuichu.Height = tuichu.Width = 50;
            Controls.Add(tuichu);
            tuichu.Click += new EventHandler(tuichu_Click_1);

            zhucaidan = new Button();
            zhucaidan.Text = "主菜单";
            zhucaidan.Location = new Point(51, 1);
            zhucaidan.Height = zhucaidan.Width = 50;
            Controls.Add(zhucaidan);
            zhucaidan.Click += new EventHandler(zhucaidan_Click_1);

            lishizuijia = new Button();
            lishizuijia.Text = "历史最佳";
            lishizuijia.Location = new Point(101, 1);
            lishizuijia.Size = new Size(50, 50);
            Controls.Add(lishizuijia);
            lishizuijia.Click += lishizuijia_Click;

            Controls.Add(Sj);//加入时间表
            Sj.Text = sj.ToString();
            Sj.Size = new Size(60, 60);
            Sj.Font = new Font("宋体", 38, FontStyle.Bold);

            Sj.Location = new Point(450, 0);
        }

        private void lishizuijia_Click(object sender, EventArgs e)
        {

            switch (buttonName)
            {
                case "primary":
                    StreamReader readerPrimary = new StreamReader("初.txt", Encoding.Default);
                    MessageBox.Show(readerPrimary.ReadToEnd().ToString());
                    readerPrimary.Close();

                    break;
                case "middle":
                    StreamReader readerMiddle = new StreamReader("中.txt", Encoding.Default);
                    MessageBox.Show(readerMiddle.ReadToEnd().ToString());
                    break;
                case "premium":
                    StreamReader readerPrimium = new StreamReader("高.txt", Encoding.Default);
                    MessageBox.Show(readerPrimium.ReadToEnd().ToString());
                    break;
                default:
                    break;

            }
        }
        private void tuichu_Click_1(object sender, EventArgs e)
        { this.Close(); }
        private void zhucaidan_Click_1(object sender, EventArgs e)
        {
            sj = 0;
            Sj.Text = sj.ToString();
            timer1.Stop();
            for (int i = 0; i < h; i++)
            {
                for (int j = 0; j < l; j++)
                {
                    Controls.Remove(fangge[i, j]);
                }
            }
            OK.Click -= new EventHandler(OK_Click_1);//删除事件委托
            Controls.Remove(tuichu); Controls.Remove(zhucaidan); Controls.Remove(face); Controls.Remove(Sj); Controls.Remove(lishizuijia);
            Controls.Add(primary); Controls.Add(middle); Controls.Add(zidingyi); Controls.Add(zidingyi);
        }
        int sj = 0;
        Label Sj = new Label();
        private void timer1_Tick(object sender, EventArgs e)
        {
            sj++;
            Sj.Size = new Size(300, 100);
            Sj.Text = sj.ToString();
        }
    }
}