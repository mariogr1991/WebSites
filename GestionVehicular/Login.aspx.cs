using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //GenerarNombresUsuario();
    }

    [System.Web.Services.WebMethod]
    public static bool ValidaUsuario(string usuario, string pass)
    {
        bool respuesta;
        ModelDataDataContext GV = new ModelDataDataContext();        
        List<Usuario> Usuarios = (from s in GV.Usuario where s.NombreUsuarioU == usuario && s.ContrasenaU == pass && s.EstatusU == 1 select s).ToList();

        if (Usuarios.Count == 1)
        {
            respuesta = true;
        }
        else
        {
            respuesta = false;
        }

        return respuesta;

        
    }

    protected void GenerarNombresUsuario()
    {
        ModelDataDataContext GV = new ModelDataDataContext();

        List<Usuario> Usuarios = (from s in GV.Usuario select s).ToList();        
        string[] nombre;
        char[] primernombre;
        char[] apellidomaterno;
        char[] vocales = new char[] { 'A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u' };
        char[] numeros = new char[] {'4','3','1','0','5','4','3','1','0','5'};
        string NU;
        string pass = "";
        foreach(Usuario U in Usuarios)
        {
            Usuario US = (from t in GV.Usuario where t.IDU == U.IDU select t).SingleOrDefault();
            pass = "#";
            nombre = U.NombreU.Split(' ');
            primernombre = nombre[2].ToCharArray();
            string primernombrepass = nombre[2].ToString();
            for (int i = 0; i < 10; i++)
            {
               primernombrepass = primernombrepass.Replace(vocales[i],numeros[i]);
            }

            pass += primernombrepass.ToLower();
            char[] apellidopaterno = nombre[0].ToCharArray();
            pass += apellidopaterno[0].ToString().ToUpper() + apellidopaterno[1].ToString().ToLower() + "#";

            apellidomaterno = nombre[1].ToCharArray();
            NU = primernombre[0].ToString().ToLower() + nombre[0].ToString().ToLower() + apellidomaterno[0].ToString().ToLower();
            US.NombreUsuarioU = NU;
            US.ContrasenaU = pass;
            GV.SubmitChanges();
        }

    }
}