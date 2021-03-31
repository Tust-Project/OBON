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
using System.Text.RegularExpressions;

public partial class OutboundRec : System.Web.UI.Page
{
    private DateTime dtmNow = DateTime.Now;
    private static string stragent_id;
    private static string strOutGName;
    private static string strOutLineName;

    //CTI UniPBX參數
    private static string strCall_ID;
    private static string strCurrent_ANI;
    private static string strCall_KEY;
    private static string strACD_DN;
    private static string strOutPhone;

    //進線和結束時間
    private static DateTime dtSDateTime = new DateTime();
    private static DateTime dtEDateTime = new DateTime();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //進線時間
            dtSDateTime = DateTime.Now;
            Session["SDateTime"] = dtSDateTime.ToString("yyyy/MM/dd HH:mm:ss");
            lblNowTime.Text = dtSDateTime.ToString("yyyy/MM/dd HH:mm:ss");

            if (Request.QueryString["agentid"] != null)
            {
                stragent_id = Request.QueryString["agentid"].ToString();

            }
            else
            {
                if (Request.QueryString["agent_id"] != null)
                {
                    //原2020-12-15之前
                    stragent_id = Request.QueryString["agent_id"].ToString().Trim();
                    strCall_ID = Request.QueryString["Call_ID"].ToString().Trim();
                    strCurrent_ANI = Request.QueryString["Current_ANI"].ToString().Trim();
                    strCurrent_ANI = "";
                    //strCall_KEY = Request.QueryString["Call_KEY"].ToString();
                    strACD_DN = Request.QueryString["ACD_DN"].ToString().Trim(); ;
                    strOutPhone = Request.QueryString["OutPhone"].ToString().Trim(); ;
                    

                    lblEmpID.Text = stragent_id;
                    lblAni.Text = strCurrent_ANI;
                    txbPhone.Text = strOutPhone.Substring(1);
                    //lblCall_Key.Text = strCall_KEY;
                    lblACDDN.Text = strACD_DN;
                    lblCall_ID.Text = strCall_ID;
                    lblOutPhone.Text = strOutPhone.Substring(1);

                    ////==================================================================
                    //stragent_id = Request.QueryString["agent_id"].ToString().Trim();
                    //strCall_ID = Request.QueryString["Call_ID"].ToString().Trim();
                    ////strCurrent_ANI = Request.QueryString["Current_ANI"].ToString().Trim();
                    ////strCall_KEY = Request.QueryString["Call_KEY"].ToString();
                    //strACD_DN = Request.QueryString["ACD_DN"].ToString().Trim();

                    //lblCallback.Text = Request.QueryString["Callback"].ToString().Trim();

                    //lblEmpID.Text = stragent_id;
                    //lblAni.Text = strCurrent_ANI;
                    ////lblCall_Key.Text = strCall_KEY;
                    //lblACDDN.Text = strACD_DN;
                    //lblCall_ID.Text = strCall_ID;


                    ////切Callback字串
                    //String value = Request.QueryString["Callback"].ToString().Trim();
                    //string[] sArray = Regex.Split(value, "@@", RegexOptions.IgnoreCase);
                    //strOutLineName = sArray[0].ToString();
                    //txbPhone.Text = sArray[1].ToString();
                    //lblAni.Text = sArray[1].ToString();
                    ////==================================================================

                }
            }

        }
    }


    private string GetRandom()
    {       
        //產生20碼產生案件編號
        string[] source = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" };
        string code = "";
        Random rd = new Random(Guid.NewGuid().GetHashCode());
        for (int i = 0; i < 3; i++)  //這決定位數
        {
            code += source[rd.Next(0, source.Length)];
        }
        code = dtmNow.ToString("yyMMddHHmmOB") + code;
        return code;

    }
    private void AddToDB()
    {
        string strGetRandom = "";
        strGetRandom = GetRandom().ToString().ToUpper();
        lblOBID.Text = strGetRandom;

        dtEDateTime = DateTime.Now;

        DateTime dtSDateTime = Convert.ToDateTime(lblNowTime.Text.ToString());

        // Difference in days, hours, and minutes.
        TimeSpan ts = dtEDateTime - dtSDateTime;
        long ldifferenceInSecond = (long)ts.TotalSeconds;
        int differenceInSecond = 0;
        differenceInSecond = Convert.ToInt16(ldifferenceInSecond);



        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OBONConnectionString"].ConnectionString);

        String SQLString = "INSERT INTO [CusDataHistory] " +
                            "("+
                            "[CasID]         " +
                            ",[SDateTime]    " +
                            ",[EDateTime]    " +
                            ",[WorkTime]     " +
                            ",[Memo]         " +
                            ",[BackState]    " +
                            ",[TranPhone]    " +
                            ",[Mobile1]      " +
                            ",[Mobile2]      " +
                            ",[Phone1]       " +
                            ",[Phone2]       " +
                            ",[CarNO]        " +
                            ",[SoundName]    " +
                            ",[AgentID]      " +
                            ",[Call_ID]      " +
                            ",[Current_ANI]  " +
                            ",[Call_KEY]     " +
                            ",[ACD_DN]      " +
                            ") " +
                            " VALUES " +
                            "("+
                            "@CasID         " +
                            ",@SDateTime    " +
                            ",@EDateTime    " +
                            ",@WorkTime     " +
                            ",@Memo         " +
                            ",@BackState    " +
                            ",@TranPhone    " +
                            ",@Mobile1      " +
                            ",@Mobile2      " +
                            ",@Phone1       " +
                            ",@Phone2       " +
                            ",@CarNO        " +
                            ",@SoundName    " +
                            ",@AgentID      " +
                            ",@Call_ID      " +
                            ",@Current_ANI  " +
                            ",@Call_KEY     " +
                            ",@ACD_DN       " +
                            ")";
        SqlCommand cmdMain = new SqlCommand(SQLString, conn);



        cmdMain.Parameters.AddWithValue("@CasID", TxbUmID.Text.ToString());
        cmdMain.Parameters.AddWithValue("@SDateTime", dtSDateTime.ToString("yyyy/MM/dd HH:mm:ss"));
        cmdMain.Parameters.AddWithValue("@EDateTime", dtEDateTime.ToString("yyyy/MM/dd HH:mm:ss"));
        cmdMain.Parameters.AddWithValue("@WorkTime", differenceInSecond);
        cmdMain.Parameters.AddWithValue("@Memo", txbMemo.Text.ToString());
        cmdMain.Parameters.AddWithValue("@BackState", ddlBackState.SelectedItem.ToString());
        cmdMain.Parameters.AddWithValue("@TranPhone", lblOutPhone.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Mobile1", txbMobile1.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Mobile2", txbMobile2.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Phone1", txbPhone1.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Phone2", txbPhone2.Text.ToString());
        cmdMain.Parameters.AddWithValue("@CarNO", TxbCarNO.Text.ToString());
        cmdMain.Parameters.AddWithValue("@SoundName", txbSoundName.Text.ToString());
        cmdMain.Parameters.AddWithValue("@AgentID", lblEmpID.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Call_ID", lblCall_ID.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Current_ANI", lblAni.Text.ToString());
        cmdMain.Parameters.AddWithValue("@Call_KEY ", "");
        cmdMain.Parameters.AddWithValue("@ACD_DN", lblACDDN.Text.ToString());

        string strTEST = "agent_id=" + stragent_id + " Call_ID=" + lblCall_ID.Text + " Current_ANI=" + lblAni.Text + " ACD_DN=" + lblACDDN.Text + "";
        lblErrorShow.Text = strTEST;

        try
        {
            conn.Open();
            
            cmdMain.ExecuteNonQuery();
        }
        catch (Exception E)
        {
            lblErrorShow.Text += "寫主檔有問題：" + E.Message;
        }
        finally
        {
            conn.Close();
        }
    }
    
    protected void btnSendOK_Click(object sender, EventArgs e)
    {
        if(ddlBackState.SelectedItem.ToString() !="請選擇")
        {
            AddToDB();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseURLwin", "alert('紀錄完成');CloseURL();", true);      
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseURLwin", "alert('請選擇接觸紀錄');", true);
        }
    }
}