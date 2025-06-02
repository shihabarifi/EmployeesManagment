using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeesManagment
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly DataAccess db = new DataAccess();
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var dt = db.Execute("SELECT UserID,PasswordHash,PasswordSalt,Role FROM Users WHERE Username=@u", CommandType.Text,
                new SqlParameter("@u", txtUser.Text.Trim()));
            if (dt.Rows.Count == 1)
            {
                var row = dt.Rows[0];
                byte[] hash = (byte[])row["PasswordHash"];
                byte[] salt = (byte[])row["PasswordSalt"];
                if (PasswordHelper.Verify(txtPass.Text, hash, salt))
                {
                    Session["uid"] = row["UserID"];
                    Session["role"] = row["Role"].ToString();
                    Response.Redirect("SearchEmployee.aspx");
                }
            }
            lblMsg.Text = "بيانات الدخول غير صحيحة";
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}