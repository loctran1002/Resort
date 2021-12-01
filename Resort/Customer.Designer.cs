
namespace Resort
{
    partial class Customer
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Customer));
            this.label1 = new System.Windows.Forms.Label();
            this.textName = new System.Windows.Forms.TextBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.tableCustomer = new System.Windows.Forms.DataGridView();
            this.Find = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableCustomer)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("MV Boli", 27.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.DarkOrange;
            this.label1.Location = new System.Drawing.Point(182, 42);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(280, 49);
            this.label1.TabIndex = 0;
            this.label1.Text = "Find customer";
            // 
            // textName
            // 
            this.textName.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.textName.BackColor = System.Drawing.SystemColors.ScrollBar;
            this.textName.Font = new System.Drawing.Font("Microsoft YaHei UI", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textName.Location = new System.Drawing.Point(180, 105);
            this.textName.Name = "textName";
            this.textName.Size = new System.Drawing.Size(599, 32);
            this.textName.TabIndex = 1;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.Transparent;
            this.pictureBox1.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(12, 12);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(49, 41);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 22;
            this.pictureBox1.TabStop = false;
            this.pictureBox1.Click += new System.EventHandler(this.pictureBox1_Click);
            // 
            // tableCustomer
            // 
            this.tableCustomer.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.tableCustomer.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.tableCustomer.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCellsExceptHeaders;
            this.tableCustomer.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.tableCustomer.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.tableCustomer.Location = new System.Drawing.Point(12, 154);
            this.tableCustomer.Name = "tableCustomer";
            this.tableCustomer.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.tableCustomer.RowTemplate.Height = 40;
            this.tableCustomer.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.tableCustomer.Size = new System.Drawing.Size(929, 290);
            this.tableCustomer.TabIndex = 50;
            // 
            // Find
            // 
            this.Find.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.Find.BackColor = System.Drawing.Color.Transparent;
            this.Find.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("Find.BackgroundImage")));
            this.Find.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom;
            this.Find.Location = new System.Drawing.Point(748, 105);
            this.Find.Name = "Find";
            this.Find.Size = new System.Drawing.Size(31, 32);
            this.Find.TabIndex = 51;
            this.Find.UseVisualStyleBackColor = false;
            this.Find.Click += new System.EventHandler(this.Find_Click);
            // 
            // Customer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.ClientSize = new System.Drawing.Size(952, 456);
            this.Controls.Add(this.Find);
            this.Controls.Add(this.tableCustomer);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.textName);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Customer";
            this.Text = "Find Customer";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tableCustomer)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textName;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.DataGridView tableCustomer;
        private System.Windows.Forms.Button Find;
    }
}