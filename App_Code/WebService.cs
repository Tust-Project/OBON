using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Text;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Net.Sockets;
using System.Net;
using System.Collections.Specialized;
using System.Net.Cache;

/// <summary>
/// WebService 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下一行。
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //如果使用設計的元件，請取消註解下行程式碼 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    public string[] GetCompletionList(string QRID)
    {
        string strHistoryAll = "";
        ArrayList array = new ArrayList();//儲存撈出來的字串集合

        SqlConnection t1Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TENSDBConnectionString"].ConnectionString);

        t1Conn.Open();
        {
            

            //先查詢序號
            string strSQLSel = "SELECT " +
                    "dbo.QRMain.QRID, dbo.QREmpIDLog.OutDate, dbo.QREmpIDLog.OutEmpID, " +
                    "dbo.QREmpIDLog.OutEmpChiName, dbo.QREmpIDLog.OutMemo " +
                    "FROM dbo.QRMain RIGHT OUTER JOIN " +
                    "dbo.QREmpIDLog ON dbo.QRMain.SEQ = dbo.QREmpIDLog.SEQ " +
                    "GROUP BY dbo.QRMain.QRID, dbo.QREmpIDLog.OutDate, " +
                    "dbo.QREmpIDLog.OutEmpID, dbo.QREmpIDLog.OutEmpChiName, dbo.QREmpIDLog.OutMemo " +
                    "HAVING (dbo.QRMain.QRID = '" + QRID.ToString().Trim() + "')";
            SqlDataAdapter da = new SqlDataAdapter(strSQLSel, t1Conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "SelTableA");

            foreach (DataRow row in ds.Tables["SelTableA"].Rows)
            {
                //strHistoryAll += row["OutDate"].ToString() + "　" + row["OutEmpID"].ToString().Trim() + "　" + row["OutEmpChiName"].ToString().Trim() + row["OutMemo"].ToString().Trim() + "\r\n";
                array.Add(row["OutEmpID"].ToString());
            }
            
        }

        return (string[])array.ToArray(typeof(string));


    } 
    
}

