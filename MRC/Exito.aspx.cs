using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Exito : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null || string.IsNullOrEmpty(Session["User"].ToString()))
        {
            Response.Redirect("http://localhost:4104/Home.aspx");
        }
        else
        {
            Session.Timeout = 2;
        }
    }
}