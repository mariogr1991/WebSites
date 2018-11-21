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

    public void ActivarSession(string Usuario)
    {
        Session["User"] = Usuario;        
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
    /// Función para autenticar a el usuario que ingresa al sistema.
    /// </summary>
    /// <param name="Usuario"></param>
    /// <param name="Password"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int VerificaUsuario(string NUsuario, string Password)
    {
        try
        {
            MRCDataContext MRC = new MRCDataContext();

            List<Usuario> U = (from s in MRC.Usuario where s.NombreUsuarioU == NUsuario && s.ContrasenaU == Password select s).ToList();

            if(U.Count == 1)
            {
                Login L = new Login();
                L.ActivarSession(NUsuario);
                int NE = 0;
                foreach(Usuario D in U)
                {
                    NE = D.NumeroEmpleadoU;
                }
                return NE; //Ok
            }
            else
            {
                return 0; // La contraseña y/o usuario son incorrectos.
            }
        }
        catch(Exception e)
        {
            Log(e.Message + " VerificaUsuario");
            return -1; //Error
        }
    }
}