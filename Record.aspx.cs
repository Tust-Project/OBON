using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Record : System.Web.UI.Page
{
    //CTI ACD8000參數
    private static string stragent_id;
    private static string strCall_ID;
    private static string strCurrent_ANI;
    private static string strCall_KEY;
    private static string strACD_DN;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["agent_id"] != null)
        {
            stragent_id = Request.QueryString["agent_id"].ToString().Trim();
            strCall_ID = Request.QueryString["Call_ID"].ToString().Trim();
            strCurrent_ANI = Request.QueryString["Current_ANI"].ToString().Trim();
            //strCall_KEY = Request.QueryString["Call_KEY"].ToString();
            strACD_DN = "3901310";

            lblEmpID.Text = stragent_id;
            lblAni.Text = strCurrent_ANI;
            //lblCall_Key.Text = strCall_KEY;
            lblACDDN.Text = strACD_DN;
            lblCall_ID.Text = strCall_ID;


        }

        
        
    }
}