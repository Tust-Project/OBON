using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["ThisPage"] = Request.RawUrl.ToString();
        if (Session["sscAG_NAME"] != null && Session["sscAG_FK"] != null)
        {
            ViewState["sscAG_NAME"] = Session["sscAG_NAME"].ToString();
            ViewState["sscAG_FK"] = Session["sscAG_FK"].ToString();
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
}