using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml; // أضف حزمة EPPlus من NuGet

namespace EmployeesManagment
{
    public partial class ImportExcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!fuExcel.HasFile)
            {
                lblStatus.Text = "يرجى اختيار ملف"; return;
            }

            using (var pkg = new ExcelPackage(fuExcel.FileContent))
            {
                var ws = pkg.Workbook.Worksheets[0];
                var dt = new DataTable();
                dt.Columns.AddRange(new[]
                {
                    new DataColumn("EmployeeNumber"),
                    new DataColumn("FullName"),
                    new DataColumn("BranchID", typeof(int)),
                    new DataColumn("StatusID", typeof(int))
                });
                int rows = ws.Dimension.End.Row;
                for (int i = 2; i <= rows; i++) // نفترض الصف الأول رؤوس أعمدة
                {
                    dt.Rows.Add(ws.Cells[i, 1].Text, ws.Cells[i, 2].Text, int.Parse(ws.Cells[i, 3].Text), int.Parse(ws.Cells[i, 4].Text));
                }
                // SqlBulkCopy
                using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["EmployeeConn"].ConnectionString))
                using (var bulk = new SqlBulkCopy(conn))
                {
                    bulk.DestinationTableName = "Employees";
                    conn.Open();
                    bulk.WriteToServer(dt);
                }
                lblStatus.Text = "تم الاستيراد";
            }
        }
    }
}