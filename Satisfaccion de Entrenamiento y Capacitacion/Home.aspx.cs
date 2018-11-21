using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using LinqToExcel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using System.Data.Linq;
using HumanSite;
using MRCTools;
using Newtonsoft.Json;
using System.Web.Script.Serialization;


public partial class Home : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        string us = Request.QueryString["NE"].ToString();
        if (string.IsNullOrEmpty(us) || us == "" || us == null)
        {
            Response.Redirect("http://mrc.sytes.net/SatisfaccionEntrenamiento/IntrusoDetectado.aspx");
        }
        
        RolUsuario.Text = ObtenerRolUsuario(us);
        NombreUsuario.Text = ObtenerNombreUsuario(us);

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
    /// Función para obtener el nombre del usuario logueado
    /// </summary>
    /// <param name="numempleado"></param>
    /// <returns></returns>
    public static string ObtenerNombreUsuario(string numempleado)
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            var jsonInfoEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(numempleado), out e);
            CEmpleado InfoEmpelado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEmpleado);
            string nombre = InfoEmpelado.Emp_patern + " " + InfoEmpelado.Emp_matern + " " + InfoEmpelado.Emp_nombres;
            return nombre;
        }
        
        catch(Exception e)
        {
            Log(e.Message + " Obtener Nombre de usuario");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener el nombre del rol del usuario logueado
    /// </summary>
    /// <param name="numempleado"></param>
    /// <returns></returns>
    public static string ObtenerRolUsuario(string numempleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario UL = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(numempleado) select s).SingleOrDefault();
            Rol RUL = (from r in SEC.Rol where r.IDR == UL.IDR select r).SingleOrDefault();
            return RUL.NombreR;
        }
        catch(Exception e)
        {
            Log(e.Message + " Obtener Rol Usuario");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener el id del rol del usuario logueado
    /// </summary>
    /// <param name="numempleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ObtenerIdRolUsuario(string numempleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario UL = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(numempleado) select s).SingleOrDefault();
            Rol RUL = (from r in SEC.Rol where r.IDR == UL.IDR select r).SingleOrDefault();
            return RUL.IDR;
        }
        catch (Exception e)
        {
            Log(e.Message + " Obtener Id Rol Usuario");
            return 0;
        }
    }


    /// <summary>
    /// Función para obtener la información del usuario logueado
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerInformacioUsuario(string numempleado)
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            var json = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(numempleado), out e);
            return json;
                        
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerInformacioUsuario");            
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener infromación de un empleado por medio dela interfaz de Human Site con el número de empleado.
    /// </summary>
    /// <param name="NoEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerInfoEmpleado(string NoEmpleado)
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new WSInfoUnidadNegocioSoapPortClient();
            string e;
            var jsonInfoEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(NoEmpleado), out e);
            CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEmpleado);
            JavaScriptSerializer JSON = new JavaScriptSerializer();
            string outputJSON = JsonConvert.SerializeObject(InfoEmpleado);
            return outputJSON;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerInfoEmpleado");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener los entrenadores disponibles
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerEntrenadores(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();            
            string e;
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            Usuario Usuario = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select s).SingleOrDefault();
            var jsonEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(NumEmpleado), out e);
            CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonEmpleado);
            var jsonEntrenadores = HS.GETEMPLEADOS("MRC", InfoEmpleado.PuestoId, "", Convert.ToInt32(Usuario.IDUNHumanSite), "", out e);
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            List<CEmpleado> EntrenadoresHumanSite = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEntrenadores);
            List<int> Entrenadores = (from s in SEC.Usuario where s.IDR == 2 select s.NumeroEmpleadoU).ToList();
            List<CEmpleado> EntrenadorSistema = (from s in EntrenadoresHumanSite where Entrenadores.Contains(s.Emp_nie) select s).ToList();
            if (EntrenadorSistema.Count > 0)
            {
                foreach (CEmpleado D in EntrenadorSistema)
                {
                    respuesta += "<option value=" + D.Emp_nie + ">" + D.Emp_patern + " " + D.Emp_matern + " " + D.Emp_nombres + "</option>";
                }
            }
            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerEntrenadores");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener los entreadores para el capacitador
    ///// </summary>
    ///// <param name="NumEmpleado"></param>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerEntrenadoresCapacitador(string UnidadSeleccionada)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";

            if (Convert.ToInt32(UnidadSeleccionada) > 0)
            {
                List<int> EntrenadoresInt = (from e in SEC.Usuario where e.IDUNHumanSite == Convert.ToInt32(UnidadSeleccionada) && e.EstatusU == true && e.IDR == 2  select e.NumeroEmpleadoU).ToList();
                string er;
                HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
                var jsonEmpleados = HS.GETEMPLEADOS("MRC", "", "", Convert.ToInt32(UnidadSeleccionada), "", out er);
                List<CEmpleado> EntrenadoresHS = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleados);
                List<CEmpleado> Entrenadores = (from s in EntrenadoresHS where EntrenadoresInt.Contains(s.Emp_nie) select s).ToList();
                if (Entrenadores.Count > 0)
                {
                    foreach (CEmpleado P in Entrenadores)
                    {
                        respuesta += "<option value=" + P.Emp_nie + ">" + P.Emp_patern  + " " + P.Emp_matern + " " + P.Emp_nombres + "</option>";
                    }
                }

            }
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerEntrenadoresCapacitador");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener los capacitadores disponibles
    ///// </summary>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerCapacitadores(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            Usuario UL = (from ul in SEC.Usuario where ul.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) && ul.EstatusU == true select ul).SingleOrDefault();
            List<int> CapacitadoresUnidades = (from s in SEC.UsuarioUnidad where s.IDUN == UL.IDUNHumanSite select Convert.ToInt32(s.NumeroEmpleadoUU)).ToList();
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            if (CapacitadoresUnidades.Count > 0)
            {
                foreach (int D in CapacitadoresUnidades)
                {
                    var jsonEmpleado = HS.GETINFOEMPLEADO("MRC", D, out e);
                    CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonEmpleado);
                    respuesta += "<option value=" + InfoEmpleado.Emp_nie + ">" + InfoEmpleado.Emp_patern + " " + InfoEmpleado.Emp_matern + " " + InfoEmpleado.Emp_nombres + "</option>";
                }
            }
            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerCapacitadores");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener los capacitandos disponibles.
    ///// </summary>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerCapacitandos(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            string e;
            Usuario UL = (from ul in SEC.Usuario where ul.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) && ul.EstatusU == true select ul).SingleOrDefault();
            List<int> CapacitandosUsuarios = (from s in SEC.Usuario where s.IDR == 1 && s.IDUNHumanSite == UL.IDUNHumanSite select s.NumeroEmpleadoU).ToList();
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            var jsonInfoEmpleado = HS.GETINFOEMPLEADO("MRC",Convert.ToInt32(NumEmpleado),out e);
            CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEmpleado);
            var jsnonEmpleados = HS.GETEMPLEADOS("MRC", InfoEmpleado.PuestoId, "", Convert.ToInt32(UL.IDUNHumanSite), "", out e);
            List<CEmpleado> CapacitandosHS = JsonConvert.DeserializeObject<List<CEmpleado>>(jsnonEmpleados);
            List<CEmpleado> Capacitandos = (from s in CapacitandosHS where CapacitandosUsuarios.Contains(s.Emp_nie) select s).ToList();

            if (Capacitandos.Count > 0)
            {
                foreach (CEmpleado D in Capacitandos)
                {
                    respuesta += "<option value=" + D.Emp_nie + ">" + D.Emp_patern + " " + D.Emp_matern + " " + D.Emp_nombres + "</option>";
                }
            }

            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerCapacitandos");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener las unidades asignadas al capacitador
    ///// </summary>
    ///// <param name="NumEmpleado"></param>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerUnidadesAsignadas(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA UNIDAD POR FAVOR</option>";
            Usuario UL = (from ul in SEC.Usuario where ul.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select ul).SingleOrDefault();
            List<UsuarioUnidad> UnidadesAsignadas = (from ua in SEC.UsuarioUnidad where ua.IDU == UL.IDU select ua).ToList();
            if (UnidadesAsignadas.Count > 0)
            {
                int[] UA = new int[UnidadesAsignadas.Count];
                int aux = 0;
                foreach (UsuarioUnidad D in UnidadesAsignadas)
                {
                    UA[aux] = Convert.ToInt32(D.IDUN);
                    aux++;
                }

                List<Unidad> Unidades = (from u in SEC.Unidad where UA.Contains(u.IDUN) select u).ToList();
                if (Unidades.Count > 0)
                {
                    foreach (Unidad F in Unidades)
                    {
                        respuesta += "<option value=" + F.IDHumanSiteUN + ">" + F.NombreUN + "</option>";
                    }
                }
            }
            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerUnidadesAsignadas");
            return "<option value=" + 0 + ">SELECCIONE UNA UNIDAD POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener los capacitandos disponibles.
    ///// </summary>
    ///// <param name="NumEmpleado"></param>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerCapacitandosCapacitador(string UnidadSeleccionada)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            if (Convert.ToInt32(UnidadSeleccionada) > 0)
            {
                List<int> CapacitandosInt = (from c in SEC.Usuario where c.IDUNHumanSite == Convert.ToInt32(UnidadSeleccionada) && c.EstatusU == true && c.IDR == 1  select c.NumeroEmpleadoU).ToList();
                string e;
                HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
                var jsonEmpleados = HS.GETEMPLEADOS("MRC","","",Convert.ToInt32(UnidadSeleccionada),"",out e);
                List<CEmpleado> CapacitandosHS = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleados);
                List<CEmpleado> Capacitandos = (from s in CapacitandosHS where CapacitandosInt.Contains(s.Emp_nie) select s).ToList();
                if (Capacitandos.Count > 0)
                {
                    foreach (CEmpleado F in Capacitandos)
                    {
                        respuesta += "<option value=" + F.Emp_nie + ">" + F.Emp_patern + " " + F.Emp_matern + " " + F.Emp_nombres + "</option>";
                    }
                }
            }
            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerCapacitandosCapacitador");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    ///// <summary>
    ///// Función para obtener los capacitadores de acuerdo a la Unidad.
    ///// </summary>
    ///// <param name="NumEmpleado"></param>
    ///// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerCapacitadoresJefeDirecto(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            Usuario UL = (from u in SEC.Usuario where u.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) && u.EstatusU == true select u).SingleOrDefault();
            List<UsuarioUnidad> UnidadesAsignadas = (from ua in SEC.UsuarioUnidad where ua.IDUN == UL.IDUNHumanSite select ua).ToList();

            if (UnidadesAsignadas.Count > 0)
            {
                int[] IDUS = new int[UnidadesAsignadas.Count];
                int aux = 0;

                foreach (UsuarioUnidad D in UnidadesAsignadas)
                {
                    IDUS[aux] = Convert.ToInt32(D.IDU);
                    aux++;
                }

                List<Usuario> Capacitadores = (from s in SEC.Usuario where IDUS.Contains(s.IDU) && s.EstatusU == true select s).ToList();

                if (Capacitadores.Count > 0)
                {
                    HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
                    string e;
                    foreach (Usuario F in Capacitadores)
                    {
                        var jsonInfoEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(F.NumeroEmpleadoU), out e);
                        CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEmpleado);
                        respuesta += "<option value=" + InfoEmpleado.Emp_nie + ">" + InfoEmpleado.Emp_patern + " " + InfoEmpleado.Emp_matern + " " + InfoEmpleado.Emp_nombres + "</option>";
                    }
                }

            }

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerCapacitadoresJefeDirecto");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para obtener el puesto de un empleado.
    /// </summary>
    /// <param name="numempleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerPuesto(string NoEmpleado)
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new WSInfoUnidadNegocioSoapPortClient();
            string e;
            var jsonEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(NoEmpleado), out e);
            CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonEmpleado);
            return InfoEmpleado.PuestoDsc;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerPuesto 908");
            return "Error 908";
        }
    }

    /// <summary>
    /// Función para obtener la fecha de ingreso
    /// </summary>
    /// <param name="idusuario"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static DateTime ObtenerFechaIngreso(string NoEmpleado)
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            var jsonInfoEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(NoEmpleado), out e);
            CEmpleado InfoEmpleado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEmpleado);
            return Convert.ToDateTime(InfoEmpleado.EmpFechaIngreso);
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerFechaIngreso");
            return DateTime.Now;
        }
    }

    [System.Web.Services.WebMethod]
    public static string ObtenerUnidadesNegocio()
    {
        try
        {
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            SECDataContext SEC = new SECDataContext();
            List<Unidad> Unidades = (from s in SEC.Unidad orderby s.NombreUN ascending select s).ToList();

            if(Unidades.Count > 0)
            {
                foreach (Unidad D in Unidades)
                {
                    respuesta += "<option value=" + D.IDHumanSiteUN + ">" + D.NombreUN + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerUnidadesNegocio");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para obtener los puestos disponibles para asignar a un nuevo usuario.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerPuestos()
    {
        try
        {
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e, respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            var jsonEmpleados = HS.GETEMPLEADOS("MRC","","",0,"",out e);
            List<CEmpleado> Empleados = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleados);

            List<CEmpleado> Puestos = (from s in Empleados
                                       select new CEmpleado
                                       {
                                           Emp_matern = s.Emp_matern,
                                           Emp_nie = s.Emp_nie,
                                           Emp_nombres = s.Emp_nombres,
                                           Emp_patern = s.Emp_patern,
                                           EmpCURP = s.EmpCURP,
                                           EmpFechaAntiguedad = s.EmpFechaAntiguedad,
                                           EmpFechaIngreso = s.EmpFechaIngreso,
                                           EmpFechaNacimiento = s.EmpFechaNacimiento,
                                           EmpNumeroIMSS = s.EmpNumeroIMSS,
                                           EmpRFC = s.EmpRFC,
                                           PlazaCatalagoDsc = s.PlazaCatalagoDsc,
                                           PuestoDsc = s.PuestoDsc,
                                           PuestoId = s.PuestoId,
                                           TelefonoNo = s.TelefonoNo
                                       }).GroupBy(n => n.PuestoId).Select(y => y.First()).OrderBy(t => t.PuestoDsc).ToList();
            

            if (Puestos.Count > 0)
            {
                foreach (CEmpleado D in Puestos)
                {
                    respuesta += "<option value=" + D.PuestoId + ">" + D.PuestoDsc + "</option>";
                }
            }

            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerPuestos");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para devolver los puestos disponibles para asignar a un usuario.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerRoles()
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";

            List<Rol> Roles = (from s in SEC.Rol select s).ToList();

            if (Roles.Count > 0)
            {
                foreach (Rol D in Roles)
                {
                    respuesta += "<option value=" + D.IDR + ">" + D.NombreR + "</option>";
                }
            }

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerRoles");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }


    /// <summary>
    /// Función para obtener los diferentes tipos de encuesta. 
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerTipoEncuesta()
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<Encuesta> Tipos = (from s in SEC.Encuesta select s).ToList();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";

            if(Tipos.Count > 0)
            {
                foreach(Encuesta D in Tipos)
                {
                    respuesta += "<option value=" + D.IDE + ">" + D.TipoE + "</option>";
                }
            }

            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerTipoEncuesta");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }


    
    /// <summary>
    /// Funciób para obtener la información de el usuario logueado.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerInfoUsuario(string NoEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            var json = HS.GETINFOEMPLEADO("MRC",Convert.ToInt32(NoEmpleado),out e);           
            return json;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerInfoUsuario");            
            return "Error";
        }
    }


    /// <summary>
    /// Función para insertar une nueva encuesta.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int InsertarEncuesta(string numempleado, string IDEvaluando, string R1, string R2, string R3, string R4, string R5, string tipo)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();                        
            Respuesta Respuesta = new Respuesta
            {
                R1RE = Convert.ToInt16(R1),
                R2RE = Convert.ToInt16(R2),
                R3RE = Convert.ToInt16(R3),
                R4RE = Convert.ToInt16(R4),
                R5RE = Convert.ToInt16(R5)
            };
            SEC.Respuesta.InsertOnSubmit(Respuesta);
            SEC.SubmitChanges();
            int IDRE = Respuesta.IDRE;

            Usuario_Encuesta EncuestaCapacitando = new Usuario_Encuesta
            {
                IDU = Convert.ToInt32(numempleado),
                IDE = Convert.ToInt32(tipo),
                IDRE = IDRE,
                FechaAplicacionU_E = DateTime.Now,
                EvaluandoU_E = Convert.ToInt32(IDEvaluando)
            };
            SEC.Usuario_Encuesta.InsertOnSubmit(EncuestaCapacitando);
            SEC.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " InsertarEncuestaCapacitandoEntrenador");
            return 0;
        }
    }

    /// <summary>
    /// Función para agregar un nuevo usuario al sistema.
    /// </summary>
    /// <param name="NombreEmpleado"></param>
    /// <param name="PuestoEmpleado"></param>
    /// <param name="RolEmpleado"></param>
    /// <param name="UnidadNegocioEmpleado"></param>
    /// <param name="NumeroEmpleado"></param>
    /// <param name="FechaIngresoEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AgregarUsuario(string RolEmpleado, string NumeroEmpleado, string DiasCapacitacion)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            int VNE = ValidaNumeroEmpleado(Convert.ToInt32(NumeroEmpleado));           
            if (VNE <= 0)
            {
                return 2; // Ya existe numero de empleado
            }
            else
            {
                WSInfoUnidadNegocioSoapPortClient HS = new WSInfoUnidadNegocioSoapPortClient();
                string e;
                var jsonUnidades = HS.GETUNIDADNEGOCIO("MRC", 0, out e);
                List<UnidadNegocio> Unidades = JsonConvert.DeserializeObject<List<UnidadNegocio>>(jsonUnidades);
                int IDComi = 0;
                foreach(UnidadNegocio N in Unidades)
                {
                    var jsonEmpleados = HS.GETEMPLEADOS("MRC", "", "", N.ComId , "", out e);
                    List<CEmpleado> Empleados = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleados);
                    if(Empleados.Count > 0)
                    {
                        foreach(CEmpleado CE in Empleados)
                        {
                            if(CE.Emp_nie == Convert.ToInt32(NumeroEmpleado))
                            {
                                IDComi = N.ComId;
                            }
                        }
                    }
                }
                if(IDComi > 0)
                {
                    Usuario U = new Usuario
                    {
                        IDR = Convert.ToInt32(RolEmpleado),
                        EstatusU = true,
                        NumeroEmpleadoU = Convert.ToInt32(NumeroEmpleado),
                        IDUNHumanSite = IDComi,
                        DiasCapacitacionU = Convert.ToInt32(DiasCapacitacion)
                        

                    };
                    SEC.Usuario.InsertOnSubmit(U);
                    SEC.SubmitChanges();
                    return 1;
                }
                else
                {
                    return 3;
                }
                
            }

        }
        catch (Exception e)
        {
            Log(e.Message + " AgregarUsuario");
            return 0;
        }
    }


    /// <summary>
    /// Función para desactivar un 
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int DesactivarActivarUsuario(string IDU, string instruccion)
    {
        try
        {
            bool AD;
            if (instruccion == "0")
            {
                AD = true;
            }
            else
            {
                AD = false;
            }
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from s in SEC.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
            U.EstatusU = AD;
            SEC.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " DesactivarActivarUsuario");
            return 0;
        }
    }

    /// <summary>
    /// Función para modificar la información de un usuario registrado.
    /// </summary>
    /// <param name="NombreEmpleado"></param>
    /// <param name="PuestoEmpleado"></param>
    /// <param name="RolEmpleado"></param>
    /// <param name="UnidadNegocioEmpleado"></param>
    /// <param name="NumeroEmpleado"></param>
    /// <param name="FechaIngresoEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ModificarUsuario(string RolEmpleado, string NumeroEmpleado, string UnidadesAsignadas, string EspCocina, string EspPiso, string EspPanaderia, string EspAlmacen, string DiasCapacitacion)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NumeroEmpleado) select s).SingleOrDefault();                        
            U.IDR = Convert.ToInt32(RolEmpleado);
            U.DiasCapacitacionU = Convert.ToInt32(DiasCapacitacion);
            SEC.SubmitChanges();            
            if (U.IDR == 3)
            {
                U.EspCocinaU = Convert.ToBoolean(EspCocina);
                U.EspPisoU = Convert.ToBoolean(EspPiso);
                U.EspPanaderiaU = Convert.ToBoolean(EspPanaderia);
                U.EspAlmacenU = Convert.ToBoolean(EspAlmacen);                
                SEC.SubmitChanges();
                var UniAsig = UnidadesAsignadas.Split(',');

                List<UsuarioUnidad> UAEliminar = (from ua in SEC.UsuarioUnidad where ua.IDU == U.IDU select ua).ToList();

                if (UAEliminar.Count > 0)
                {
                    foreach (UsuarioUnidad l in UAEliminar)
                    {
                        SEC.UsuarioUnidad.DeleteOnSubmit(l);
                        SEC.SubmitChanges();
                    }
                }

                foreach (var idu in UniAsig)
                {
                    UsuarioUnidad NUN = new UsuarioUnidad
                    {
                        IDU = U.IDU,
                        IDUN = Convert.ToInt32(idu),
                        NumeroEmpleadoUU = U.NumeroEmpleadoU
                    };
                    SEC.UsuarioUnidad.InsertOnSubmit(NUN);
                    SEC.SubmitChanges();
                }
            }
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " ModificarUsuario");
            return 0;
        }
    }

    

    /// <summary>
    /// Función para crear la tabla de usuarios que se muesta en el panel de administración
    /// </summary>
    /// <param name="numempleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaAdminUsuarios(string numempleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No. Empleado</th><th class='text-center color-fuente-strong'>Nombre</th><th class='text-center color-fuente-strong'>Puesto</th><th class='text-center color-fuente-strong'>Rol</th><th class='text-center color-fuente-strong'>Unidad de Negocio</th><th class='text-center color-fuente-strong'>Fecha Ingreso</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new WSInfoUnidadNegocioSoapPortClient();
            string e;
            List<ObtenerInfoUsuario> Usuarios = new List<ObtenerInfoUsuario>();
            Usuarios = (from s in SEC.ObtenerInfoUsuario select s).ToList();                                                                                                                                
            if(Usuarios.Count > 0)
            {
                foreach (ObtenerInfoUsuario dataE in Usuarios)
                {
                    var jsonEmpleado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(dataE.NumeroEmpleadoU), out e);
                    CEmpleado EmpleadoHuman = JsonConvert.DeserializeObject<CEmpleado>(jsonEmpleado);
                    respuesta += "<tr><th scope='row'>" + dataE.NumeroEmpleadoU + "</th>";
                    respuesta += "<td>" + EmpleadoHuman.Emp_patern + " " + EmpleadoHuman.Emp_matern + " " + EmpleadoHuman.Emp_nombres + "</td>";
                    respuesta += "<td>" + EmpleadoHuman.PuestoDsc + "</td>";
                    respuesta += "<td>" + dataE.NombreR + "</td>";
                    respuesta += "<td>" + dataE.NombreUN + "</td>";
                    respuesta += "<td>" + EmpleadoHuman.EmpFechaIngreso + "</td>";
                    if (dataE.EstatusU == true)
                    {
                        respuesta += "<td>Activo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalModificarUsuario(" + dataE.IDU + ", " + dataE.IDR + ", " + dataE.NumeroEmpleadoU + ", " + dataE.DiasCapacitacionU + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Modificar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='DesactivarActivarUsuario(" + dataE.IDU + ", " + 1 + ")'><i class='fa fa-user-times mr-2' aria-hidden='true'></i>Desactivar</button></td>";
                    }
                    else
                    {
                        respuesta += "<td>Inactivo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='DesactivarActivarUsuario(" + dataE.IDU + ", " + 0 + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Activar</button></td>";
                    }
                }
            }            
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " CrearTablaAdminUsuarios");
            return "Error";
        }
    }

     
    /// <summary>
    /// Función para validar si existe registrado el número de empleado.
    /// </summary>
    /// <param name="NumeroEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ValidaNumeroEmpleado(int NumeroEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<Usuario> Usuario = (from s in SEC.Usuario where s.NumeroEmpleadoU == NumeroEmpleado select s).ToList();
            if (Usuario.Count > 0)
            {
                return 0; //Ya existe el número de empleado
            }
            else
            {
                return 1; //No existe el número de empleado.
            }
        }
        catch (Exception e)
        {
            Log(e.Message + " ValidaNumeroEmpleado");
            return -1;
        }
    }

    /// <summary>
    /// Función para crear la tabla de Reporte Concentrado
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteConcentrado(string FechaIni, string FechaFin, string UnidadNegocio, string TipoEncuesta)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No de Evaluaciones</th><th class='text-center color-fuente-strong'>Evaluador</th><th class='text-center color-fuente-strong'>Evaluado</th><th class='text-center color-fuente-strong'>Unidad</th><th class='text-center color-fuente-strong'>Tipo</th><th class='text-center color-fuente-strong'>Desempeño Promedio</th><th class='text-center color-fuente-strong'>Descripción Desempeño</th><th class='text-center color-fuente-strong'>Detalle</th></tr></thead><tbody>";
            List<ReporteConcentrado> Listado = new List<ReporteConcentrado>();
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            string e;
            if(Convert.ToInt32(UnidadNegocio) <= 0 && Convert.ToInt32(TipoEncuesta) <= 0)
            {
                Listado = (from s in SEC.ReporteConcentrado where s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();
                
                foreach (ReporteConcentrado D in Listado)
                {
                    respuesta += "<tr><th scope='row' class='text-center'>" + D.NoEvaluaciones + "</th>";
                    var jsonInfoEvaluador = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluador), out e);
                    CEmpleado InfoEvaluador = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluador);
                    respuesta += "<td>" + InfoEvaluador.Emp_patern + " " + InfoEvaluador.Emp_matern + " " + InfoEvaluador.Emp_nombres + "</td>";
                    var jsonInfoEvaluado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluado), out e);
                    CEmpleado InfoEvaluado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluado);
                    respuesta += "<td>" + InfoEvaluado.Emp_patern + " " + InfoEvaluado.Emp_matern + " " + InfoEvaluado.Emp_nombres + "</td>";
                    respuesta += "<td>" + D.UnidadEvaluado + "</td>";
                    respuesta += "<td>" + D.TipoE + "</td>";
                    int promediodesempeno = ObtenerPromedioRespuesta(Convert.ToInt32(D.Evaluado),D.IDE);
                    switch (promediodesempeno)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Inaceptable</td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Bueno</td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Excelente</td>";
                            break;
                        default:
                            break;
                    }
                    respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalReporteDetalle(" + D.Evaluado + ", " + D.Evaluador + " , " + D.IDE + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Ver Detalle</button></td>";
                }
            }
            if (Convert.ToInt32(UnidadNegocio) > 0 && Convert.ToInt32(TipoEncuesta) <= 0)
            {
                Listado = (from s in SEC.ReporteConcentrado where s.IDHumanSiteUN == Convert.ToInt32(UnidadNegocio) && s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();

                foreach (ReporteConcentrado D in Listado)
                {
                    respuesta += "<tr><th scope='row' class='text-center'>" + D.NoEvaluaciones + "</th>";
                    var jsonInfoEvaluador = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluador), out e);
                    CEmpleado InfoEvaluador = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluador);
                    respuesta += "<td>" + InfoEvaluador.Emp_patern + " " + InfoEvaluador.Emp_matern + " " + InfoEvaluador.Emp_nombres + "</td>";
                    var jsonInfoEvaluado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluado), out e);
                    CEmpleado InfoEvaluado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluado);
                    respuesta += "<td>" + InfoEvaluado.Emp_patern + " " + InfoEvaluado.Emp_matern + " " + InfoEvaluado.Emp_nombres + "</td>";
                    respuesta += "<td>" + D.UnidadEvaluado + "</td>";
                    respuesta += "<td>" + D.TipoE + "</td>";
                    int promediodesempeno = ObtenerPromedioRespuesta(Convert.ToInt32(D.Evaluado),D.IDE);
                    switch (promediodesempeno)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Inaceptable</td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Bueno</td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Excelente</td>";
                            break;
                        default:
                            break;
                    }
                    respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalReporteDetalle(" + D.Evaluado + ", " + D.Evaluador + " , " + D.IDE + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Ver Detalle</button></td>";
                }
            }
            if (Convert.ToInt32(UnidadNegocio) <= 0 && Convert.ToInt32(TipoEncuesta) > 0)
            {
                Listado = (from s in SEC.ReporteConcentrado where s.IDE == Convert.ToInt32(TipoEncuesta) && s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();

                foreach (ReporteConcentrado D in Listado)
                {
                    respuesta += "<tr><th scope='row' class='text-center'>" + D.NoEvaluaciones + "</th>";
                    var jsonInfoEvaluador = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluador), out e);
                    CEmpleado InfoEvaluador = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluador);
                    respuesta += "<td>" + InfoEvaluador.Emp_patern + " " + InfoEvaluador.Emp_matern + " " + InfoEvaluador.Emp_nombres + "</td>";
                    var jsonInfoEvaluado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluado), out e);
                    CEmpleado InfoEvaluado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluado);
                    respuesta += "<td>" + InfoEvaluado.Emp_patern + " " + InfoEvaluado.Emp_matern + " " + InfoEvaluado.Emp_nombres + "</td>";
                    respuesta += "<td>" + D.UnidadEvaluado + "</td>";
                    respuesta += "<td>" + D.TipoE + "</td>";
                    int promediodesempeno = ObtenerPromedioRespuesta(Convert.ToInt32(D.Evaluado),D.IDE);
                    switch (promediodesempeno)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Inaceptable</td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Bueno</td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Excelente</td>";
                            break;
                        default:
                            break;
                    }
                    respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalReporteDetalle(" + D.Evaluado + ", " + D.Evaluador + " , " + D.IDE + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Ver Detalle</button></td>";
                }
            }
            if (Convert.ToInt32(UnidadNegocio) > 0 && Convert.ToInt32(TipoEncuesta) > 0)
            {
                Listado = (from s in SEC.ReporteConcentrado where s.IDE == Convert.ToInt32(TipoEncuesta) && s.IDHumanSiteUN == Convert.ToInt32(UnidadNegocio)  && s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();

                foreach (ReporteConcentrado D in Listado)
                {
                    respuesta += "<tr><th scope='row' class='text-center'>" + D.NoEvaluaciones + "</th>";
                    var jsonInfoEvaluador = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluador), out e);
                    CEmpleado InfoEvaluador = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluador);
                    respuesta += "<td>" + InfoEvaluador.Emp_patern + " " + InfoEvaluador.Emp_matern + " " + InfoEvaluador.Emp_nombres + "</td>";
                    var jsonInfoEvaluado = HS.GETINFOEMPLEADO("MRC", Convert.ToInt32(D.Evaluado), out e);
                    CEmpleado InfoEvaluado = JsonConvert.DeserializeObject<CEmpleado>(jsonInfoEvaluado);
                    respuesta += "<td>" + InfoEvaluado.Emp_patern + " " + InfoEvaluado.Emp_matern + " " + InfoEvaluado.Emp_nombres + "</td>";
                    respuesta += "<td>" + D.UnidadEvaluado + "</td>";
                    respuesta += "<td>" + D.TipoE + "</td>";
                    int promediodesempeno = ObtenerPromedioRespuesta(Convert.ToInt32(D.Evaluado),D.IDE);
                    switch (promediodesempeno)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Inaceptable</td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Bueno</td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            respuesta += "<td>Excelente</td>";
                            break;
                        default:
                            break;
                    }
                    respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalReporteDetalle(" + D.Evaluado + ", " + D.Evaluador + " , " + D.IDE + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Ver Detalle</button></td>";
                }
            }
            
            respuesta += "</tbody></table>";

            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteConcentrado");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener el promedio de respuestas de un usuario
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    public static int ObtenerPromedioRespuesta(int IDU, int TipoE)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<Usuario_Encuesta> Encuestas = (from e in SEC.Usuario_Encuesta where e.EvaluandoU_E == IDU && e.IDE == TipoE select e).ToList();
            int promedio = 0;
            int promedioacumulado = 0;
            int suma = 0;            
            if(Encuestas.Count > 0)
            {
                int[] IDREs = new int[Encuestas.Count];
                int aux = 0;
                foreach(Usuario_Encuesta E in Encuestas)
                {
                    IDREs[aux] = Convert.ToInt32(E.IDRE);
                    aux++;
                }

                List<Respuesta> Respuestas = (from r in SEC.Respuesta where IDREs.Contains(r.IDRE) select r).ToList();
                if(Respuestas.Count > 0)
                {
                    foreach(Respuesta R in Respuestas)
                    {
                        suma = 0;
                        suma += R.R1RE + R.R2RE + R.R3RE + R.R4RE + R.R5RE;
                        promedio = suma / 5; //Porque son cinco preguntas.
                        promedioacumulado += promedio;
                    }
                    promedioacumulado = promedioacumulado / Respuestas.Count;
                }
            }
            return promedioacumulado;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerPromedioRespuesta");
            return -1;
        }        

    }

    /// <summary>
    /// Función para obtener la tabla detalle del reporte concentrado
    /// sinceramente aquí no se que hice pero funciona y es lo que importa.
    /// </summary>
    /// <param name="IDEvaluando"></param>
    /// <param name="IDEvaluador"></param>
    /// <param name="Tipo"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerDetalleReporte(string IDEvaluando, string IDEvaluador, string Tipo)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Encuesta E = (from e in SEC.Encuesta where e.IDE == Convert.ToInt32(Tipo) select e).SingleOrDefault();
            Pregunta P1 = (from p1 in SEC.Pregunta where p1.IDP == E.P1E select p1).SingleOrDefault();
            Pregunta P2 = (from p2 in SEC.Pregunta where p2.IDP == E.P2E select p2).SingleOrDefault();
            Pregunta P3 = (from p3 in SEC.Pregunta where p3.IDP == E.P3E select p3).SingleOrDefault();
            Pregunta P4 = (from p4 in SEC.Pregunta where p4.IDP == E.P4E select p4).SingleOrDefault();
            Pregunta P5 = (from p5 in SEC.Pregunta where p5.IDP == E.P5E select p5).SingleOrDefault();
            List<ObtenerDetalleEncuesta> ListaDetalle = (from s in SEC.ObtenerDetalleEncuesta where s.IDU == Convert.ToInt32(IDEvaluador) && s.EvaluandoU_E == Convert.ToInt32(IDEvaluando) select s).ToList();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Pregunta</th>";

            int Colum = 1;
            DateTime M;
            foreach(ObtenerDetalleEncuesta C in ListaDetalle)//Generamos el número de columnas de acuerdo a el número de respuestas
            {
                M = Convert.ToDateTime(C.FechaAplicacionU_E);
                respuesta += "<th class='text-center color-fuente-strong'>Encuesta #" + Colum + " " + M.ToShortDateString() + " </th>";
                Colum++;
            }
            respuesta += "</tr></thead><tbody>";

            int[] iR1 = new int[ListaDetalle.Count];//Para cinco preguntas si cambia hay que agregar más arreglos y si se quiere hacer dinamico que Dios te acompañe.
            int[] iR2 = new int[ListaDetalle.Count];
            int[] iR3 = new int[ListaDetalle.Count];
            int[] iR4 = new int[ListaDetalle.Count];
            int[] iR5 = new int[ListaDetalle.Count];
            int aux = 0;
            foreach(ObtenerDetalleEncuesta D in ListaDetalle)//Guardamos todas las respuestas de una sola pregunta en el arreglo que le corresponde
            {
                iR1[aux] = D.R1RE;
                iR2[aux] = D.R2RE;
                iR3[aux] = D.R3RE;
                iR4[aux] = D.R4RE;
                iR5[aux] = D.R5RE;
                aux++;
            }
                //Las filas son fijas y por eso se agrega cada fila que es una pregunta y recorremos cada uno de los arreglos para obtener los datos de la fila para n columnas
                respuesta += "<tr><th scope='row'>" + P1.PreguntaP + "</th>";
                foreach(int D in iR1)
                {
                    switch (D)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        default:
                            break;
                    }                    
                }
                respuesta += "<tr><th scope='row'>" + P2.PreguntaP + "</th>";
                foreach(int F in iR2)
                {
                    switch (F)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        default:
                            break;
                    }    
                }
                respuesta += "<tr><th scope='row'>" + P3.PreguntaP + "</th>";
                foreach(int G in iR3)
                {
                    switch (G)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        default:
                            break;
                    }    
                }
                respuesta += "<tr><th scope='row'>" + P4.PreguntaP + "</th>";
                foreach(int H in iR4)
                {
                    switch (H)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        default:
                            break;
                    }    
                }
                respuesta += "<tr><th scope='row'>" + P5.PreguntaP + "</th>";
                foreach(int J in iR5)
                {
                    switch (J)
                    {
                        case 1:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 2:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star-o amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        case 3:
                            respuesta += "<td><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i><i class='fa fa-star amber-text fa-3x' aria-hidden='true'></i></td>";
                            break;
                        default:
                            break;
                    }    
                }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerDetalleReporte");
            return "Error";
        }
    }


    /// <summary>
    /// Función para crear el reporte de acreditación.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="UnidadNegocio"></param>
    /// <param name="NumEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteAcreditacion(string FechaIni, string FechaFin, string UnidadNegocio, string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No de Empleado</th><th class='text-center color-fuente-strong'>Nombre</th><th class='text-center color-fuente-strong'>Fecha de Ingreso</th><th class='text-center color-fuente-strong'>Fecha Culmina Capacitación</th><th class='text-center color-fuente-strong'>Unidad</th><th class='text-center color-fuente-strong'>Puesto</th><th class='text-center color-fuente-strong'>Duración de Capacitación</th><th class='text-center color-fuente-strong'>Duración Real</th><th class='text-center color-fuente-strong'>No. Evaluaciones</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            string e;
            List<int> Usuarios = new List<int>();
            HumanSite.WSInfoUnidadNegocioSoapPortClient HS = new HumanSite.WSInfoUnidadNegocioSoapPortClient();
            List<CEmpleado> EmpleadosHumanSite = new List<CEmpleado>();
            List<CEmpleado> UsuariosFinal = new List<CEmpleado>();
            if(Convert.ToInt32(UnidadNegocio) > 0 && NumEmpleado != "")
            {
                Usuarios = (from s in SEC.Usuario where s.EstatusU == true && s.IDUNHumanSite == Convert.ToInt32(UnidadNegocio) && s.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select Convert.ToInt32(s.NumeroEmpleadoU)).ToList();
                var jsonEmpleadosHumanSite = HS.GETEMPLEADOS("MRC", "", "", Convert.ToInt32(UnidadNegocio), "", out e);
                EmpleadosHumanSite = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleadosHumanSite);
                UsuariosFinal = (from s in EmpleadosHumanSite where Usuarios.Contains(s.Emp_nie) && Convert.ToDateTime(s.EmpFechaIngreso) >= Convert.ToDateTime(FechaIni) && Convert.ToDateTime(s.EmpFechaIngreso) <= Convert.ToDateTime(FechaFin) select s).ToList();                
            }
            if(Convert.ToInt32(UnidadNegocio) > 0 && NumEmpleado == "")
            {
                Usuarios = (from s in SEC.Usuario where s.EstatusU == true && s.IDUNHumanSite == Convert.ToInt32(UnidadNegocio) select s.NumeroEmpleadoU).ToList();
                var jsonEmpleadosHumanSite = HS.GETEMPLEADOS("MRC", "", "", Convert.ToInt32(UnidadNegocio), "", out e);
                EmpleadosHumanSite = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleadosHumanSite);
                UsuariosFinal = (from s in EmpleadosHumanSite where Usuarios.Contains(s.Emp_nie) && Convert.ToDateTime(s.EmpFechaIngreso) >= Convert.ToDateTime(FechaIni) && Convert.ToDateTime(s.EmpFechaIngreso) <= Convert.ToDateTime(FechaFin) select s).ToList();                
            }
            if (Convert.ToInt32(UnidadNegocio) <= 0 && NumEmpleado != "")
            {
                Usuarios = (from s in SEC.Usuario where s.EstatusU == true && s.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select s.NumeroEmpleadoU).ToList();
                var jsonEmpleadosHumanSite = HS.GETEMPLEADOS("MRC", "", "", 0, "", out e);
                EmpleadosHumanSite = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleadosHumanSite);
                UsuariosFinal = (from s in EmpleadosHumanSite where Usuarios.Contains(s.Emp_nie) && Convert.ToDateTime(s.EmpFechaIngreso) >= Convert.ToDateTime(FechaIni) && Convert.ToDateTime(s.EmpFechaIngreso) <= Convert.ToDateTime(FechaFin) select s).ToList();
            }
            if (Convert.ToInt32(UnidadNegocio) <= 0 && NumEmpleado == "")
            {
                Usuarios = (from s in SEC.Usuario where s.EstatusU == true select s.NumeroEmpleadoU).ToList();
                var jsonEmpleadosHumanSite = HS.GETEMPLEADOS("MRC", "", "", 0, "", out e);
                EmpleadosHumanSite = JsonConvert.DeserializeObject<List<CEmpleado>>(jsonEmpleadosHumanSite);
                UsuariosFinal = (from s in EmpleadosHumanSite where Usuarios.Contains(s.Emp_nie) && Convert.ToDateTime(s.EmpFechaIngreso) >= Convert.ToDateTime(FechaIni) && Convert.ToDateTime(s.EmpFechaIngreso) <= Convert.ToDateTime(FechaFin) select s).ToList();
            }

            if (UsuariosFinal.Count > 0)
            {
                foreach (CEmpleado D in UsuariosFinal)
                {
                    Usuario U = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(D.Emp_nie) select s).SingleOrDefault();
                    Unidad UN = (from s in SEC.Unidad where s.IDHumanSiteUN == U.IDUNHumanSite select s).SingleOrDefault();
                    respuesta += "<tr><th scope='row' class='text-center'>" + D.Emp_nie + "</th>";
                    respuesta += "<td>" + D.Emp_patern + " " + D.Emp_matern + " " + D.Emp_nombres + "</td>";
                    respuesta += "<td class='text-center'>" + D.EmpFechaIngreso + "</td>";
                    respuesta += "<td class='text-center'>" + Convert.ToDateTime(D.EmpFechaIngreso).AddDays(Convert.ToDouble(U.DiasCapacitacionU)).ToShortDateString() + "</td>";
                    respuesta += "<td>" + UN.NombreUN + "</td>";
                    respuesta += "<td>" + D.PuestoDsc + "</td>";
                    respuesta += "<td class='text-center'>" + U.DiasCapacitacionU + "</td>";
                    TimeSpan ts = DateTime.Now - Convert.ToDateTime(D.EmpFechaIngreso);
                    respuesta += "<td class='text-center'>" + ts.Days + "</td>";
                    respuesta += "<td class='text-center'>" + ObtenerEvaluacionesPorUsuario(D.Emp_nie) + "</td>";
                    if(ts.Days >= U.DiasCapacitacionU)
                    {
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AcreditarUsuario(" + D.Emp_nie + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Acreditar</button><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalComentarios(" + D.Emp_nie + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Agregar Comentarios</button></td>";
                    }
                    else
                    {
                        respuesta += "<td></td>";
                    }                    
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }

        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteAcreditacion");
            return "Error";
        }
    }


    /// <summary>
    /// Función para acreditar a un usuario.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AcreditarUsuario(string NoEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NoEmpleado) select s).SingleOrDefault();
            U.EstatusU = false;
            U.FechaAcreditacionU = DateTime.Now;
            SEC.SubmitChanges();
            return 1;
        }
        catch(Exception e)
        {
            Log(e.Message + " AcreditarUsuario");
            return 0;
        }
    }


    /// <summary>
    /// Función para agregar observaciones a un usuario.
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="Observaciones"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AgregarObservacionesUsuario(string NoEmpleado, string Observaciones)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NoEmpleado) select s).SingleOrDefault();
            U.ObservacionesAcreditacionU = Observaciones;
            SEC.SubmitChanges();
            return 1;
        }
        catch(Exception e)
        {
            Log(e.Message + " AgregarObservacionesUsuario");
            return 0;
        }
    }

    /// <summary>
    /// Devuelve el número de evaluaciones que tiene el usuario ingresado.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    public static int ObtenerEvaluacionesPorUsuario(int NoEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<Usuario_Encuesta> UE = (from s in SEC.Usuario_Encuesta where s.EvaluandoU_E == NoEmpleado select s).ToList();
            return UE.Count;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerEvaluacionesPorUsuario");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener las unidades para la gráfica de evaluaciones por unidad.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerUnidadesEncuestas(string FechaIni, string FechaFin)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<ObtenerEvaluacionesUnidad> EvaluacionesUnidad = (from s in SEC.ObtenerEvaluacionesUnidad where s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();
            string[] Unidades = new string[EvaluacionesUnidad.Count];
            int aux = 0;

                foreach(ObtenerEvaluacionesUnidad D in EvaluacionesUnidad)
                {
                    Unidades[aux] = D.NombreUN;
                    aux++;
                }
            return Unidades;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerUnidadesEncuestas");
            string[] Unidades = new string[0];
            return Unidades;
        }
    }

    /// <summary>
    /// Función para obtener los valores de las unidades para la gráfica de evaluaciones por unidad.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerValoresUnidadEncuestas(string FechaIni, string FechaFin)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<ObtenerEvaluacionesUnidad> EvaluacionesUnidad = (from s in SEC.ObtenerEvaluacionesUnidad where s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();
            int[] Valores = new int[EvaluacionesUnidad.Count];
            int aux = 0;

            foreach (ObtenerEvaluacionesUnidad D in EvaluacionesUnidad)
                {
                    Valores[aux] = Convert.ToInt32(D.NoEvaluaciones);
                    aux++;
                }


            return Valores;

        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerValoresUnidadEncuestas");
            int[] Valores = new int[0];
            return Valores;
        }
    }

    /// <summary>
    /// Función para obtener las unidades promedio para la gráfica de promedio.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerUnidadesPromedio(string FechaIni, string FechaFin)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<ObtenerPromedioUnidad> ListUnidades = (from s in SEC.ObtenerPromedioUnidad where s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();
            string[] Unidades = new string[ListUnidades.Count];
            int aux = 0;
            if(ListUnidades.Count > 0)
            {
                foreach (ObtenerPromedioUnidad D in ListUnidades)
                {
                    Unidades[aux] = D.NombreUN;
                    aux++;
                }
            }

            return Unidades;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerUnidadesPromedio");
            string[] Unidades = new string[0];
            return Unidades;
        }
    }

    /// <summary>
    /// Función para devolver el promedio de respuesta por unidad para la gráfica de promedio.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerValoresUnidadPromedio(string FechaIni, string FechaFin)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            List<ObtenerPromedioUnidad> ListUnidades = (from s in SEC.ObtenerPromedioUnidad where s.FechaAplicacionU_E >= Convert.ToDateTime(FechaIni) && s.FechaAplicacionU_E <= Convert.ToDateTime(FechaFin) select s).ToList();
            double[] Valores = new double[ListUnidades.Count];
            int aux = 0;
            if(ListUnidades.Count > 0)
            {
                foreach (ObtenerPromedioUnidad D in ListUnidades)
                {
                    double suma = 0;
                    double promedio = 0;
                    suma = Convert.ToDouble(D.PR1 + D.PR2 + D.PR3 + D.PR4 + D.PR5);
                    promedio = suma / 5; //Porque son cinco preguntas
                    Valores[aux] = promedio;
                    aux++;
                }
            }
            return Valores;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerValoresUnidadPromedio");
            decimal[] Valores = new decimal[0];
            return Valores;
        }
    }

    /// <summary>
    /// Función para obtener las unidades asignadas de un capacitador select
    /// </summary>
    /// <param name="NumeroEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerUnidadesAsignadasSelect(string NumeroEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from u in SEC.Usuario where u.NumeroEmpleadoU == Convert.ToInt32(NumeroEmpleado) select u).SingleOrDefault();
            List<UsuarioUnidad> UU = (from uu in SEC.UsuarioUnidad where uu.IDU == U.IDU select uu).ToList();
            string respuesta = "";
            int[] unidadesasignadas = new int[UU.Count];
            int aux = 0;
            if(UU.Count > 0)
            {
                foreach(UsuarioUnidad Y in UU)
                {
                    unidadesasignadas[aux] = Convert.ToInt32(Y.IDUN);
                    aux++;
                }
            }
            List<Unidad> Unidades = (from n in SEC.Unidad select n).ToList();
            if (Unidades.Count > 0)
            {
                if (UU.Count > 0)
                {
                    foreach(Unidad D in Unidades)
                    {
                        if (unidadesasignadas.Contains(D.IDUN))
                        {
                            respuesta += "<option value=" + D.IDUN + " selected>" + D.NombreUN + "</option>";
                        }
                        else
                        {
                            respuesta += "<option value=" + D.IDUN + ">" + D.NombreUN + "</option>";
                        }                      
                    }
                }
                else
                {
                    foreach(Unidad D in Unidades)
                    {
                        respuesta += "<option value=" + D.IDUN + ">" + D.NombreUN + "</option>";
                    }
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerUnidadesAsignadas");
            return "";
        }
    }

    /// <summary>
    /// Función para obtener las especialidades de un usuario por medio de el número de empleado.
    /// </summary>
    /// <param name="NumEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerEspecialidadesCapacitador(string NumEmpleado)
    {
        try
        {
            SECDataContext SEC = new SECDataContext();
            Usuario U = (from s in SEC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NumEmpleado) select s).SingleOrDefault();
            bool[] Especialidades = new bool[4];
            Especialidades[0] = Convert.ToBoolean(U.EspCocinaU);
            Especialidades[1] = Convert.ToBoolean(U.EspPisoU);
            Especialidades[2] = Convert.ToBoolean(U.EspPanaderiaU);
            Especialidades[3] = Convert.ToBoolean(U.EspAlmacenU);

            return Especialidades;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerEspecialidadesCapacitador");
            bool[] Especialidades = new bool[0];
            return Especialidades;
        }
    }
}


