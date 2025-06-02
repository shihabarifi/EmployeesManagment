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
    public partial class AddEmployee : System.Web.UI.Page
    {
        private readonly DataAccess db = new DataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = db.Execute("SELECT * FROM Branches", CommandType.Text);
                ddlBranch.DataSource = dt;
                ddlBranch.DataTextField = "BranchName";
                ddlBranch.DataValueField = "BranchID";
                ddlBranch.DataBind();

                ddlStatus.DataSource = db.Execute("SELECT * FROM Statuses", CommandType.Text);
                ddlStatus.DataTextField = "StatusName";
                ddlStatus.DataValueField = "StatusID";
                ddlStatus.DataBind();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int empID;
            using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["EmployeeConn"].ConnectionString))
            using (var cmd = new SqlCommand("INSERT INTO Employees(EmployeeNumber,FullName,BranchID,StatusID,HireDate,Position) OUTPUT INSERTED.EmployeeID VALUES(@num,@name,@bid,@sid,@date,@pos)", conn))
            {
                cmd.Parameters.AddWithValue("@num", txtEmpNum.Text);
                cmd.Parameters.AddWithValue("@name", txtFullName.Text);
                cmd.Parameters.AddWithValue("@bid", ddlBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@sid", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@date", string.IsNullOrWhiteSpace(txtHireDate.Text) ? (object)DBNull.Value : DateTime.Parse(txtHireDate.Text));
                cmd.Parameters.AddWithValue("@pos", txtPosition.Text);
                conn.Open();
                empID = (int)cmd.ExecuteScalar();
            }
            // حفظ أرقام الهواتف
            foreach (string phone in Request.Form.GetValues("phones"))
            {
                if (string.IsNullOrWhiteSpace(phone)) continue;
                string type = Request.Form.GetValues("types")[Array.IndexOf(Request.Form.GetValues("phones"), phone)];
                db.ExecuteNonQuery("INSERT INTO EmployeePhones(EmployeeID,PhoneNumber,PhoneType) VALUES(@id,@ph,@tp)", CommandType.Text,
                    new SqlParameter("@id", empID),
                    new SqlParameter("@ph", phone),
                    new SqlParameter("@tp", type));
            }
            lblMsg.Text = "تم الحفظ بنجاح";
        }
    }
}