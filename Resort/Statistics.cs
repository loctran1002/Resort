using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Resort
{
    public partial class Statistics : Form
    {
        public Statistics()
        {
            InitializeComponent();
        }

        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-D59BBBC;Initial Catalog=RESORT;Persist Security Info=True;User ID=sManager;Password=Resort123");

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            Home_page home = new Home_page();
            this.Hide();
            home.Show();
        }

        private void show_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string command = "select * from dbo.ThongKeLuotKhach('" + branch.Text.Trim().ToUpper() + "', convert(int, N'" + year.Text.Trim() + "'))";
                SqlDataAdapter adt = new SqlDataAdapter(command, con);
                DataTable table = new DataTable();
                adt.Fill(table);
                tableStatistics.DataSource = table;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Message", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }
    }
}
