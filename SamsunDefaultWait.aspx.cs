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


public partial class SamsunDefaultWait : System.Web.UI.Page
{
    //CTI ACD8000參數
    //private static string stragent_id;
    private static string strAgent_Name;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        

        //Session.Abandon();       //清除全部Session
        Session["dtmNow"] = null;
        Session["ssOutCustSN"] = null;
        Session["ACD_DN"] = null;
        Session["Call_ID"] = null;
        Session["Call_KEY"] = null;
        Session["Current_ANI"] = null;
                
        
        //判斷是否有帳號
        if (Request.QueryString["agent_id"] != null)
        {
            Session["agent_id"] = Request.QueryString["agent_id"].ToString();
            lblAgentID.Text = Session["agent_id"].ToString();
           
        }
        else
        {
            Response.Write("No Agent ID found,Plese Call IT #<br />沒有TICR登入帳號，請打報修專線");
        }
        if (Request.QueryString["agentid"] != null)
        {
            Session["agent_id"] = Request.QueryString["agentid"].ToString();
            lblAgentID.Text = Session["agent_id"].ToString();
            
        }
        //QueryAgent();

        
    

    }
    protected void btnWaiteCall_Click(object sender, EventArgs e)
    {
        //話後處理
        //Response.Redirect("OtherLoginPage.aspx?title=Inother&agentid=" + Session["agent_id"].ToString() + "");
        //string redirectURL = "OtherLoginPage.aspx?title=Inother&agentid=" + Session["agent_id"].ToString() + "";
        
    }
    protected void btnCallOut_Click(object sender, EventArgs e)
    {
        //外撥電話
        //Response.Redirect("OtherLoginPage.aspx?title=Outbound&agentid=" + Session["agent_id"].ToString() + "");
        //string strURL = "OtherLoginPage.aspx?title=Outbound&agentid=" + Session["agent_id"].ToString() + "";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "alert('Call Out !!!');window.location=’OtherLoginPage.aspx?title=Outbound&agentid==" + Session["agent_id"].ToString() + "’;", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ALERT", "alert('Call Out !!!');window.open('OtherLoginPage.aspx?title=Outbound&agentid==" + Session["agent_id"].ToString() + "');", true);
        
    }



    private void QueryAgent()
    {
        //取出Agent資料
        try
        {
            SqlConnection SqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["TICRDBConnectionString"].ConnectionString);

            SqlConn.Open();
            {

                string strSQLSel = "SELECT " +
                    "* from AGENT_FATACCOUNT " +
                    "WHERE " +
                    "cAG_FK='" + Session["agent_id"].ToString().Trim() + "' ";
                SqlDataAdapter da = new SqlDataAdapter(strSQLSel, SqlConn);
                DataSet ds = new DataSet();
                da.Fill(ds, "SelTableA");

                foreach (DataRow row in ds.Tables["SelTableA"].Rows)
                {

                    Session["cAG_NAME"] = row["cAG_NAME"].ToString().Trim();
                    strAgent_Name = row["cAG_NAME"].ToString().Trim();
                }

                SqlConn.Close();
                SqlConn.Dispose();
            }

        }
        catch (Exception E)
        {
            Response.Write("No Agent ID found,Plese Call IT #：" + E.Message.ToString());
        }

    }


}
