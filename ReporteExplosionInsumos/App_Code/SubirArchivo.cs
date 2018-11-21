using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

/// <summary>
/// Descripción breve de SubirArchivo
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
// [System.Web.Script.Services.ScriptService]
public class SubirArchivo : System.Web.Services.WebService {

    public SubirArchivo () {

        //Elimine la marca de comentario de la línea siguiente si utiliza los componentes diseñados 
        //InitializeComponent(); 
    }

    /// <summary>
    /// Función para subir un archivo al servidor.
    /// </summary>
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void SubirDocumento()
    {
        try
        {
            HttpContext Contexto = HttpContext.Current;
            HttpFileCollection ColeccionArchivos = Context.Request.Files;
            string date = DateTime.Now.ToShortDateString();
            date = date.Replace("/", "");
            String NombreArchivo = "Reporte Final " + date;
            NombreArchivo += ColeccionArchivos[0].FileName;
            String DatosArchivo = System.IO.Path.GetFileName(ColeccionArchivos[0].FileName);
            String CarpetaParaGuardar = Server.MapPath("Documentos") + "\\" + NombreArchivo;
            ColeccionArchivos[0].SaveAs(CarpetaParaGuardar);
            Contexto.Response.ContentType = "application/json";
            Contexto.Response.Write("{\"success\":true,\"msg\":\"" + NombreArchivo + "\"}");
            Contexto.Response.End();
        }
        catch (Exception e)
        {
            Log(e.Message + " SubirDocumento");
        }
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
    
}
