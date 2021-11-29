using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Resort
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        SqlConnection link = new SqlConnection(@"Data Source=DESKTOP-D59BBBC;Initial Catalog=RESORT;Persist Security Info=True;User ID=sManager;Password=Resort123");

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
                link.Open();
                //string query = "SELECT * FROM KhachHang WHERE Username = '" + textUsername.Text.Trim() + "' AND Password = '" + textPassword.Text.Trim() + "'";
                //SqlDataAdapter cmd = new SqlDataAdapter(query, link);
                //DataTable table = new DataTable();
                //cmd.Fill(table);
                //if (table.Rows.Count == 1)
                if (textUsername.Text.Trim() == "sManager" && textPassword.Text.Trim() == "Resort123")
                {
                    //Move to main
                    this.Hide();
                    //main.Show();
                    MessageBox.Show("Login successfully");
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
            finally
            {
                link.Close();
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
