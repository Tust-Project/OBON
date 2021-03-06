using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// DBUtil 的摘要描述
/// </summary>
public class DBUtil
{
    //連線字串
    string connStr = WebConfigurationManager.ConnectionStrings["TICRDBConnectionString"].ConnectionString;

    /// <summary>
    /// 傳入SQL語句，回傳DataTable物件
    /// </summary>
    /// <param name="sql"></param>
    /// <returns></returns>
    public DataTable queryDataTable(string sql)
    {

        DataSet ds = new DataSet();
        using (SqlConnection conn = new SqlConnection(this.connStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.Fill(ds);
        }
        return ds.Tables.Count > 0 ? ds.Tables[0] : new DataTable();
    }
}
