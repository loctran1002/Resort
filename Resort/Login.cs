using System;
using System.Drawing;
using System.Windows.Forms;

namespace Resort
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(100, 0, 0, 0);
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (textUsername.Text.Trim() == "sManager" && textPassword.Text.Trim() == "Resort123")
                {
                    Home_page home = new Home_page();
                    this.Hide();
                    home.Show();
                }
                else
                {
                    MessageBox.Show("Check username and password again!!");
                }
            }
            catch (Exception)
            {
                MessageBox.Show("System Error");
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(100, 0, 0, 0);
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
