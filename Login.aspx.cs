using System;
using System.Collections;
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
using System.Data.SqlClient;
using System.IO;
using System.Xml;
using System.Data.OleDb;


public partial class Login : System.Web.UI.Page
{

    private string sEname = "";
    private string sPwd = "";
    private DateTime dtmNow = DateTime.Now;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(Request.QueryString["sEname"].ToString());
        if (Session["ThisPage"] == null)
        {
            Session["ThisPage"] = "Default.aspx";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string strErrorMsg = "";

        if (txbLoginID.Text.ToString() == "")
        {
            strErrorMsg += "帳號";
        }
        if (txbPW.Text.ToString() == "")
        {
            strErrorMsg += "密碼";
        }
        if (strErrorMsg != "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('請輸入" + strErrorMsg + "')</script>");
        }
        else
        {
            if (txbLoginID.Text.ToString() != "")
            {
                sEname = txbLoginID.Text.ToString();
            }
            sPwd = txbPW.Text.ToString();

            //查詢帳號密碼
            check();

        }
    }


    public void check()
    {
        try
        {
            SqlConnection SqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["OBONConnectionString"].ConnectionString);

            SqlConn.Open();

            if (txbLoginID.Text.ToString().Trim() != "" && txbPW.Text.ToString().Trim() != "")
            {
                string strSQLSel = "SELECT " +
                "* FROM dbo.AGENT_FATACCOUNT  " +
                "WHERE (cAG_FK = '" + txbLoginID.Text.ToString().Trim() + "') " +
                "and (PASSWORD = '" + txbPW.Text.ToString().Trim() + "') ";
                SqlCommand cmd = new SqlCommand(strSQLSel, SqlConn);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //空值顯示錯誤

                        string sPWD = dr["PASSWORD"].ToString().Trim();

                        Session["sscAG_NAME"] = dr["cAG_NAME"].ToString().Trim();
                        Session["sscAG_FK"] = dr["cAG_FK"].ToString().Trim();

                        //抓取是什麼專案
                        //目前是虎航專用
                        //Session["IDS_FK"] = "tiger080";


                        //========每頁放==================================
                        //Session["ThisPage"] = Request.RawUrl.ToString();
                        //================================================
                        Response.Redirect(Session["ThisPage"].ToString());

                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "alert('帳號密碼錯誤');", true);
                }

            }
            SqlConn.Close();
            SqlConn.Dispose();
           
        }
        catch (Exception E)
        {
            Response.Write(E.Message);
        }
    }
}
