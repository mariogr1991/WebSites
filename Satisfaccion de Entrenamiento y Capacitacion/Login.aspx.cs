using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.IO;


public partial class ESC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    /// Función para verificar y validar la autenticación de un usuario.
    /// </summary>
    /// <param name="numempleado"></param>
    /// <param name="PIN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int VerificaUsuario(string numempleado, string PIN)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<Usuario> LUL = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(numempleado) && s.EstatusU == true select s).ToList();            
            if (LUL.Count <= 0)
            {
                return 3; // Usuario no OK
            }            
            Usuario UL = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(numempleado) && s.EstatusU == true select s).SingleOrDefault();

            if((UL.PINU == null || UL.PINU == "") && UL.IDR > 2){
                return 4; // Requiere PIN y aún no se ha ingresado. 
            }

            if (UL.IDR > 2)
            {
                if (PIN == "" || PIN == null || PIN == " ")
                {
                    return -1; // Es requerido un PIN
                }
                else
                {
                    Usuario ULV = (from t in SEC.Usuario where t.NumeroEmpleadoU == Convert.ToInt32(numempleado) && t.PINU == PIN && t.EstatusU == true select t).SingleOrDefault();
                    if (ULV.EstatusU == true)
                    {
                        return 1; //Usuario con PIN OK
                    }
                    else
                    {
                        return 3; // Usuario no OK
                    }
                }
            }
            else
            {
                return 2; //Usuario OK sin PIN
            }
        }
        catch(Exception e)
        {
            Log(e.Message + "Verificausuario");
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar el PIN del usuario ingresado.
    /// </summary>
    /// <param name="NumEmpleado"></param>
    /// <param name="PIN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActualizarPIN(string NumEmpleado, string PIN)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from u in SEC.Usuario where u.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select u).SingleOrDefault();
            U.PINU = PIN;
            SEC.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " ActualizarPIN");
            return 0;
        }
    }
}