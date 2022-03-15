namespace 扫雷尝试2
{
    partial class Form1
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.imageList1 = new System.Windows.Forms.ImageList(this.components);
            this.primary = new System.Windows.Forms.Button();
            this.middle = new System.Windows.Forms.Button();
            this.zidingyi = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // imageList1
            // 
            this.imageList1.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit;
            this.imageList1.ImageSize = new System.Drawing.Size(16, 16);
            this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // primary
            // 
            this.primary.Location = new System.Drawing.Point(90, 34);
            this.primary.Name = "primary";
            this.primary.Size = new System.Drawing.Size(75, 23);
            this.primary.TabIndex = 0;
            this.primary.Text = "button1";
            this.primary.UseVisualStyleBackColor = true;
            // 
            // middle
            // 
            this.middle.Location = new System.Drawing.Point(90, 79);
            this.middle.Name = "middle";
            this.middle.Size = new System.Drawing.Size(75, 23);
            this.middle.TabIndex = 1;
            this.middle.Text = "button2";
            this.middle.UseVisualStyleBackColor = true;
            // 
            // zidingyi
            // 
            this.zidingyi.Location = new System.Drawing.Point(90, 121);
            this.zidingyi.Name = "zidingyi";
            this.zidingyi.Size = new System.Drawing.Size(75, 23);
            this.zidingyi.TabIndex = 2;
            this.zidingyi.Text = "button3";
            this.zidingyi.UseVisualStyleBackColor = true;
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(90, 166);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(75, 23);
            this.button4.TabIndex = 3;
            this.button4.Text = "button4";
            this.button4.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(282, 253);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.zidingyi);
            this.Controls.Add(this.middle);
            this.Controls.Add(this.primary);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.ImageList imageList1;
        private System.Windows.Forms.Button primary;
        private System.Windows.Forms.Button middle;
        private System.Windows.Forms.Button zidingyi;
        private System.Windows.Forms.Button button4;
    }
}

