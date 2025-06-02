using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;


namespace EmployeesManagment
{
    public partial class SearchEmployee : System.Web.UI.Page
    {
        private static readonly DataAccess db = new DataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            var term = txtSearch.Text.Trim();
            var dt = db.Execute(@"SELECT e.FullName, p.PhoneNumber
                                  FROM Employees e
                                  LEFT JOIN EmployeePhones p ON e.EmployeeID=p.EmployeeID
                                  WHERE e.FullName LIKE @t OR p.PhoneNumber LIKE @t", CommandType.Text,
                new SqlParameter("@t", "%" + term + "%"));
            gvResults.DataSource = dt;
            gvResults.DataBind();
            gvResults.Visible = dt.Rows.Count > 0;
        }

        /* WebMethod لخاصية Autocomplete */
        [WebMethod]
        public static string GetSuggestions(string term)
        {
            var dt = db.Execute("SELECT TOP 10 FullName FROM Employees WHERE FullName LIKE @t", CommandType.Text,
                new SqlParameter("@t", "%" + term + "%"));
            var list = new List<string>();
            foreach (DataRow r in dt.Rows) list.Add(r[0].ToString());
            return new JavaScriptSerializer().Serialize(list);
        }
    }
}