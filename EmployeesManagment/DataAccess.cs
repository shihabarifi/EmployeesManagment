using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace EmployeesManagment
{
    public class DataAccess
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["EmployeeConn"].ConnectionString;

        public DataTable Execute(string cmdText, CommandType type, params SqlParameter[] parameters)
        {
            using (var conn = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(cmdText, conn) { CommandType = type })
            {
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public int ExecuteNonQuery(string cmdText, CommandType type, params SqlParameter[] parameters)
        {
            using (var conn = new SqlConnection(_conn))
            using (var cmd = new SqlCommand(cmdText, conn) { CommandType = type })
            {
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }
}