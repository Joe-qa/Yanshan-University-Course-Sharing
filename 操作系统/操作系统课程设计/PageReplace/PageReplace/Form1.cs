using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace PageReplace
{
    public partial class Form1 : Form
    {
        private string[] logicalAddress = null;//输入的逻辑地址
        public int[] visitPages = null;//访问的页面序列
        public int visitNum;//需要访问的页面数
        public int memBlockNum;      //物理块数量
        private int memoryAccessTime = 50;//访问一次内存的时间
        private int FasttableAccessTime =5;//访问快表时间
        private int MissingpagesTime = 1000; //缺页中断时间
        private int[] OPTphysicalAddress = null;//OPT得到的物理块号
        private int[] FIFOphysicalAddress = null;//FIFO得到的物理块号
        private int[] LRUphysicalAddress = null;//LRU得到的物理块号
        public int[] pageTable = null;//页表
        private string[] withinPageaddress = null;
        private double FIFOtime=0;
        private double FIFOlackrate=0;
        private double LRUtime=0;
        private double LRUlackrate=0;
        private double OPTtime=0;
        private double OPTlackrate=0;
        bool fast=true;
        Pen p=new Pen(Color.Black);
        Brush Blackbrush = new SolidBrush(Color.Black);
        Brush Redbrush = new SolidBrush(Color.Red);
        Mutex mutex= new Mutex();
        Thread FIFOThread = null;
        Thread LRUThread = null;
        Thread OPTThread = null;
        int FIFOtableX = 10;
        int FIFOtableY= 10;
        int FIFOtableCurrentX=10;
        int FIFOtableCurrentY=10;
        int LRUtableX = 10;
        int LRUtableY=10;
        int LRUtableCurrentX = 10;
        int LRUtableCurrentY = 10;
        int OPTtableX = 10;
        int OPTtableY=10;
        int OPTtableCurrentX = 10;
        int OPTtableCurrentY = 10;
        int tablewidth = 38;
        int tableheight = 15;
        public Form1()
        {
            InitializeComponent();
            CheckForIllegalCrossThreadCalls = false;
            btnFIFO.Enabled = true;
            btnStopFIFO.Enabled = false;
            btnLRU.Enabled = true;
            btnStopLRU.Enabled = false;
            btnOPT.Enabled = true;
            btnStopOPT.Enabled = false;
            btnALL.Enabled = true;
            btnStopALL.Enabled = false;
            int num = int.Parse(memblockTextbox.Text);
            pageTable = new int[num] ;
            Random rd = new Random((int)DateTime.Now.Ticks);
            Dictionary<int, int> mp = new Dictionary<int, int>();
            int temp;
            for (int i = 0; i < num;)
            {
                temp = rd.Next(10);
                if (!mp.ContainsKey(temp))
                {
                    mp.Add(temp, 1);
                    pageTable[i] = temp;
                    i++;
                }
                else
                    continue;
            }
            memblockTextbox_lostFocus(null,null);
        }
        public void FIFO()
        {
            Bitmap bp = new Bitmap(1000, 300);
            Graphics g = Graphics.FromImage(bp);
            g.Clear(Color.White);
            FIFOtableCurrentX = FIFOtableX;
           mutex.WaitOne();
            FIFOtableCurrentY = FIFOtableY;
        
            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth*2, tableheight);
            g.DrawString("访问页面", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
            for(int i = 0; i < memBlockNum; i++)
            {
                FIFOtableCurrentY += tableheight;
                g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth *2, tableheight);
                g.DrawString("物理块"+(i+1), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
            }
            FIFOtableCurrentY += tableheight;
            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("是否缺页", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
            FIFOtableCurrentY += tableheight;
            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("缺页数", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);

            FIFOtableCurrentY += tableheight;
            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("物理地址", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);

            mutex.ReleaseMutex();
            FIFOtableCurrentX += tablewidth *2;
            int totalSleep = 0;
            Queue<int> q=new Queue<int>();
            FIFOphysicalAddress = new int[visitNum];
            int[] memBlock = new int[memBlockNum];
            for (int i = 0; i < memBlockNum; i++)
                memBlock[i] = -1;
            int missingPageNum = 0;
            int sleepTime = 0;
            int num = 0;
            for(int i = 0; i < visitNum; i++)
            {
                sleepTime = 0;
                FIFOtableCurrentY = FIFOtableY;

                bool flag = false;
                    for(int j= 0; j < memBlockNum; j++)
                    {
                        if(visitPages[i]==memBlock[j])
                        {
                            flag = true;
                            break;
                        }
                    }
                    if (!flag)
                    {
                        if (missingPageNum < memBlockNum)
                    { 
                        memBlock[num] = visitPages[i];
                        FIFOphysicalAddress[i] = num;
                        num++;
                        q.Enqueue(visitPages[i]);
                            missingPageNum++;

                            mutex.WaitOne();
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);

                            for (int j = 0; j < memBlockNum; j++)
                            {
                                FIFOtableCurrentY += tableheight;
                                if (j < missingPageNum)
                                {

                                    g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                                }
                                else
                                {
                                    g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                                }
                            }

                            FIFOtableCurrentY += tableheight;
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                        
                            FIFOtableCurrentY += tableheight;
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                        FIFOtableCurrentY += tableheight;
                        g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[FIFOphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
                        FIFOtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();
                            if (fast)
                                sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                    + memoryAccessTime;
                            else
                                sleepTime = memoryAccessTime * 3 + MissingpagesTime;
                        }
                        else
                        {
                            int page = q.Dequeue();
                            q.Enqueue(visitPages[i]);
                            for (int j = 0; j < memBlockNum; j++)
                            {
                                if (page == memBlock[j])
                                {
                                    memBlock[j] = visitPages[i];
                                FIFOphysicalAddress[i] = j;
                                break;
                                }
                            }
                            missingPageNum++;
                            mutex.WaitOne();
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);


                            for (int j = 0; j < memBlockNum; j++)
                            {
                                FIFOtableCurrentY += tableheight;
                                g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                                if (memBlock[j] == visitPages[i])
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Redbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                                else
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                            }
                            FIFOtableCurrentY += tableheight;
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 12, FIFOtableCurrentY + 2);
                        
                            FIFOtableCurrentY += tableheight;
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                        FIFOtableCurrentY += tableheight;
                        g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[FIFOphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
                        FIFOtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 3 + MissingpagesTime;
                    }
                    }
                    else
                    {
                    for (int j = 0; j < memBlockNum; j++)
                    {
                        if (visitPages[i] == memBlock[j])
                        {
                            FIFOphysicalAddress[i] = j;
                            break;
                        }
                    }
                    mutex.WaitOne();
                        g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                        g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                        for (int j = 0; j < memBlockNum + 2; j++)
                        {
                            FIFOtableCurrentY += tableheight;
                            g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);

                        }
                        g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 15, FIFOtableCurrentY + 2);
                        FIFOtableCurrentY += tableheight;
                        g.DrawRectangle(p, FIFOtableCurrentX, FIFOtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[FIFOphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
                       mutex.ReleaseMutex();
                        FIFOtableCurrentX += tablewidth;
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 2;
                    }
            
                totalSleep += sleepTime;
                this.BeginInvoke(new Action(() =>
                {
                   
                    FIFOLacklabel.Text = "FIFO当前缺页率：" + missingPageNum + "/" + (i + 1) + "=" + ((missingPageNum * 1.0 / (i + 1)) * 100).ToString("F2") + "%";
                }));

                this.BeginInvoke(new Action(() =>
                {
                   
                    lableFIFOsleep.Text = "FIFO当前累计用时：" + totalSleep + "nm";
                }));
                g.Save();
                pictureBoxFIFO.Image = bp;
                Thread.Sleep(sleepTime);
               
            }
            mutex.WaitOne();
            FIFOtableCurrentY = FIFOtableY;
            g.DrawString("缺页率为" + ((double)missingPageNum / visitNum * 100) + "%", new Font("黑体", 12), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
            FIFOtableCurrentY += tableheight;
            g.DrawString("总时间为：" + totalSleep+"ns", new Font("黑体", 12), Blackbrush, FIFOtableCurrentX + 2, FIFOtableCurrentY + 2);
            g.Save();
            pictureBoxFIFO.Image = bp;
            mutex.ReleaseMutex();
            FIFOtime = totalSleep;
            FIFOlackrate = (double)missingPageNum / visitNum * 100;


            string currPath = Application.StartupPath;
            string subPath = currPath + "/testData/";
            if (false == Directory.Exists(subPath))
            {
                Directory.CreateDirectory(subPath);
            }
            string temp = subPath + "FIFO/";
            if (false == Directory.Exists(temp))
            {
                Directory.CreateDirectory(temp);
            }
            string filename = temp + "FIFOdata.txt";
            string nowtime= DateTime.Now.ToString();
            string temptime=nowtime.Replace(" ","");
            temptime = temptime.Replace("/", "");
            temptime = temptime.Replace(":", "");
            if (!File.Exists(filename))
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:" + nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[FIFOphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为：" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            else
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:" + nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[FIFOphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为：" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            string path= temp + temptime +".bmp";
            Thread.Sleep(2000);
            bp.Save(path, System.Drawing.Imaging.ImageFormat.Bmp);
        }
        public void LRU()
        {
            Bitmap bp = new Bitmap(1000, 300);
            Graphics g = Graphics.FromImage(bp);
            g.Clear(Color.White);
            LRUtableCurrentX = LRUtableX;

            mutex.WaitOne();
            LRUtableCurrentY = LRUtableY;
            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("访问页面", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
            for (int i = 0; i < memBlockNum; i++)
            {
                LRUtableCurrentY += tableheight;
                g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth * 2, tableheight);
                g.DrawString("物理块"+(i+1), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
            }
            LRUtableCurrentY += tableheight;
            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("是否缺页", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
            LRUtableCurrentY += tableheight;
            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("缺页数", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);

            LRUtableCurrentY += tableheight;
            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("物理地址", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
            mutex.ReleaseMutex();
            LRUtableCurrentX += tablewidth * 2;
            int totalSleep = 0;
            int sleepTime = 0;
            int num = 0;
            Dictionary<int, int> map = new Dictionary<int, int>();
            LRUphysicalAddress = new int[visitNum];
            int[] memBlock = new int[memBlockNum];
            for (int i = 0; i < memBlockNum; i++)
                memBlock[i] = -1;
            int missingPageNum = 0;
            for (int i = 0; i < visitNum; i++)
            {
                
                LRUtableCurrentY = LRUtableY;
                bool flag = false;
                    for (int j = 0; j < memBlockNum; j++)
                    {
                        if (visitPages[i] == memBlock[j])
                        {
                            flag = true;
                            break;
                        }
                    }
                    if (!flag)
                    {
                        if (missingPageNum < memBlockNum)
                        {

                        memBlock[num] = visitPages[i];
                        LRUphysicalAddress[i] = num;
                        num++;
                   
                            missingPageNum++;
                            map.Add(visitPages[i], i);

                            mutex.WaitOne();

                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);

                            for (int j = 0; j < memBlockNum; j++)
                            {
                                LRUtableCurrentY += tableheight;
                                if (j < missingPageNum)
                                {

                                    g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                                }
                                else
                                {
                                    g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                                }
                            }

                            LRUtableCurrentY += tableheight;
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 12, LRUtableCurrentY + 2);


                            LRUtableCurrentY += tableheight;
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                        LRUtableCurrentY += tableheight;
                        g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
                        LRUtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 3 + MissingpagesTime;
                    }
                        else
                        {
                            int mn = 999;
                            int page = -1;

                            foreach (var item in map)
                            {
                                for (int j = 0; j < memBlockNum; j++)
                                    if (mn > item.Value && item.Key == memBlock[j])
                                    {
                                        mn = item.Value;
                                        page = item.Key;
                                    }
                            }
                            for (int j = 0; j < memBlockNum; j++)
                            {
                                if (page == memBlock[j])
                                {
                                    memBlock[j] = visitPages[i];
                                    LRUphysicalAddress[i] = j;
                                break;
                                }
                            }
                            missingPageNum++;
                            if (map.ContainsKey(visitPages[i]))
                            {
                                map[visitPages[i]] = i;
                            }
                            else
                            {
                                map.Add(visitPages[i], i);
                            }
                            mutex.WaitOne();
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);


                            for (int j = 0; j < memBlockNum; j++)
                            {
                                LRUtableCurrentY += tableheight;
                                g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                                if (memBlock[j] == visitPages[i])
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Redbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                                else
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                            }
                            LRUtableCurrentY += tableheight;
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 12, LRUtableCurrentY + 2);


                            LRUtableCurrentY += tableheight;
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                        LRUtableCurrentY += tableheight;
                        g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
                        LRUtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 3 + MissingpagesTime;
                    }
                    }
                    else
                    {
                        if (map.ContainsKey(visitPages[i]))
                            map[visitPages[i]] = i;
                    for (int j = 0; j < memBlockNum; j++)
                    {
                        if (visitPages[i] == memBlock[j])
                        {
                            LRUphysicalAddress[i] = j;
                            break;
                        }
                    }
                    mutex.WaitOne();
                        g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                        g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                        for (int j = 0; j < memBlockNum + 2; j++)
                        {
                            LRUtableCurrentY += tableheight;
                            g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);

                        }
                        g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 15, LRUtableCurrentY + 2);
                    LRUtableCurrentY += tableheight;
                    g.DrawRectangle(p, LRUtableCurrentX, LRUtableCurrentY, tablewidth, tableheight);
                    g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
                    mutex.ReleaseMutex();
                        LRUtableCurrentX += tablewidth;
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime;
                        else
                        sleepTime = memoryAccessTime * 2;
                    }
                
                totalSleep += sleepTime;
                this.BeginInvoke(new Action(() =>
                {
                 
                    LRULacklabel.Text = "LRU当前缺页率：" + missingPageNum + "/" + (i + 1) + "=" + ((missingPageNum * 1.0 / (i + 1)) * 100).ToString("F2") + "%";
                }));

                this.BeginInvoke(new Action(() =>
                {
                   
                    lableLRUsleep.Text = "LRU当前累计用时：" + totalSleep + "nm";
                }));
                g.Save();
                pictureBoxLRU.Image = bp;
                Thread.Sleep(sleepTime);     
            }
            mutex.WaitOne();
            LRUtableCurrentY = LRUtableY;
            g.DrawString("缺页率为" + ((double)missingPageNum / visitNum * 100) + "%", new Font("黑体", 12), Blackbrush, LRUtableCurrentX + 2,LRUtableCurrentY + 2);
            LRUtableCurrentY += tableheight;
            g.DrawString("总时间为：" + totalSleep + "ns", new Font("黑体", 12), Blackbrush, LRUtableCurrentX + 2, LRUtableCurrentY + 2);
            mutex.ReleaseMutex();
            LRUtime = totalSleep;
            LRUlackrate = (double)missingPageNum / visitNum * 100;
            g.Save();
            pictureBoxLRU.Image = bp;
            string currPath = Application.StartupPath;
            string subPath = currPath + "/testData/";
            if (false == Directory.Exists(subPath))
            {
                Directory.CreateDirectory(subPath);
            }
            string temp = subPath + "LRU/";
            if (false == Directory.Exists(temp))
            {
                Directory.CreateDirectory(temp);
            }
            string filename = temp + "LRUdata.txt";
            string nowtime = DateTime.Now.ToString();
            string temptime = nowtime.Replace(" ", "");
            temptime = temptime.Replace("/", "");
            temptime = temptime.Replace(":", "");
            if (!File.Exists(filename))
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:" + nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[LRUphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为:" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            else
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:" + nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[LRUphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为:" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            string path = temp + temptime + ".bmp";
            Thread.Sleep(2000);
            bp.Save(path, System.Drawing.Imaging.ImageFormat.Bmp);
        }
        public void OPT() {
            Bitmap bp = new Bitmap(1000, 300);
            Graphics g = Graphics.FromImage(bp);
            g.Clear(Color.White);
            OPTtableCurrentX = OPTtableX;
            mutex.WaitOne();
            OPTtableCurrentY =OPTtableY;
     
            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("访问页面", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            for (int i = 0; i < memBlockNum; i++)
            {
                OPTtableCurrentY += tableheight;
                g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth * 2, tableheight);
                g.DrawString("物理块"+(i+1), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            }
            OPTtableCurrentY += tableheight;
            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("是否缺页", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            OPTtableCurrentY += tableheight;
            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("缺页数", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            OPTtableCurrentY += tableheight;
            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth * 2, tableheight);
            g.DrawString("物理地址", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            mutex.ReleaseMutex();
            OPTtableCurrentX += tablewidth * 2;
            int totalSleep = 0;
            int sleepTime = 0;
            int num = 0;
            Dictionary<int, int> map = new Dictionary<int, int>();
            int[] memBlock = new int[memBlockNum];
            for (int i = 0; i < memBlockNum; i++)
                memBlock[i] = -1;
            int missingPageNum = 0;
            OPTphysicalAddress = new int[visitNum];
            for (int i = 0; i < visitNum; i++)
            {
                OPTtableCurrentY = OPTtableY;
                
                bool flag = false;
                    for (int j = 0; j < memBlockNum; j++)
                    {
                        if (visitPages[i] == memBlock[j])
                        {
                            flag = true;
                            break;
                        }
                    }
                    if (!flag)
                    {
                        if (missingPageNum < memBlockNum)
                        {
                            memBlock[num] = visitPages[i];
                            OPTphysicalAddress[i] = num;
                            num++;
                            missingPageNum++;
                            mutex.WaitOne();

                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);

                            for (int j = 0; j < memBlockNum; j++)
                            {
                                OPTtableCurrentY += tableheight;
                                if (j < missingPageNum)
                                {

                                    g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                                }
                                else
                                {
                                    g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                                }
                            }

                            OPTtableCurrentY += tableheight;
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 12, OPTtableCurrentY + 2);


                            OPTtableCurrentY += tableheight;
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX +15, OPTtableCurrentY + 2);
                        OPTtableCurrentY += tableheight;
                        g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
                        OPTtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();

                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 3 + MissingpagesTime;

                    }
                        else
                        {
                            map.Clear();
                            int mm = -1;
                            for (int z = 0; z < memBlockNum; z++)
                                for (int j = i; j < visitNum; j++)
                                {
                                    if (memBlock[z] == visitPages[j])
                                    {
                                        map.Add(visitPages[j], j);
                                        break;
                                    }
                                }
                            int page = -1;
                            foreach (var item in map)
                            {
                                for (int j = 0; j < memBlockNum; j++)
                                    if (mm < item.Value && item.Key == memBlock[j])
                                    {
                                        mm = item.Value;
                                        page = item.Key;
                                    }
                            }
                            for (int j = 0; j < memBlockNum; j++)
                            {
                                if (!map.ContainsKey(memBlock[j]))
                                {
                                    page = memBlock[j];
                                    break;
                                }
                            }

                            for (int j = 0; j < memBlockNum; j++)
                            {
                                if (page == memBlock[j])
                                {
                                    memBlock[j] = visitPages[i];
                                    OPTphysicalAddress[i] = j;
                                    break;
                                }
                            }
                            missingPageNum++;

                            mutex.WaitOne();
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX +15, OPTtableCurrentY + 2);


                            for (int j = 0; j < memBlockNum; j++)
                            {
                                OPTtableCurrentY += tableheight;
                                g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                                if (memBlock[j] == visitPages[i])
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Redbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                                else
                                    g.DrawString(memBlock[j].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                            }
                            OPTtableCurrentY += tableheight;
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString("√", new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 12, OPTtableCurrentY + 2);


                            OPTtableCurrentY += tableheight;
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                            g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                        OPTtableCurrentY += tableheight;
                        g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                        g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
                        OPTtableCurrentX += tablewidth;
                            mutex.ReleaseMutex();
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime + MissingpagesTime + FasttableAccessTime
                                + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 3 + MissingpagesTime;
                    }
                    }
                    else
                    {
                    for (int j = 0; j < memBlockNum; j++)
                    {
                        if (visitPages[i] == memBlock[j])
                        {
                            OPTphysicalAddress[i] = j;
                            break;
                        }
                    }
                    mutex.WaitOne();
                        g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                        g.DrawString(visitPages[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                        for (int j = 0; j < memBlockNum + 2; j++)
                        {
                            OPTtableCurrentY += tableheight;
                            g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);

                        }
                        g.DrawString(missingPageNum.ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 15, OPTtableCurrentY + 2);
                    OPTtableCurrentY += tableheight;
                    g.DrawRectangle(p, OPTtableCurrentX, OPTtableCurrentY, tablewidth, tableheight);
                    g.DrawString(pageTable[LRUphysicalAddress[i]] + withinPageaddress[i].ToString(), new Font("黑体", 9), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
                    mutex.ReleaseMutex();
                        OPTtableCurrentX += tablewidth;
                        if (fast)
                            sleepTime = FasttableAccessTime + memoryAccessTime;
                        else
                            sleepTime = memoryAccessTime * 2;
                    }
                    
                
                totalSleep += sleepTime;
                this.BeginInvoke(new Action(() =>
                {
                  
                    OPTLacklabel.Text = "OPT当前缺页率：" + missingPageNum + "/" + (i + 1) + "=" + ((missingPageNum * 1.0 / (i + 1)) * 100).ToString("F2") + "%";
                }));

                this.BeginInvoke(new Action(() =>
                {
                   
                    lableOPTsleep.Text = "OPT当前累计用时：" + totalSleep + "nm";
                }));
                g.Save();
                pictureBoxOPT.Image = bp;
                Thread.Sleep(sleepTime);
            }
            mutex.WaitOne();
            OPTtableCurrentY = OPTtableY;
            g.DrawString("缺页率为" + ((double)missingPageNum / visitNum * 100) + "%", new Font("黑体", 12), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            OPTtableCurrentY += tableheight;
            g.DrawString("总时间为：" + totalSleep + "ns", new Font("黑体", 12), Blackbrush, OPTtableCurrentX + 2, OPTtableCurrentY + 2);
            mutex.ReleaseMutex();
            OPTtime = totalSleep;
            OPTlackrate = (double)missingPageNum / visitNum * 100;
            g.Save();
            pictureBoxOPT.Image = bp;
            string currPath = Application.StartupPath;
            string subPath = currPath + "/testData/";
            if (false == Directory.Exists(subPath))
            {
                Directory.CreateDirectory(subPath);
            }
            string temp = subPath + "OPT/";
            if (false == Directory.Exists(temp))
            {
                Directory.CreateDirectory(temp);
            }
            string filename = temp + "OPTdata.txt";
            string nowtime = DateTime.Now.ToString();
            string temptime = nowtime.Replace(" ", "");
            temptime = temptime.Replace("/", "");
            temptime = temptime.Replace(":", "");
            if (!File.Exists(filename))
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:"+ nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[OPTphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为：" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            else
            {
                FileStream fs = new FileStream(filename, FileMode.Append, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine("实验时间:" + nowtime);
                sw.WriteLine("逻辑地址 物理地址");
                for (int i = 0; i < visitNum; i++)
                    sw.WriteLine(logicalAddress[i] + " " + pageTable[OPTphysicalAddress[i]] + withinPageaddress[i]);
                sw.WriteLine("缺页率为:" + ((double)missingPageNum / visitNum * 100) + "%");
                sw.WriteLine("总时间为：" + totalSleep + "ns");
                sw.Close();
                fs.Close();
            }
            string path = temp + temptime + ".bmp";
            Thread.Sleep(2000);
            bp.Save(path, System.Drawing.Imaging.ImageFormat.Bmp);
        }
        private DataTable CreateDataTable1()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("algorithm");
            dt.Columns.Add("vo1");
            DataRow dr;
            dr = dt.NewRow();
            dr["algorithm"] = "FIFO";
            dr["vo1"] = FIFOlackrate;
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["algorithm"] = "LRU";
            dr["vo1"] = LRUlackrate;
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["algorithm"] = "OPT";
            dr["vo1"] = OPTlackrate;
            dt.Rows.Add(dr);
            return dt;
        }
        private DataTable CreateDataTable2()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("algorithm");
            dt.Columns.Add("vo1");
            DataRow dr;
            dr = dt.NewRow();
            dr["algorithm"] = "FIFO";
            dr["vo1"] =FIFOtime;
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["algorithm"] = "LRU";
            dr["vo1"] = LRUtime;
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["algorithm"] = "OPT";
            dr["vo1"] = OPTtime;
            dt.Rows.Add(dr);
            return dt;
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            memblockTextbox.LostFocus += new EventHandler(memblockTextbox_lostFocus);
            AddressTextBox.LostFocus += new EventHandler(AddressTextBox_lostFocus);
        }
        public void AddressTextBox_lostFocus(object sender, EventArgs e)
        {
            string[] temp = AddressTextBox.Text.Split(' ');
            int num = int.Parse(pageNumTextbox.Text);
            string up = addressUpperTextbox.Text.Substring(0, addressUpperTextbox.Text.Length - 1);
            string lo = addressLowwerTextbox.Text.Substring(0, addressLowwerTextbox.Text.Length - 1);
            long upperAddress = Convert.ToInt64(up, 16);
            long lowwerAddress = Convert.ToInt64(lo, 16);
            if(upperAddress<lowwerAddress)
            {
                MessageBox.Show("输入的范围不合适");
                addressLowwerTextbox.Text = "";
                return;
            }
            if(temp.Length!=num)
            {
                MessageBox.Show("输入地址序列数量不对");
                AddressTextBox.Text = "";
            }
            for (int i = 0; i < num;)
            {
                string ss = temp[i].Substring(0, temp[0].Length - 1);
                long tempnum = Convert.ToInt64(ss, 16);
                string te = temp[0].Substring(0,temp[0].Length-1);
                if (tempnum > upperAddress || tempnum < lowwerAddress)
                    continue;
                i++;
            }
           
        }
        public void memblockTextbox_lostFocus(object sender, EventArgs e)
        {
            int num;
            if (memblockTextbox.Text == null)
                num = 0;
            else
                num = int.Parse(memblockTextbox.Text);
            pageTable = new int[num];
            Random rd = new Random((int)DateTime.Now.Ticks);
            Dictionary<int, int> mp = new Dictionary<int, int>();
            int temp;
            for (int i = 0; i < num;)
            {
                temp = rd.Next(10);
                if (!mp.ContainsKey(temp))
                {
                    mp.Add(temp, 1);
                    pageTable[i] = temp;
                    i++;
                }
                else
                    continue;
            }
            Bitmap bp = new Bitmap(1000, 1000);
            Graphics g = Graphics.FromImage(bp);
            g.Clear(Color.White);
           
            Pen p = new Pen(Color.Black);

            Brush Blackbrush = new SolidBrush(Color.Black);
        
            int tableX = 0;
            int tableY = 0;
            int currentX;
            int currentY;
            int width = 55;
            int height = 20;
            Mutex mutex = new Mutex();
            currentY = tableY;
            mutex.WaitOne();
            currentX = tableX;
            g.DrawRectangle(p, currentX, currentY, width, height);
            g.DrawString("页号", new Font("黑体", 10), Blackbrush, currentX , currentY+2);
            currentX += width;
            g.DrawRectangle(p, currentX, currentY, width, height);
            g.DrawString("内存块号", new Font("黑体", 10), Blackbrush, currentX , currentY+2  );
            currentY += height;
            mutex.ReleaseMutex();
            for (int i = 0; i < pageTable.Length; i++)
            {
                mutex.WaitOne();
                currentX = tableX;
                g.DrawRectangle(p, currentX, currentY, width, height);
                g.DrawString(i.ToString(), new Font("黑体", 10), Blackbrush, currentX+20 , currentY+2 );
                currentX += width;
                g.DrawRectangle(p, currentX, currentY, width, height);
                g.DrawString(pageTable[i].ToString(), new Font("黑体", 10), Blackbrush, currentX+20, currentY+2);
                currentY += height;
                mutex.ReleaseMutex();
            }
            g.Save();
            pictureBoxPagetable.Image = bp;
        }
        private void btnFIFO_Click(object sender, EventArgs e)
        {
            btnPage_Click(null,null);
            if (useFast.Checked)
                fast = true;
            else if (noFast.Checked)
                fast = false;
            FIFOThread = new Thread(new ThreadStart(FIFO)) ;
            FIFOThread.IsBackground = true;
            FIFOThread.Start();
            btnFIFO.Enabled = false;
            btnStopFIFO.Enabled = true;
        }
        private void btnStopFIFO_Click(object sender, EventArgs e)
        {
            
            if (btnStopFIFO.Text == "挂起")
            {
                if (FIFOThread.IsAlive)
                {
                    FIFOThread.Suspend();
                    btnStopFIFO.Text = "激活";
                }
            }
            else if (btnStopFIFO.Text == "激活")
            {
                FIFOThread.Resume();
                btnStopFIFO.Text = "挂起";
            }
        }
        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }
        private void btnLRU_Click(object sender, EventArgs e)
        {
            btnPage_Click(null, null);
            if (useFast.Checked)
                fast = true;
            else if (noFast.Checked)
                fast = false;
            LRUThread = new Thread(new ThreadStart(LRU));
            LRUThread.IsBackground = true;
            LRUThread.Start();
            btnLRU.Enabled = false;
            btnStopLRU.Enabled = true;
        }
        private void btnOPT_Click(object sender, EventArgs e)
        {
            btnPage_Click(null, null);
            if (useFast.Checked)
                fast = true;
            else if (noFast.Checked)
                fast = false;
            OPTThread = new Thread(new ThreadStart(OPT));
            OPTThread.IsBackground = true;
            OPTThread.Start();
            btnOPT.Enabled = false;
            btnStopOPT.Enabled = true;
        }
        private void btnStopLRU_Click(object sender, EventArgs e)
        {
            if (btnStopLRU.Text == "挂起")
            {
                if (LRUThread.IsAlive)
                {
                    LRUThread.Suspend();
                    btnStopLRU.Text = "激活";
                }
            }
            else if (btnStopLRU.Text == "激活")
            {
                LRUThread.Resume();
                btnStopLRU.Text = "挂起";
            }
        }
        private void btnALL_Click(object sender, EventArgs e)
        {
            btnPage_Click(null, null);
            if (useFast.Checked)
                fast = true;
            else if (noFast.Checked)
                fast = false;
            FIFOThread = new Thread(new ThreadStart(FIFO));
            FIFOThread.IsBackground = true;
            FIFOThread.Start();
            
            LRUThread = new Thread(new ThreadStart(LRU));
            LRUThread.IsBackground = true;
            LRUThread.Start();
            
            OPTThread = new Thread(new ThreadStart(OPT));
            OPTThread.IsBackground = true;
            OPTThread.Start();
            btnALL.Enabled = false;
            btnStopALL.Enabled = true;
        }
        private void btnStopALL_Click(object sender, EventArgs e)
        {
            if (btnStopALL.Text == "挂起")
            {
               if(FIFOThread.IsAlive)
                FIFOThread.Suspend();
             if(LRUThread.IsAlive)
                LRUThread.Suspend();
            if(OPTThread.IsAlive)
                OPTThread.Suspend();
                btnStopALL.Text = "激活";
            }
            else if (btnStopALL.Text == "激活")
            {
                FIFOThread.Resume();
                LRUThread.Resume();
                OPTThread.Resume();
                btnStopALL.Text = "挂起";
            }
        }
        public static String getRandomValue(int numSize)
        {
            String str = "";
            Random rd = new Random((int)DateTime.Now.Ticks);
            for (int i = 0; i < numSize; i++)
            {
                Thread.Sleep(1);
                char temp = '0';
                int key = rd.Next(3)-1;
                switch (key)
                {
                    case 0:
                        temp =(char) (rd.Next(10)+'0');//产生随机数字
                        break;
                    case 1:
                        temp = (char)((rd.Next(6)) + 'A');//产生A-F
                        break;
                    default:
                        break;
                }
                str = str + temp;
            }
            return str;
        }
        private void btnRandom_Click(object sender, EventArgs e)
        {
            int num = int.Parse(pageNumTextbox.Text);
            int size = int.Parse(LAnumTextbox.Text)/4;
            string up = addressUpperTextbox.Text.Substring(0, addressUpperTextbox.Text.Length - 1);
            string lo = addressLowwerTextbox.Text.Substring(0, addressLowwerTextbox.Text.Length - 1);
            long upperAddress = Convert.ToInt64(up, 16);
            long lowwerAddress = Convert.ToInt64(lo, 16);
            string result = "";
            for(int i = 0; i < num; )
            {
                string temp = getRandomValue(size);
                long tempnum = Convert.ToInt64(temp, 16);
                if (tempnum> upperAddress || tempnum < lowwerAddress)
                    continue;
                result += temp + "H ";
                i++;
            }
            result=result.TrimEnd();
            AddressTextBox.Text = result;
        }
        private void btnPage_Click(object sender, EventArgs e)
        {
            FIFOLacklabel.Text = "FIFO当前缺页率";
            LRULacklabel.Text = "LRU当前缺页率";
            OPTLacklabel.Text = "OPT当前缺页率";
            lableFIFOsleep.Text = "FIFO当前累计用时";
            lableLRUsleep.Text = "LRU当前累计用时";
            lableOPTsleep.Text = "OPT当前累计用时";
            btnFIFO.Enabled = true;
            btnStopFIFO.Enabled = false;
            btnLRU.Enabled = true;
            btnStopLRU.Enabled = false;
            btnOPT.Enabled = true;
            btnStopOPT.Enabled = false;
            btnALL.Enabled = true;
            btnStopALL.Enabled = false;
            memBlockNum = int.Parse(memblockTextbox.Text);
            visitNum = int.Parse(pageNumTextbox.Text);
            visitPages = new int[visitNum];
            withinPageaddress = new string[visitNum];
            string result = "";
            logicalAddress = AddressTextBox.Text.Split(' ');
            int pageSizeNum = int.Parse(PagesizeNumTextbox.Text);
            int LAnum = int.Parse(LAnumTextbox.Text);
            if (logicalAddress[0].IndexOf('H') != -1)
            {
                
                for (int i = 0; i < logicalAddress.Length; i++)
                {
                    if (!logicalAddress[i].Equals(" "))
                    {
                        string temp = logicalAddress[i].Substring(0, logicalAddress[i].Length-1-pageSizeNum/4);
                        withinPageaddress[i] = logicalAddress[i].Substring(logicalAddress[i].Length-1 - pageSizeNum / 4);
                        visitPages[i] = int.Parse(temp,System.Globalization.NumberStyles.HexNumber);
                        result += visitPages[i].ToString() + " ";
                    }
                }
            }
            else
            {
                for(int i = 0; i < logicalAddress.Length; i++)
                {
                    visitPages[i] = (int)(int.Parse(logicalAddress[i]) / Math.Pow(2, pageSizeNum));
                   
                    result += visitPages[i].ToString() + " ";
                }
            }
            pagesTextbox.Text = result;
        }
        private void btnStopOPT_Click(object sender, EventArgs e)
        {
            if (btnStopOPT.Text == "挂起")
            {
                if (OPTThread.IsAlive)
                {
                    OPTThread.Suspend();
                    btnStopOPT.Text = "激活";
                }
            }
            else if (btnStopOPT.Text == "激活")
            {
                OPTThread.Resume();
                btnStopOPT.Text = "挂起";
            }
        }
        private void btncmd_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("pageReplacement.exe");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            
            DataTable dt = default(DataTable);
            dt = CreateDataTable1();
            chart1.DataSource = dt;
            chart1.Series[0].YValueMembers = "vo1";
            chart1.Series[0].XValueMember = "algorithm";
            chart1.DataBind();

            DataTable dt2 = default(DataTable);
            dt2 = CreateDataTable2();
            chart2.DataSource = dt2;
            chart2.Series[0].YValueMembers = "vo1";
            chart2.Series[0].XValueMember = "algorithm";
            chart2.DataBind();
        }
    }
}
