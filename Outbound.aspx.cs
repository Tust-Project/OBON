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
using System.Drawing;
using System.Net.Mail;
using System.Net;

public partial class Outbound : System.Web.UI.Page
{
    private DateTime dtmNow = DateTime.Now;
    private static string stragent_id;
    private static string strOutGName;
    private static string strOutLineName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["agentid"] != null)
            {
                stragent_id = Request.QueryString["agentid"].ToString();

            }          
        }
    }

}