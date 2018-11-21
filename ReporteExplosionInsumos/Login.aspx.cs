using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public void ActivarSession(string Usuario, string PIN)
    {
        Session["User"] = Usuario;
        Session["PIN"] = PIN;
        Session["Validate"] = true;
    }

    public static void Log(string mensaje)
    {
        string path = ConfigurationManager.AppSettings["RutaLog"] + "Log" + DateTime.Now.ToString("yyyyMMdd") + ".txt";
        if (!File.Exists(path))
        {
            using (StreamWriter sw = File.CreateText(path))
            {
                sw.WriteLine(DateTime.Now.ToString() + " " + mensaje);
            }
        }
        else
        {
            using (StreamWriter sw = File.AppendText(path))
            {
                AgregarLinea(mensaje, sw);
            }
        }

    }

    public static void AgregarLinea(string mensaje, TextWriter w)
    {
        w.WriteLine(DateTime.Now.ToString() + " " + mensaje);
    }

    /// <summary>
    /// Función para verificar el usuario y contraseña.
    /// </summary>
    /// <param name="Usuario"></param>
    /// <param name="PIN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int VerificaUsuario(string Usuario, string PIN)
    {
        try
        {
            REIDataContext REI = new REIDataContext();

            Usuario U = (from s in REI.Usuario where s.NombreU == Usuario && s.PassU == PIN select s).SingleOrDefault();

            if(U.IDU > 0)
            {
                Login n = new Login();
                n.ActivarSession(Usuario, PIN);
                return 1;
            }
            else
            {
                return 0;
            }
        }
        catch(Exception e)
        {
            Log(e.Message + " VerificaUsuario");
            return -1;
        }
    }

}