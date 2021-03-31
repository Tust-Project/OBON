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
using System.Text;

public partial class ReportOutbound : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["ThisPage"] = Request.RawUrl.ToString();

        if (Session["sscAG_FK"] !=null && Session["sscAG_FK"].ToString() != "")
        {
            ViewState["sscAG_NAME"] = Session["sscAG_NAME"].ToString();
            ViewState["sscAG_FK"] = Session["sscAG_FK"].ToString();
            lblCAG_FK.Text = Session["sscAG_FK"].ToString();

        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
    protected void btnSendOK_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
        btnOutExcel.Visible = true;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        // 避免錯誤 -- 型別 'GridView' 的控制項 'GridView1' 必須置於有 runat=server 的表單標記之中。
    }

    protected void btnOutExcel_Click(object sender, EventArgs e)
    {
        GridView1.AllowPaging = false;
        GridView1.DataBind();

        DateTime dtmSDate = DateTime.Now;
        DateTime dtmEDate = DateTime.Now;
        dtmSDate = (DateTime)Convert.ToDateTime(txbStartDate.Text.ToString().Trim());
        dtmEDate = (DateTime)Convert.ToDateTime(txbEndDate.Text.ToString().Trim());
        string strEDate = txbEndDate.Text.ToString().Trim();
        GridView1.DataSource = (DataTable)ViewState["ExportTable"];
        string excelFileName = "外撥紀錄匯出(" + dtmSDate.ToString("yyyyMMdd") + "_" + dtmEDate.ToString("yyyyMMdd") + ").xls";


        if (Request.Browser.Browser == "IE")
        {
            excelFileName = Server.UrlPathEncode(excelFileName);
        }
        string strContentDisposition = String.Format("{0}; filename=\"{1}\"", "attachment", excelFileName);

        string ExcelHeader = "<html><head><meta http-equiv=Content-Type content=text/html; charset='UTF-8'><style>td{mso-number-format:\\@}br{mso-data-placement:same-cell;}</style></head><body>";
        string ExcelFooter = "</body></html>";
        Response.Clear();
        Response.Buffer = true;
        //string excelFileName = "匯出簡訊紀錄.xls";
        Response.AddHeader("content-disposition", "attachment;filename=" + excelFileName);
        Response.ContentType = "application/vnd.ms-excel";

        Response.Charset = "";
        EnableViewState = false;
        System.IO.StringWriter tw = new System.IO.StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        GridView1.RenderControl(hw);
        Response.Write(ExcelHeader + tw.ToString() + ExcelFooter);
        Response.End();
    }

    private void SendMail()
    {
        string strMailTo = "";
        switch (lblCAG_FK.Text.ToString().Trim())
        {
            case "U00012":
                strMailTo = "johnsonshen@tust.com.tw";
                break;
            case "peichunchen":
                strMailTo = "peichunchen@tust.com.tw";
                break;
            case "fannyli":
                strMailTo = "fannyli@tust.com.tw";
                break;
        }

        if (strMailTo != "")
        {
            //2019-06-03改
            //string mailServerName = "tustedm.com.tw";  //發送郵件的SMTP服务器
            //string mailFrom = "sysadmin@tustedm.com.tw";   //發件人郵箱
            string mailTo = strMailTo;   //收件人郵箱
            string subject = "寄送機密檔案";//郵件主旨            
            string body = "含有客戶資料，請勿非法使用，以免觸犯個資法。";  //郵件正文
            string strToCC = "Johnsonshen@tust.com.tw";


            //2019-06-03改
            GmailTo(mailTo, subject, body, strToCC);

            //using (MailMessage message = new MailMessage(mailFrom, mailTo, subject, body))
            //{

            //    message.IsBodyHtml = true;


            //    //SmtpClient是發送郵件的主體，告之那個SMTP
            //    SmtpClient mailClient = new SmtpClient(mailServerName);

            //    //郵件信箱帳號密碼
            //    mailClient.Credentials = new NetworkCredential("sysadmin", "sysadmintust");

            //    mailClient.EnableSsl = false; //設定不要SSL


            //    string file = @"d:\TEMP\TempExcel.xls";

            //    Attachment data = new Attachment(file);

            //    //附件
            //    message.Attachments.Add(data);


            //    //發送
            //    mailClient.Send(message);

            //}
        }
        else
        {
            lblError.Text = "使用了未經申請的帳號登入，無法寄送名單檔";
        }
    }
    //使用Gmail
    private void GmailTo(string mailTo, string subject, string body, string strToCC)
    {
        try
        {
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            //msg.To.Add("mcsd.shen@gmail.com");
            msg.To.Add(mailTo);

            //msg.To.Add("b@b.com");可以發送給多人
            msg.CC.Add(strToCC);
            //msg.CC.Add("c@c.com");可以抄送副本給多人

            msg.Bcc.Add("mcsd.shen@gmail.com");


            msg.From = new MailAddress("tustedm@gmail.com", "台灣優勢客服", System.Text.Encoding.UTF8);
            /* 上面3個參數分別是發件人地址（可以隨便寫），發件人姓名，編碼*/
            //msg.Subject = "測試標題";//郵件標題
            msg.Subject = subject;
            msg.SubjectEncoding = System.Text.Encoding.UTF8;//郵件標題編碼
            //msg.Body = "測試一下"; //郵件內容
            msg.Body = body;
            msg.BodyEncoding = System.Text.Encoding.UTF8;//郵件內容編碼 
            msg.Attachments.Add(new Attachment(@"d:\TEMP\TempExcel.xls"));  //附件
            msg.IsBodyHtml = true;//是否是HTML郵件 
            //msg.Priority = MailPriority.High;//郵件優先級 

            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("tustedm@gmail.com", "apple1093"); //這裡要填正確的帳號跟密碼
            client.Host = "smtp.gmail.com"; //設定smtp Server
            client.Port = 25; //設定Port
            client.EnableSsl = true; //gmail預設開啟驗證
            client.Send(msg); //寄出信件
            //client.Dispose();

            msg.Dispose();
            //Response.Write("郵件寄送成功！");
            WriteTXT("郵件寄送成功！");
        }
        catch (Exception ex)
        {
            WriteTXT(ex.ToString());
        }
    }

    private void WriteTXT(string strERROR)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OBONConnectionString"].ConnectionString);
        if (strERROR != "")
        {
            //先寫入order主檔
            String SQLString = "INSERT INTO [MailError] " +
                           "([ErrorLog], " +
                           "[ErrorDate]) " +
                           "VALUES " +
                           "(" +
                           "@ErrorLog," +
                           "@ErrorDate" +
                            ")";
            SqlCommand cmdMain = new SqlCommand(SQLString, conn);

            cmdMain.Parameters.AddWithValue("@ErrorLog", strERROR);
            cmdMain.Parameters.AddWithValue("@ErrorDate", DateTime.Now);
            try
            {
                conn.Open();
                cmdMain.ExecuteNonQuery();

            }
            catch (Exception E)
            {
                lblError.Text = "寫ErrorLog有問題：" + E.Message;
            }
            finally
            {
                conn.Close();
                conn.Dispose();
            }
        }
    }
}