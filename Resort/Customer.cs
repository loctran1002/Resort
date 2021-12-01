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
    public partial class Customer : Form
    {
        public Customer()
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

        private void Find_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string command;
                if (textName.Text.Trim().Length == 0)
                    command = "select MaKhachHang as 'Customer ID', CCCD_CMND as N'CCCD/CMND', HoTen as 'Fullname', DienThoai as 'Phone Number', Username, Diem as 'Point', Loai as 'Type' from KhachHang";
                else
                    command = "select MaKhachHang as 'Customer ID', CCCD_CMND as N'CCCD/CMND', HoTen as 'Fullname', DienThoai as 'Phone Number', Username, Diem as 'Point', Loai as 'Type' from KhachHang where Hoten = N'" + textName.Text.Trim() + "'";
                SqlDataAdapter adt = new SqlDataAdapter(command, con);
                DataTable table = new DataTable();
                adt.Fill(table);
                tableCustomer.DataSource = table;
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
