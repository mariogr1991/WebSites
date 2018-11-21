using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Equipo.InnerText = Environment.MachineName.ToString();
        Usuario.InnerText = Environment.UserName.ToString();
        //Version.Value = Environment.Version.ToString();
        //SOVersion.Value = Environment.OSVersion.ToString();
    }
}