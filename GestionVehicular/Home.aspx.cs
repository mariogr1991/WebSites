using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.IO;
using MRCTools;



public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string us = Request.QueryString["Name"].ToString();
        if(string.IsNullOrEmpty(us) || us == "" || us == null)
        {
            Response.Redirect("http://mrc.sytes.net/GestionVehicular/IntrusoDetectado.aspx");
        }

        RolUsuario.Text = ObtenerRol(us);
        NombreUsuario.Text = ObtenerNombre(us);        
        
    }
    
    public static void Log(string mensaje)
    {
        string path = ConfigurationManager.AppSettings["RutaLog"]+"Log"+DateTime.Now.ToString("yyyyMMdd")+".txt";
        if (!File.Exists(path))
        {
            using (StreamWriter sw = File.CreateText(path))
            {
                sw.WriteLine(DateTime.Now.ToString()+" "+mensaje);
            }
        }
        else
        {
            using (StreamWriter sw = File.AppendText(path))
            {
               AgregarLinea(mensaje,sw);
            }
        }
        
    }

    public static void AgregarLinea(string mensaje, TextWriter w)
    {
        w.WriteLine(DateTime.Now.ToString() + " " + mensaje);
    }

    //[System.Web.Services.WebMethod]
    /// <summary>
    /// Obtiene el Nombre de Usuario
    /// </summary>
    /// <param name="Usuario"></param>
    /// <returns></returns>
    public static string ObtenerNombre(string Usuario)
    {

        try
        {
            

            ModelDataDataContext GV = new ModelDataDataContext();            
            List<Usuario> Usuarios = (from s in GV.Usuario where s.NombreUsuarioU == Usuario && s.EstatusU == 1 select s).ToList();
            string Nombre = "";

            if (Usuarios.Count > 0)
            {                
                foreach (Usuario data in Usuarios)
                {
                    Nombre = data.NombreU;
                }
            }

            return Nombre;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
        
    }

    /// <summary>
    /// Función para obtener el rol del usuario logueado
    /// </summary>
    /// <param name="nombre"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerRol(string nombre)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string rol = "";

            List<ObtenerRol> Rolin = (from s in GV.ObtenerRol where s.NombreUsuarioU == nombre select s).ToList();
            if (Rolin.Count == 1)
            {
                foreach (ObtenerRol i in Rolin)
                {
                    rol = i.NombreR.ToString();
                }
            }

            return rol;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
        
    }

    /// <summary>
    /// Obtiene los datos del usuario logueado.
    /// </summary>
    /// <param name="NombreUsuario"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static Array ObtenerDatosTrabajador(string NombreUsuario)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DU = (from s in GV.ObtenerDatosUsuario where s.NombreUsuarioU == NombreUsuario select s).ToArray();
            return DU;
        }
        catch (Exception e)
        {
            Log(e.Message);
            ObtenerDatosUsuario[] ODU = new ObtenerDatosUsuario[0];
            return ODU;
        }

    }

    /// <summary>
    /// Obtiene el listado de destinos disponibles en la base de datos.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerDestinos()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Destinos> Destinos = (from s in GV.Destinos orderby s.NombreUN ascending select s).ToList();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            if (Destinos.Count > 0)
            {
                foreach (Destinos D in Destinos)
                {
                    respuesta += "<option value=" + D.IDUN + ">" + D.NombreUN + "</option>";
                }
                respuesta += "<option value=" + -1 + ">OTRO</option>";
            }
            else
            {
                respuesta += "<option value=" + -1 + ">OTRO</option>";
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
        
    }

    /// <summary>
    /// Función para obtener las áreas disponibles para elegir.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerAreas()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerAreas> Areas = (from s in GV.ObtenerAreas select s).ToList();
            string respuesta = "<option value='TODAS'>TODAS</option>";
            if (Areas.Count > 0)
            {
                foreach (ObtenerAreas A in Areas)
                {
                    respuesta += "<option value='" + A.AreaU + "'>" + A.AreaU + "</option>";
                }
            }

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
        
    }

    /// <summary>
    /// Función para obtener las áreas disponibles para elegir en alta usuario.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerAreasUsuario()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerAreas> Areas = (from s in GV.ObtenerAreas select s).ToList();
            string respuesta = "<option value='-1'>Seleccione un área por favor.</option>";
            if (Areas.Count > 0)
            {
                foreach (ObtenerAreas A in Areas)
                {
                    respuesta += "<option value=" + A.AreaU + ">" + A.AreaU + "</option>";
                }
            }

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }

    }

    /// <summary>
    /// Fnción para obtener los roles activos de la base de datos. 
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerRoles()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Rol> R = (from s in GV.Rol where s.EstatusR == true select s).ToList();
            string respuesta = "<option value='-1'>Seleccione un rol por favor.</option>";
            if (R.Count > 0)
            {
                foreach (Rol D in R)
                {
                    respuesta += "<option value=" + D.IDR + ">" + D.NombreR + "</option>";
                }
            }
            return respuesta;
        }

        catch(Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener los vehículos disponibles
    /// </summary>
    /// <param name="solicitud"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerVehiculos(string solicitud)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array VOcupados = ValidarVehiculosAsignados(solicitud);
            List<int> ListaIDV = new List<int>();
            foreach(int IDV in VOcupados){
                ListaIDV.Add(IDV);
            }
            List<int> U1 = (from u in GV.ObtenerVehiculosDisponibles select u.IDV).ToList();
            List<ObtenerVehiculosDisponibles> VD = (from s in GV.ObtenerVehiculosDisponibles where !ListaIDV.Contains(s.IDV) && s.EstatusV == 1 select s).ToList();
            string respuesta = "<option value='-1'>Seleccione un vehículo</option>";
            if (VD.Count > 0)
            {
                foreach (ObtenerVehiculosDisponibles d in VD)
                {
                    respuesta += "<option value=" + d.IDV + ">" + d.MarcaV + " " + d.ModeloV + " " + d.ColorV + "</option>";
                }
            }
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "<option value='-1'>Seleccione un vehículo</option>";
        }
    }

    /// <summary>
    /// Función para obtener los choferes disponibles.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerChoferes(string solicitud)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();            
            string respuesta = "<option value='-1'>Seleccione un chofer</option>";
            Solicitud Sol = (from m in GV.Solicitud where m.IDS == Convert.ToInt32(solicitud) select m).SingleOrDefault();
            if (Sol.RequiereChoferS == true)
            {
                Array ChoferesOcupados = ValidarChoferAsignado(solicitud);
                List<int> CO = new List<int>();
                foreach (int IDU in ChoferesOcupados)
                {
                    CO.Add(IDU);
                }
                List<Usuario> UCH = (from s in GV.Usuario where s.IDR == 4 && s.EstatusU == 1 && !CO.Contains(s.IDU) select s).ToList();
                if (UCH.Count > 0)
                {
                    foreach (Usuario D in UCH)
                    {
                        respuesta += "<option value=" + D.IDU + ">" + D.NombreU + "</option>";
                    }
                }
            }            
            return respuesta;
        }        
        catch(Exception e)
        {
            Log(e.Message);
            return "<option value='-1'>Seleccione un chofer</option>";
        }
    }

    /// <summary>
    /// Obtiene los solicitantes que existen en la base de datos, en la tabla usuario
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerSolicitantes()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();

            List<Usuario> Solicitantes = (from s in GV.Usuario select s).ToList();
            string respuesta = "<option value='-1'>Seleccione un usuario</option>";
            if(Solicitantes.Count > 0)
            {
                foreach(Usuario D in Solicitantes)
                {
                    respuesta += "<option value=" + D.IDU + ">" + D.NombreU + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerSolicitantes");
            return "<option value='-1'>Seleccione un usuario</option>";
        }
    }

    /// <summary>
    /// Función para obtener la información del vehiculo seleccionado
    /// </summary>
    /// <param name="IDV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static Array ObtenerInfoVehiculo(string IDV)
    {               
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array IV = (from s in GV.ObtenerDatosVehiculo where s.IDV == Convert.ToInt32(IDV) select s).ToArray();
            return IV;
        }

        catch (Exception e)
        {
            Log(e.Message);
            Vehiculo[] T = new Vehiculo[0];
            return T;
        }
        
        
    }

    /// <summary>
    /// Función para obtener el detalle de la solicitud que requiere ajustes.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatoSolicitud(string solicitud)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DS = (from s in GV.ObtenerDatosSolicitudAjustes where s.IDS == Convert.ToInt64(solicitud) select s).ToArray();
            return DS;
        }
        catch (Exception e)
        {
            Log(e.Message);
            ObtenerDatosSolicitudAjustes[] S = new ObtenerDatosSolicitudAjustes[0];
            return S;
        }

    }

    /// <summary>
    /// Función para obtener el detalle de la solicitud de escala que requiere ajustes.
    /// </summary>    
    /// <param name="escala"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatoSolicitudEscala(string escala){
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DE = (from s in GV.ObtenerDatosSolicitudEscalaAjustes where s.IDE == Convert.ToInt32(escala) select s).ToArray();
            return DE;
        }
        catch (Exception e)
        {
            Log(e.Message);
            ObtenerDatosSolicitudEscalaAjustes[] E = new ObtenerDatosSolicitudEscalaAjustes[0];
            return E;
        }
    }

    /// <summary>
    /// Función para obtener el detalle del seguimiento de la solicitud.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatosSeguimientoSolicitud(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DS = (from s in GV.ObtenerDatosSeguimientoSolicitud where s.IDS == Convert.ToInt32(IDS) select s).ToArray();
            return DS;
        }
        catch(Exception e)
        {
            Log(e.Message);
            ObtenerDatosSeguimientoSolicitud[] E = new ObtenerDatosSeguimientoSolicitud[0];
            return E;
        }
    }

    /// <summary>
    /// Función para obtener el detalle del seguimiento de la solicitud de escala.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="IDE"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatosSeguimientoEscala(string IDS, string IDE)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DE = (from s in GV.ObtenerDatosSeguimientoEscala where s.IDS == Convert.ToInt32(IDS) && s.IDE == Convert.ToInt32(IDE) select s).ToArray();
            return DE;
        }
        catch (Exception e)
        {
            Log(e.Message);
            ObtenerDatosSeguimientoEscala[] E = new ObtenerDatosSeguimientoEscala[0];
            return E;
        }
    }

    /// <summary>
    /// Función para obtener los datos del usuario por medio dle IDU.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerUsuarioModificar(string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DU = (from s in GV.ObtenerDatosUsuario where s.IDU == Convert.ToInt32(IDU) select s).ToArray();
            return DU;
        }
        catch(Exception e)
        {
            Log(e.Message);
            Usuario[] DU = new Usuario[0];
            return DU;
        }
    }

    /// <summary>
    /// Función para obtener los datos a modificar de la unidad de negocio.
    /// </summary>
    /// <param name="IDUN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerUnidadNegocioModificar(string IDUN)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array UN = (from s in GV.Unidad where s.IDUN == Convert.ToInt32(IDUN) select s).ToArray();
            return UN;

        }
        catch (Exception e)
        {
            Log(e.Message);
            Unidad[] UN = new Unidad[0];
            return UN;
        }
    }

    /// <summary>
    /// Función para obtener los datos del vehículo a modificar.
    /// </summary>
    /// <param name="IDV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerVehiculoModificar(string IDV)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Array DV = (from s in GV.ObtenerDatosVehiculo where s.IDV == Convert.ToInt32(IDV) select s).ToArray();
            return DV;
        }
        catch (Exception e)
        {
            Log(e.Message);
            Vehiculo[] V = new Vehiculo[0];
            return V;
        }
    }

    /// <summary>
    /// Función para obtener el correo electrónico del jefe directo por área.
    /// </summary>
    /// <param name="area"></param>
    /// <returns></returns>
    public static string ObtenerCorreoJefeDirecto(string area)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario Jefe = (from s in GV.Usuario where s.AreaU == area && s.PuestoU == "Director" select s).SingleOrDefault();
            return Jefe.CorreoElectronicoU;
        }
        catch(Exception e)
        {
            Log(e.Message + " Obtener Correo de Jefe Directo");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener el correo electronico del administrador
    /// </summary>
    /// <returns></returns>
    public static Array ObtenerCorreoAdministrador()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Usuario> UA = (from s in GV.Usuario where s.IDR == 3 select s).ToList();
            string[] Direcciones = new string[UA.Count];
            int aux = 0;
            foreach(Usuario D in UA)
            {
                Direcciones[aux] = D.CorreoElectronicoU;
                aux++;
            }
            return Direcciones;
        }
        catch (Exception e)
        {
            Log(e.Message + " Obtener Correo Administrador");
            string[] D = new string[0];
            return D;
        }
    }

    /// <summary>
    /// Función para obtener los correos de los usuarios que solicitaron escalas en una solicitud y esta se va a cancelar, igual aquí se cancela las escalas asociadas.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    public static Array ObtenerCorreoEscalas(int IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Ruta R = (from r in GV.Ruta where r.IDS == IDS select r).SingleOrDefault();
            List<Escala> Escalas = (from e in GV.Escala where e.IDRT == R.IDRT && e.EstatusE == 4 select e).ToList();
            string[] correos = new string[Escalas.Count];
            int aux = 0;
            if(Escalas.Count > 0)
            {                
                foreach (Escala D in Escalas)
                {
                    D.EstatusE = 3;
                    D.MotivoCancelacionAjusteE = "Solicitante cancelo el viaje asociado a esta escala.";                    
                    GV.SubmitChanges();
                    Usuario U = (from s in GV.Usuario where s.IDU == D.IDU select s).SingleOrDefault();
                    correos[aux] = U.CorreoElectronicoU;
                    aux++;
                }
            }

            return correos;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerCorreoEscalas");
            string[] correo = new string[0];
            return correo;
        }
    }

    

    /// <summary>
    /// Función para actualiar el número de telefono en usuario, insertar datos de nueva solicitud y registrar ruta en Ruta
    /// </summary>
    /// <param name="telefono"></param>
    /// <param name="motivo"></param>
    /// <param name="destino"></param>
    /// <param name="fechasalida"></param>
    /// <param name="horasalida"></param>
    /// <param name="fecharegreso"></param>
    /// <param name="horaregreso"></param>
    /// <param name="ruta"></param>
    /// <param name="observaciones"></param>
    /// <param name="chofer"></param>
    /// <param name="idu"></param>
    /// <param name="lugares"></param>
    /// <param name="otrodestino"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int InsertarSolicitud(string telefono, string motivo, string destino, string fechasalida, string horasalida, string fecharegreso, string horaregreso, string ruta, string observaciones, string chofer, string idu, string lugares, string otrodestino, string contactoemergencia, string telefonoemergencia)
    {
        ModelDataDataContext GV = new ModelDataDataContext();

        try
        {
            Usuario Mod = (from s in GV.Usuario where s.IDU == Convert.ToInt32(idu) select s).SingleOrDefault();
            Mod.TelefonoU = telefono;
            Mod.NombreContactoEmergenciaU = contactoemergencia;
            Mod.TelefonoContactoEmergenciaU = telefonoemergencia;
            GV.SubmitChanges();

            DateTime FechaActual = DateTime.Now;
            TimeSpan HS = TimeSpan.Parse(horasalida);
            TimeSpan HR = TimeSpan.Parse(horaregreso);

            int ValidacionSolicitudesSinConcluir = ValidarSolicitudesSinConcluir(Mod.IDU.ToString());
            int ValidacionSolicitudesEscalaSinConcluir = ValidarSolicitudesEscalaSinConcluir(Mod.IDU);

            if (ValidacionSolicitudesEscalaSinConcluir > 0)
            {
                return 2; //Existen solicitudes escala sin concluir.
            }
            else if (ValidacionSolicitudesEscalaSinConcluir == -1)
            {
                return 0; // Error en la función ValidarSolicitudesEscalaSinConcluir
            }

            if (ValidacionSolicitudesSinConcluir == -1)
            {
                return 0; // Error en la función ValidarSolicitudesSinConcluir
            }
            else if (ValidacionSolicitudesSinConcluir > 0)
            {
                return 2; //Existen solicitudes sin concluir.
            }

            int ValidacionVehiculosDisponibles = ValidarDisponibilidadVehiculo(Convert.ToDateTime(fechasalida),HS,Convert.ToDateTime(fecharegreso),HR);

            if(ValidacionVehiculosDisponibles == 1)
            {
                return 3; //Ya no hay vehículos disponibles.
            }
            else if (ValidacionVehiculosDisponibles == 0)
            {
                return 0; // Error en la función. ValidarDisponibilidadVehiculo
            }

            if (Convert.ToBoolean(chofer) == true)
            {
                int ValidarDisponibilidadCHofer = ValidarDisponibilidadChofer(Convert.ToDateTime(fechasalida), HS, Convert.ToDateTime(fecharegreso), HR);

                if (ValidarDisponibilidadCHofer == 0)
                {
                    return 0; // Error en la función ValidarDisponibilidadChofer
                }
                if (ValidarDisponibilidadCHofer == 2)
                {
                    return 4; //Ya no hay chofer disponible
                }
            }

           
            TimeSpan DifDias = Convert.ToDateTime(fechasalida) - Convert.ToDateTime(FechaActual.ToShortDateString());
            int iDifDias = DifDias.Days;
            string observacionessistema = "";
            if (iDifDias <= 1)
            {
                observacionessistema = " La solicitud no se realizo con 24 horas de anticipación cómo lo marca la politica, tenga en cuenta al momento de autorizar y asignar.";
            }

            Solicitud Sol = new Solicitud            
            {
                IDU = Convert.ToInt32(idu),
                OrigenS = 12,
                DestinoS = Convert.ToInt32(destino),
                OtroDestinoS = otrodestino,
                MotivoS = motivo,
                FechaSalidaS = Convert.ToDateTime(fechasalida),
                HoraSalidaS = HS,
                FechaRegresoS = Convert.ToDateTime(fecharegreso),
                HoraRegresoS = HR,
                ObservacionesS = observaciones,
                ObservacionesSistemaS = observacionessistema,
                LugaresDisponiblesS = lugares,
                RequiereChoferS = Convert.ToBoolean(chofer),
                EstatusS = 0,
                FechaCrecionS = FechaActual                
                
            };
            

            GV.Solicitud.InsertOnSubmit(Sol);
            GV.SubmitChanges();
            long IDS = Sol.IDS;

            Ruta Rut = new Ruta
            {
                IDS = IDS,
                DescripcionRT = ruta

            };
            GV.Ruta.InsertOnSubmit(Rut);
            GV.SubmitChanges();
            Correo CorreoNuevaSolicitud = new Correo();
            string correojefedirecto = ObtenerCorreoJefeDirecto(Mod.AreaU);
            string asunto = "Solicitud pendiente de autorización";
            string cuerpomensaje = "Hay una nueva solicitud pendiente de aprobación del solicitante: ";
            string nombresolicitante = Mod.NombreU;
            string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            CorreoNuevaSolicitud.EnviarCorreo(correojefedirecto, mensaje, asunto);
            return 1;
        }

        catch(Exception e)
        {
            Log(e.Message);
            return 0;
        }

       
    }

    /// <summary>
    /// Función para insertar un nuevo usuario.
    /// </summary>
    /// <param name="nombre"></param>
    /// <param name="puesto"></param>
    /// <param name="area"></param>
    /// <param name="telefono"></param>
    /// <param name="curp"></param>
    /// <param name="nombreusuario"></param>
    /// <param name="contrasena"></param>
    /// <param name="nss"></param>
    /// <param name="rol"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int InsertarUsuario(string nombre, string puesto, string area, string telefono, string curp, string nombreusuario, string contrasena, string nss, string rol, string correo)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            int respuesta;
            List<Usuario> Verificador = (from s in GV.Usuario where s.NombreUsuarioU == nombreusuario select s).ToList();

            if (Verificador.Count > 0)
            {
                respuesta = 2;
            }
            else
            {
                Usuario U = new Usuario
                {
                    NombreU = nombre.ToUpper(),
                    PuestoU = puesto,
                    AreaU = area,
                    TelefonoU = telefono,
                    CURPU = curp,
                    NombreUsuarioU = nombreusuario,
                    ContrasenaU = contrasena,
                    NSSU = nss,
                    IDR = Convert.ToInt32(rol),
                    CorreoElectronicoU = correo,
                    EstatusU = 1

                };
                GV.Usuario.InsertOnSubmit(U);
                GV.SubmitChanges();
                respuesta = 1;
            }
            
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para insertar una nueva unidad de negocio.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int InsertarUnidadNegocio(string nombre, string direccion)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Unidad UN = new Unidad
            {
                NombreUN = nombre.ToUpper(),
                DireccionUN = direccion,
                EstatusUN = 1
            };
            GV.Unidad.InsertOnSubmit(UN);
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }
    
    /// <summary>
    /// Función para insertar un nuevo vehículo.
    /// </summary>
    /// <param name="marca"></param>
    /// <param name="modelo"></param>
    /// <param name="polizaseguro"></param>
    /// <param name="color"></param>
    /// <param name="placa"></param>
    /// <param name="capacidad"></param>
    /// <param name="noserie"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int InsertarVehiculo(string marca, string modelo, string polizaseguro, string color, string placa, string capacidad, string noserie)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo V = new Vehiculo
            {
                MarcaV = marca.ToUpper(),
                ModeloV = modelo.ToUpper(),
                PolizaSeguroV = polizaseguro.ToUpper(),
                ColorV = color.ToUpper(),
                PlacaV = placa.ToUpper(),
                CapacidadV = Convert.ToInt32(capacidad),
                NumSerieV = noserie,
                EstatusV = 1
            };
            GV.Vehiculo.InsertOnSubmit(V);
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar la información de un usuario de acuerdo al IDU recibido.
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="nombre"></param>
    /// <param name="puesto"></param>
    /// <param name="area"></param>
    /// <param name="telefono"></param>
    /// <param name="curp"></param>
    /// <param name="nombreusuario"></param>
    /// <param name="contrasena"></param>
    /// <param name="nss"></param>
    /// <param name="rol"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActualizarUsuario(string IDU, string nombre, string puesto, string area, string telefono, string curp, string nombreusuario, string contrasena, string nss, string rol)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario U = (from s in GV.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
            U.NombreU = nombre;
            U.PuestoU = puesto;
            U.AreaU = area;
            U.TelefonoU = telefono;
            U.CURPU = curp;
            U.NombreUsuarioU = nombreusuario;
            U.ContrasenaU = contrasena;
            U.NSSU = nss;
            U.IDR = Convert.ToInt32(rol);
            GV.SubmitChanges();                                    
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para activar a un usuario.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActivarUsuario(string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from s in GV.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
            US.EstatusU = 1;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " Activar Usuario");
            return 0;
        }
    }

    /// <summary>
    /// Función para dar de baja a un usuario.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int BajaUsuario(string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario U = (from s in GV.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
            U.EstatusU = 0;
            GV.SubmitChanges();
            return 1;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para dar de baja un rol.
    /// </summary>
    /// <param name="IDR"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int BajaRol(string IDR)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Rol R = (from s in GV.Rol where s.IDR == Convert.ToInt32(IDR) select s).SingleOrDefault();
            R.EstatusR = false;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar los cambios realizados en la unidad de negocio.
    /// </summary>
    /// <param name="IDUN"></param>
    /// <param name="Nombre"></param>
    /// <param name="Direccion"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActualizarUnidadNegocio(string IDUN, string Nombre, string Direccion)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Unidad UN = (from s in GV.Unidad where s.IDUN == Convert.ToInt32(IDUN) select s).SingleOrDefault();
            UN.NombreUN = Nombre;
            UN.DireccionUN = Direccion;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para activar una unidad de negocio.
    /// </summary>
    /// <param name="IDUN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActivarUnidadNegocio(string IDUN)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();

            Unidad UN = (from s in GV.Unidad where s.IDUN == Convert.ToInt32(IDUN) select s).SingleOrDefault();
            UN.EstatusUN = 1;
            GV.SubmitChanges();
            return 1;

        }
        catch (Exception e)
        {
            Log(e.Message + " Activar unidad Negocio");
            return 0;
        }
    }

    /// <summary>
    /// Función para dar de baja una Unidad de Negocio.
    /// </summary>
    /// <param name="IDUN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int BajaUnidadNegocio(string IDUN)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Unidad UN = (from s in GV.Unidad where s.IDUN == Convert.ToInt32(IDUN) select s).SingleOrDefault();
            UN.EstatusUN = 0;
            GV.SubmitChanges();
            return 1;
        }

        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar los datos del vehículo indicado.
    /// </summary>
    /// <param name="IDV"></param>
    /// <param name="marca"></param>
    /// <param name="modelo"></param>
    /// <param name="polizaseguro"></param>
    /// <param name="color"></param>
    /// <param name="placa"></param>
    /// <param name="capacidad"></param>
    /// <param name="noserie"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActualizarVehiculo(string IDV, string marca, string modelo, string polizaseguro, string color, string placa, string capacidad, string noserie)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo V = (from s in GV.Vehiculo where s.IDV == Convert.ToInt32(IDV) select s).SingleOrDefault();
            V.MarcaV = marca.ToUpper();
            V.ModeloV = modelo.ToUpper();
            V.PolizaSeguroV = polizaseguro.ToUpper();
            V.ColorV = color.ToUpper();
            V.PlacaV = placa.ToUpper();
            V.CapacidadV = Convert.ToInt32(capacidad);
            V.NumSerieV = noserie.ToUpper();
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para activar un vehículo.
    /// </summary>
    /// <param name="IDV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActivarVehiculo(string IDV)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo V = (from s in GV.Vehiculo where s.IDV == Convert.ToInt32(IDV) select s).SingleOrDefault();
            V.EstatusV = 1;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " Activar Vehículo");
            return 0;
        }
    }

    /// <summary>
    /// Función para dar de baja un vehiculo.
    /// </summary>
    /// <param name="IDV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int BajaVehiculo(string IDV) 
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo V = (from s in GV.Vehiculo where s.IDV == Convert.ToInt32(IDV) select s).SingleOrDefault();
            V.EstatusV = 0;
            GV.SubmitChanges();
            return 1;

        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    
    }

    /// <summary>
    /// Función para actualizar el registro de solicitud con los ajustes que se hayan hecho. 
    /// </summary>
    /// <param name="telefono"></param>
    /// <param name="motivo"></param>
    /// <param name="destino"></param>
    /// <param name="fechasalida"></param>
    /// <param name="horasalida"></param>
    /// <param name="fecharegreso"></param>
    /// <param name="horaregreso"></param>
    /// <param name="ruta"></param>
    /// <param name="observaciones"></param>
    /// <param name="chofer"></param>
    /// <param name="ids"></param>
    /// <param name="lugares"></param>
    /// <param name="otrodestino"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ActualizarSolicitud(string telefono, string motivo, string destino, string fechasalida, string horasalida, string fecharegreso, string horaregreso, string ruta, string observaciones, string chofer, string ids, string lugares, string otrodestino)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            TimeSpan HS = TimeSpan.Parse(horasalida);
            TimeSpan HR = TimeSpan.Parse(horaregreso);
            Solicitud S = (from s in GV.Solicitud where s.IDS == Convert.ToInt64(ids) select s).SingleOrDefault();
            S.MotivoS = motivo;
            S.DestinoS = Convert.ToInt32(destino);
            S.FechaSalidaS = Convert.ToDateTime(fechasalida);
            S.HoraSalidaS = HS;
            S.FechaRegresoS = Convert.ToDateTime(fecharegreso);
            S.HoraRegresoS = HR;
            S.ObservacionesS = observaciones;
            S.RequiereChoferS = Convert.ToBoolean(chofer);
            S.OtroDestinoS = otrodestino;
            S.LugaresDisponiblesS = lugares;
            S.EstatusS = 0;            

            Usuario U = (from t in GV.Usuario where t.IDU == S.IDU select t).SingleOrDefault();
            U.TelefonoU = telefono;            

            Ruta R = (from r in GV.Ruta where r.IDS == S.IDS select r).SingleOrDefault();
            R.DescripcionRT = ruta;            

            GV.SubmitChanges();
            return 1;


        }
        catch(Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar los datos de ls solicitud de escala.
    /// </summary>
    /// <param name="telefono"></param>
    /// <param name="IDE"></param>
    /// <param name="destino"></param>
    /// <param name="horaarribo"></param>
    /// <param name="motivo"></param>
    /// <param name="observaciones"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AcutalizarSolicitudEscala(string telefono, string IDE, string destino, string horaarribo, string motivo, string observaciones)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            TimeSpan HA = TimeSpan.Parse(horaarribo);
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            E.DestinoE = destino;
            E.HoraArriboE = HA;
            E.MotivoE = motivo;
            E.ObservacionesE = observaciones;
            E.EstatusE = 0;

            Usuario U = (from t in GV.Usuario where t.IDU == E.IDU select t).SingleOrDefault();
            U.TelefonoU = telefono;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }


    /// <summary>
    /// Función para insertar una escala en una solicitud existente.
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="IDS"></param>
    /// <param name="destino"></param>
    /// <param name="motivo"></param>
    /// <param name="horarribo"></param>
    /// <param name="observaciones"></param>
    /// <param name="telefono"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int InsertarEscala(string IDU, string IDS, string destino, string motivo, string horarribo, string observaciones, string telefono)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from s in GV.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
            US.TelefonoU = telefono;
            GV.SubmitChanges();
            Ruta R = (from t in GV.Ruta where t.IDS == Convert.ToInt32(IDS) select t).SingleOrDefault();

            int ValidaEscalasSinConcluir = ValidarSolicitudesEscalaSinConcluir(US.IDU);
            int ValidacionSolicitudesSinConcluir = ValidarSolicitudesSinConcluir(US.IDU.ToString());

            if(ValidaEscalasSinConcluir > 0){
                return 2; //Significa que tiene escalas pendientes de concluir
            }
            else if (ValidaEscalasSinConcluir == -1)
            {
                return 0; //Error en la función ValidarSolicitudesEscalaSinConcluir
            }
            if (ValidacionSolicitudesSinConcluir > 0)
            {
                return 2; //Significa que tiene solicitudes pendientes de concluir
            }
            else if (ValidacionSolicitudesSinConcluir == -1)
            {
                return 0; //Error en la función ValidarSolicitudesSinConcluir
            }


            DateTime FechaActual = DateTime.Now;
            TimeSpan HA = TimeSpan.Parse(horarribo);
            Escala Escala = new Escala { 
                IDU = US.IDU,
                IDRT = R.IDRT,
                DestinoE = destino,
                MotivoE = motivo,
                EstatusE = 0,
                FechaCreacionE = FechaActual,
                HoraArriboE = HA,
                ObservacionesE = observaciones
            };

            GV.Escala.InsertOnSubmit(Escala);
            GV.SubmitChanges();

            Solicitud Sol = (from w in GV.Solicitud where w.IDS == Convert.ToInt32(IDS) select w).SingleOrDefault();
            Sol.LugaresDisponiblesS = (Convert.ToInt32(Sol.LugaresDisponiblesS) - 1).ToString();
            GV.SubmitChanges();
            Correo CorreoNuevaEscala = new Correo();
            string correojefedirecto = ObtenerCorreoJefeDirecto(US.AreaU);
            string asunto = "Escala pendiente de autorización";
            string cuerpomensaje = "Hay una nueva escala pendiente de aprobación del solicitante: ";
            string nombresolicitante = US.NombreU;
            string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            CorreoNuevaEscala.EnviarCorreo(correojefedirecto, mensaje, asunto);                     
            return 1;
           
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }


    /// <summary>
    /// Función para llenar el select de estatus 
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerEstatus()
    {
        string respuesta = "<option value=" + -1 + ">Todas</option><option value=" + 0 + ">Pendientes de Autorización</option><option value=" + 1 + ">Autorizado</option>";
        return respuesta;
    }

    /// <summary>
    /// Función para crear tabla de solicitudes pendientes de aprobación por área dependiendo de la persona logueada.
    /// </summary>
    /// <param name="solicitente"></param>
    /// <param name="fechasalida"></param>
    /// <param name="fecharegreso"></param>
    /// <param name="estatus"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string TablaSolicitudesPendientesAprobacion(string solicitante, string fechasalida, string fecharegreso, string estatus, string usuariologueado)
    {
        try
        {
            string Tabla = "<h5>Solicitudes de Viaje</h5><table class='table table-responsive table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Ruta</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Mensaje del Sistema</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Requiere Chofer</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            ModelDataDataContext GV = new ModelDataDataContext();
            string area = ObtenerAreaUsuario(usuariologueado);
            List<ObtieneSolicitudPendienteAprobacion> SolPen = new List<ObtieneSolicitudPendienteAprobacion>();
            if (solicitante == "" && fechasalida == "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida == "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida != "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida != "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida == "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.NombreU.Contains(@solicitante) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.NombreU.Contains(@solicitante) && s.EstatusS == Convert.ToInt32(estatus) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida == "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.NombreU.Contains(@solicitante) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.NombreU.Contains(@solicitante) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida != "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.NombreU.Contains(@solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.NombreU.Contains(@solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida != "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.NombreU.Contains(@solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    SolPen = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area && s.EstatusS == Convert.ToInt32(estatus) && s.NombreU.Contains(@solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }

            if (SolPen.Count > 0)
            {
                foreach (ObtieneSolicitudPendienteAprobacion OSPA in SolPen)
                {
                    if (OSPA.EstatusS == 0)
                    {
                        Tabla += "<tr class='table-warning'><th scope='row'>S" + OSPA.IDS +"</th>";
                    }
                    else
                    {
                        Tabla += "<tr class='table-success'><th scope='row'>S" + OSPA.IDS + "</th>";
                    }                    
                    Tabla += "<td>" + OSPA.NombreU + "</td>";
                    Tabla += "<td>" + OSPA.FechaSalidaS.ToString("dd-MM-yyyy") + " " + OSPA.HoraSalidaS.ToString() + "</td>";
                    Tabla += "<td>" + OSPA.FechaRegresoS.ToString("dd-MM-yyyy") + " " + OSPA.HoraRegresoS.ToString() + "</td>";
                    Tabla += "<td>" + OSPA.DescripcionRT + "</td>";
                    if (OSPA.DestinoS == -1)
                    {
                        Tabla += "<td>" + OSPA.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        Tabla += "<td>" + OSPA.NombreUN + "</td>";
                    }
                    Tabla += "<td>" + OSPA.MotivoS + "</td>";
                    Tabla += "<td>" + OSPA.ObservacionesS + "</td>";
                    Tabla += "<td><p class='red-text'>" + OSPA.ObservacionesSistemaS + "</p></td>";
                    if (OSPA.EstatusS == 0)
                    {
                        Tabla += "<td class='text-center'>Pendiente de Autorización</td>";
                    }
                    else
                    {
                        Tabla += "<td class='text-center'>Autorizado</td>";
                    }
                    if (OSPA.RequiereChoferS == false)
                    {
                        Tabla += "<td class='text-center'>No</td>";
                    }
                    else
                    {
                        Tabla += "<td class='text-center'>Si</td>";
                    }

                    if (Convert.ToInt32(OSPA.EstatusS) == 1)
                    {
                        Tabla += "<td></td></tr>";
                    }
                    else
                    {
                        Tabla += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AprobarSolicitud(" + OSPA.IDS.ToString() + ")'><i class='fa fa-thumbs-o-up mr-2' aria-hidden='true'></i>Autorizar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarSolicitudPendiente(" + OSPA.IDS.ToString() + ")'><i class='fa fa-thumbs-o-down mr-2' aria-hidden='true'></i>Cancelar</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalAjustesSolicitudesPendientes(" + OSPA.IDS.ToString() + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Solicitar Ajustes</button></td></tr>";
                    }


                }

                Tabla += "</tbody></table>";
            }
            else
            {
                Tabla = "Sin solicitudes de viaje ";
            }

            return Tabla;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Crea la tabla de solicitudes de escala pendientes.
    /// </summary>
    /// <param name="solicitante"></param>
    /// <param name="fechasalida"></param>
    /// <param name="fecharegreso"></param>
    /// <param name="estatus"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaSolicitudesEscalasPendientesAprobacion(string solicitante, string fechasalida, string fecharegreso, string estatus, string usuariologueado)
    {
        try
        {
            string respuesta = "<h5>Solicitudes de Escalas</h5><table class='table table-responsive table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Hora Arribo Aprox.</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Ruta</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Nombre Responsable de la Solicitud</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            ModelDataDataContext GV = new ModelDataDataContext();
            string area = ObtenerAreaUsuario(usuariologueado);

            List<ObtenerSolicitudEscalaPendienteAprobacion> OSEPA = new List<ObtenerSolicitudEscalaPendienteAprobacion>();

            if (solicitante == "" && fechasalida == "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida == "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida != "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida != "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida == "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.NombreSolicitante.Contains(solicitante) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.NombreSolicitante.Contains(solicitante) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida == "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.NombreSolicitante.Contains(solicitante) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.NombreSolicitante.Contains(solicitante) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida != "" && fecharegreso == "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.NombreSolicitante.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.NombreSolicitante.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida != "" && fecharegreso != "")
            {
                if (Convert.ToInt32(estatus) == -1)
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.NombreSolicitante.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
                else
                {
                    OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAprobacion where s.AreaU == area && s.EstatusE == Convert.ToInt32(estatus) && s.NombreSolicitante.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) && s.FechaRegresoS == Convert.ToDateTime(fecharegreso) select s).ToList();
                }
            }

            if (OSEPA.Count > 0)
            {
                foreach(ObtenerSolicitudEscalaPendienteAprobacion d in OSEPA){
                    if (d.EstatusE == 0)
                    {
                        respuesta += "<tr class='table-warning'><th scope='row'>E" + d.IDE + "</th>";
                    }
                    else
                    {
                        respuesta += "<tr class='table-success'><th scope='row'>E" + d.IDE + "</th>";
                    }
                    
                    respuesta += "<td>"+d.NombreSolicitante+"</td>";
                    respuesta += "<td>" + d.DestinoE + "</td>";
                    respuesta += "<td>" + d.HoraArriboE.ToString() + "</td>";
                    respuesta += "<td>" + d.MotivoE + "</td>";
                    respuesta += "<td>" + d.ObservacionesE + "</td>";
                    respuesta += "<td>" + d.DescripcionRT + "</td>";
                    respuesta += "<td>" + d.FechaSalidaS.ToString("dd-MM-yyyy") + " " + d.HoraSalidaS.ToString() + "</td>";
                    respuesta += "<td>" + d.FechaRegresoS.ToString("dd-MM-yyyy") + " " + d.HoraRegresoS.ToString() + "</td>";
                    respuesta += "<td>" + d.NombreSolicitud +"</td>";                    

                    if (Convert.ToInt32(d.EstatusE) == 1)
                    {
                        respuesta += "<td>Autorizado</td></tr>";
                    }
                    else
                    {
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AprobarSolicitudEscala(" + d.IDE.ToString() + ")'><i class='fa fa-thumbs-o-up mr-2' aria-hidden='true'></i>Autorizar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalModalCancelarSolicitudEscalaPendiente(" + d.IDS.ToString() + ", " + d.IDE.ToString() + ")'><i class='fa fa-thumbs-o-down mr-2' aria-hidden='true'></i>Cancelar</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalAjustesSolicitudesEscalasPendientes(" + d.IDS.ToString() + ", " + d.IDE.ToString() + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Solicitar Ajustes</button></td></tr>";
                    }
                }
                respuesta += "</tbody></table>";
            }
            else
            {
                respuesta = "Sin solicitudes de escala";
            }
            
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }


    /// <summary>
    /// Función para crear la tabla de solicitudes pendientes de asiganción
    /// </summary>
    /// <param name="solicitante"></param>
    /// <param name="fechasalida"></param>
    /// <param name="area"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string CrearTablaSolicitudesPendientesAsignacion(string solicitante, string fechasalida, string area, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudPendienteAsignacion> PenAsig = new List<ObtenerSolicitudPendienteAsignacion>();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Fecha Creación</th><th class='text-center color-fuente-strong'>Salida</th><th class='text-center color-fuente-strong'>Regreso</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Requiere Chofer</th><th class='text-center color-fuente-strong'>Ruta</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Área</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Mensaje del Sistema</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";            
            if (solicitante != "" && fechasalida != "")
            {
                if (area == "TODAS")
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.NombreU.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
                else
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.AreaU == area && s.NombreU.Contains(solicitante) && s.FechaSalidaS == Convert.ToDateTime(fechasalida) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida != "")
            {
                if (area == "TODAS")
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.FechaSalidaS == Convert.ToDateTime(fechasalida) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
                else
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.AreaU == area && s.FechaSalidaS == Convert.ToDateTime(fechasalida) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
            }
            if (solicitante != "" && fechasalida == "")
            {
                if (area == "TODAS")
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.NombreU.Contains(solicitante) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
                else
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.AreaU == area && s.NombreU.Contains(solicitante) orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
            }
            if (solicitante == "" && fechasalida == "")
            {
                if (area == "TODAS")
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
                else
                {
                    PenAsig = (from s in GV.ObtenerSolicitudPendienteAsignacion where s.AreaU == area orderby s.EstatusS, s.FechaAutorizaciónS ascending select s).ToList();
                }
            }

            // Verificar el Rol de usuario si es supervisor no se va a mostrar ningun boton de acción
            
            string rol = ObtenerRol(usuariologueado);
            
            

            foreach (ObtenerSolicitudPendienteAsignacion D in PenAsig)
            {
                int TieneEscalas = ValidaExistenEscalasSolicitud(D.IDS.ToString());
                if (D.EstatusS == 4)
                {
                    if(TieneEscalas > 0){
                        respuesta += "<tr class='table-morado'><th scope='row'>S" + D.IDS + "</th>";
                    }
                    else
                    {
                        respuesta += "<tr class='table-success'><th scope='row'>S" + D.IDS + "</th>";
                    }                    
                }else
                {
                    respuesta += "<tr class='table-warning'><th scope='row'>S" + D.IDS + "</th>";
                }
                
                respuesta += "<td>" + D.NombreU + "</td>";
                respuesta += "<td>" + D.FechaCrecionS.ToString() + "</td>";
                respuesta += "<td>" + D.FechaSalidaS.ToString("dd-MM-yyyy") + " " + D.HoraSalidaS.ToString() + "</td>";
                respuesta += "<td>" + D.FechaRegresoS.ToString("dd-MM-yyyy") + " " + D.HoraRegresoS.ToString() + "</td>";                
                if (D.NombreUN == null || D.NombreUN == "")
                {
                    respuesta += "<td>" + D.OtroDestinoS + "</td>";
                }
                else
                {
                    respuesta += "<td>" + D.NombreUN + "</td>";
                }                
                if (D.RequiereChoferS == false)
                {
                    respuesta += "<td>No</td>";
                }
                else
                {
                    respuesta += "<td>Si</td>";
                }
                respuesta += "<td>" + D.DescripcionRT + "</td>";
                if (D.EstatusS == 1)
                {
                    respuesta += "<td>Autorizado</td>";
                }
                else if (D.EstatusS == 4)
                {
                    respuesta += "<td>Asignado</td>";
                }
                respuesta += "<td>" + D.AreaU + "</td>";
                respuesta += "<td>" + D.MotivoS + "</td>";
                respuesta += "<td>" + D.ObservacionesS + "</td>";
                respuesta += "<td><p class='red-text'>" + D.ObservacionesSistemaS + "</p></td>";
                if(rol != "Supervisor")
                {
                    if (D.EstatusS == 1)
                    {
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalAsignarVehículo(" + D.IDS + ")'><i class='fa fa-thumbs-o-up mr-2' aria-hidden='true'></i>Asignar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirAVModalCancelarSolicitud(" + D.IDS + ")'><i class='fa fa-thumbs-o-down mr-2' aria-hidden='true'></i>Cancelar</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirAVModalSolicitarAjustes(" + D.IDS + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Solicitar Ajustes</button>";
                    }
                    else
                    {
                        respuesta += "<td><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirAVModalCancelarSolicitud(" + D.IDS + ")'><i class='fa fa-thumbs-o-down mr-2' aria-hidden='true'></i>Cancelar</button>";
                    }

                    if (D.EstatusS == 4)
                    {
                        if(TieneEscalas > 0){
                            respuesta += "<button type='button' class='btn btn-outline-secondary waves-effect btn-sm' onclick='AbrirModalAVAprobarEscalas(" + D.IDS + ", " + D.LugaresDisponiblesS + ")'><i class='fa fa-road mr-2' aria-hidden='true'></i>Ver Escalas Solicitadas</button></td></tr>";
                        }                    
                    }
                    else
                    {   
                        respuesta += "</td></tr>";
                    }   
                }
                else
                {
                    respuesta += "<td></td></tr>";
                }

            }
            respuesta += "</tbody></table>";

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener la tabla de solicitudes de escalas correspondientes a una solicitud
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="lugaresd"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string CrearTablaEscalasSolicitadasPendientesAprobacion(string IDS, string lugaresd)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudEscalaPendienteAsignacion> OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAsignacion where s.IDS == Convert.ToInt32(IDS) select s).ToList();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Área</th><th class='text-center color-fuente-strong'>Puesto</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Hora Arribo Aprox</th><th class='text-center color-fuente-strong'>Fecha Creación</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";

            if (OSEPA.Count > 0)
            {
                foreach (ObtenerSolicitudEscalaPendienteAsignacion D in OSEPA)
                {

                    respuesta += "<tr class='table-warning'><th scope='row'>" + D.NombreU + "</th>";
                    respuesta += "<td>" + D.AreaU + "</td>";
                    respuesta += "<td>" + D.PuestoU + "</td>";
                    respuesta += "<td>" + D.MotivoE + "</td>";
                    respuesta += "<td>" + D.DestinoE + "</td>";
                    respuesta += "<td>" + D.HoraArriboE.ToString() + "</td>";
                    respuesta += "<td>" + D.FechaCreacionE.ToString() + "</td>";
                    respuesta += "<td>" + D.ObservacionesE + "</td>";
                    respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AsignarEscalaAdministrador(" + D.IDE + ")'><i class='fa fa-thumbs-o-up mr-2' aria-hidden='true'></i>Asignar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirAVModalCancelarEscala(" + D.IDS + ", " + D.IDE + ")'><i class='fa fa-thumbs-o-down mr-2' aria-hidden='true'></i>Cancelar</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirAVModalSolicitarAjustesEscala(" + D.IDS + ", " + D.IDE + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Solicitar Ajustes</button></td></tr>";
                }
            }

            respuesta += "</tbody></table>";
           
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }


    /// <summary>
    /// Función para crear la tabla de solicitudes asignadas
    /// </summary>
    /// <param name="FechaIn"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string CrearTablaDisponibilidadV(string FechaIn, string FechaFin, string usuariologueado)    
    {
        
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Modelo</th><th class='text-center color-fuente-strong'>Color</th><th class='text-center color-fuente-strong'>Placas</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Ruta</th><th class='text-center color-fuente-strong'>Chofer</th><th class='text-center color-fuente-strong'>Lugares Disponibles</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            List<ObtenerSolicitudAsignada> OSA = new List<ObtenerSolicitudAsignada>();
            DateTime FechaActual = DateTime.Now;

            if (FechaIn != "" && FechaFin != "")
            {
                OSA = (from s in GV.ObtenerSolicitudAsignada where s.IDU != UL.IDU && s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIn) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
                       
            }            
            if(FechaIn == "" && FechaFin == "")
            {
                OSA = (from s in GV.ObtenerSolicitudAsignada where s.IDU != UL.IDU select s).ToList();
            }

            if(OSA.Count > 0)
            {
                foreach(ObtenerSolicitudAsignada d in OSA)
                {
                    respuesta += "<tr><th scope='row'>S"+d.IDS+"</th>";
                    respuesta += "<td>"+d.ModeloV+"</td>";
                    respuesta += "<td>" + d.ColorV + "</td>";
                    respuesta += "<td>" + d.PlacaV + "</td>";
                    respuesta += "<td>" + d.FechaSalidaS.ToString("dd - MM - yyyy") + " " + d.HoraSalidaS.ToString() + "</td>";
                    respuesta += "<td>" + d.FechaRegresoS.ToString("dd - MM - yyyy") + " " + d.HoraRegresoS.ToString() + "</td>";
                    respuesta += "<td>" + d.DescripcionRT + "</td>";
                    if (d.RequiereChoferS == false)
                    {
                        respuesta += "<td>No</td>";
                    }
                    else
                    {
                        respuesta += "<td>Si</td>";
                    }
                    respuesta += "<td>"+d.LugaresDisponiblesS+"</td>";
                    if (d.FechaSalidaS >= FechaActual)
                    {
                        if (Convert.ToInt32(d.LugaresDisponiblesS) > 0)
                        {
                            respuesta += "<td><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalAgregarEscala(" + d.IDS + ")'><i class='fa fa-flag mr-2' aria-hidden='true'></i>Solicitar Escala</button></td></tr>";
                        }
                        else
                        {
                            respuesta += "<td><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalErrorEscala()'><i class='fa fa-remove mr-2' aria-hidden='true'></i>No Disponible</button></td></tr>";
                        }
                    }
                    else
                    {
                        respuesta += "<td></td></tr>";
                    }                                                         
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
            
        }

        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de solicitudes pendientes de ajustes.
    /// </summary>
    /// <param name="FechaSalida"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaTablaAjusteSolicitud(string FechaSalida, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario U = (from s in GV.Usuario where s.NombreUsuarioU == usuariologueado select s).SingleOrDefault();
            List<ObtenerSolicitudesPendienteAjustes> OSPA = new List<ObtenerSolicitudesPendienteAjustes>();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";

            if (FechaSalida != "")
            {
                OSPA = (from s in GV.ObtenerSolicitudesPendienteAjustes where s.FechaSalidaS == Convert.ToDateTime(FechaSalida) && s.IDU == U.IDU select s).ToList();
            }
            else
            {
                OSPA = (from s in GV.ObtenerSolicitudesPendienteAjustes where s.IDU == U.IDU select s).ToList();
            }

            if (OSPA.Count > 0)
            {
                foreach(ObtenerSolicitudesPendienteAjustes D in OSPA){
                    respuesta += "<tr class='table-info'><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>" + D.FechaSalidaS.ToString("dd - MM - yyyy") + " " + D.HoraSalidaS.ToString() + "</td>";
                    respuesta += "<td>" + D.FechaRegresoS.ToString("dd - MM - yyyy") + " " + D.HoraRegresoS.ToString() + "</td>";

                    if (D.DestinoS == -1)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }
                    respuesta += "<td>Requiere Ajustes</td>";
                    respuesta += "<td><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalAjustarSolicitud("+D.IDS+")'><i class='fa fa-gear mr-2' aria-hidden='true'></i>Realizar Ajustes</button></td></tr>";                    
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;

        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de escalas pendientes de ajustes.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaAjusteEscala(string solicitud, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario U = (from s in GV.Usuario where s.NombreUsuarioU == usuariologueado select s).SingleOrDefault();
            List<ObtenerSolicitudesEscalaPendienteAjustes> OSEPA = new List<ObtenerSolicitudesEscalaPendienteAjustes>();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";

            if (solicitud != "")
            {
                OSEPA = (from t in GV.ObtenerSolicitudesEscalaPendienteAjustes where t.IDU == U.IDU && t.IDS == Convert.ToInt64(solicitud) select t).ToList();
            }
            else
            {
                OSEPA = (from t in GV.ObtenerSolicitudesEscalaPendienteAjustes where t.IDU == U.IDU select t).ToList();
            }

            if (OSEPA.Count > 0)
            {
                foreach (ObtenerSolicitudesEscalaPendienteAjustes D in OSEPA)
                {
                    respuesta += "<tr class='table-info'><th scope='row'>E" + D.IDE + "</th>";
                    respuesta += "<td>" + D.DestinoE + "</td>";
                    respuesta += "<td>" + D.MotivoE + "</td>";
                    respuesta += "<td>Requiere Ajustes</td>";
                    respuesta += "<td><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalAjustarEscala(" + D.IDS + "," + D.IDE + ")'><i class='fa fa-gear mr-2' aria-hidden='true'></i>Realizar Ajustes</button></td></tr>'";
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de seguimiento de solicitud.
    /// </summary>
    /// <param name="fechasalida"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaSeguimientoSolicitud(string fechasalida, string usuariologueado)
    {
        try
        {
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Requiere Chofer</th><th class='text-center color-fuente-strong'>Motivo Cancelación</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario U = (from s in GV.Usuario where s.NombreUsuarioU == usuariologueado select s).SingleOrDefault();
            List<ObtenerSeguimientoSolicitud> OSS = new List<ObtenerSeguimientoSolicitud>();

            if (fechasalida != "")
            {
                OSS = (from t in GV.ObtenerSeguimientoSolicitud where t.IDU == U.IDU && t.FechaSalidaS == Convert.ToDateTime(fechasalida) select t).ToList();
            }
            else
            {
                OSS = (from t in GV.ObtenerSeguimientoSolicitud where t.IDU == U.IDU select t).ToList();
            }

            if (OSS.Count > 0)
            {
                foreach (ObtenerSeguimientoSolicitud D in OSS)
                {
                    switch(D.EstatusS)
                    {
                        case 0:
                            respuesta += "<tr class='table-warning'><th scope='row'>S" + D.IDS + "</th>";
                            break;
                        case 3:
                            respuesta += "<tr class='table-danger'><th scope='row'>S" + D.IDS + "</th>";
                            break;
                        case 4:
                            respuesta += "<tr class='table-success'><th scope='row'>S" + D.IDS + "</th>";
                            break;
                        default:
                            respuesta += "<tr><th scope='row'>" + D.IDS + "S</th>";
                            break;
                    }                    
                    respuesta += "<td>" + D.FechaSalidaS.ToString("dd - MM - yyyy") + " " + D.HoraSalidaS.ToString() + "</td>";
                    respuesta += "<td>" + D.FechaRegresoS.ToString("dd - MM - yyyy") + " " + D.HoraRegresoS.ToString() + "</td>";
                    if (D.DestinoS == -1)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }

                    if (D.EstatusS == 0)
                    {
                        respuesta += "<td>Pendiente de Autorización</td>";                        
                        if (D.RequiereChoferS == true)
                        {
                            respuesta += "<td>Si</td>";
                        }
                        else
                        {
                            respuesta += "<td>No</td>";
                        }
                        respuesta += "<td></td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoSolicitud("+D.IDS+")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarSolicitud("+D.IDS+")'><i class='fa fa-window-close-o mr-2' aria-hidden='true'></i>Cancelar</button></td></tr>";
                    }
                    else if (D.EstatusS == 4)
                    {
                        respuesta += "<td>Asignada</td>";                        
                        if (D.RequiereChoferS == true)
                        {
                            respuesta += "<td>Si</td>";
                        }
                        else
                        {
                            respuesta += "<td>No</td>";
                        }
                        respuesta += "<td></td>";
                        if (D.KilometrajeS_V > 0)
                        {
                            respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoSolicitud(" + D.IDS + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalConcluirSolicitud(" + D.IDS + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Concluir</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarSolicitudSolicitante(" + D.IDS + ")'><i class='fa fa-close mr-2' aria-hidden='true'></i>Cancelar</button></td></tr>";
                        }
                        else
                        {
                            if(D.RequiereChoferS == true)
                            {
                                respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoSolicitud(" + D.IDS + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarSolicitudSolicitante(" + D.IDS + ")'><i class='fa fa-close mr-2' aria-hidden='true'></i>Cancelar</button></td></tr>";
                            }else
                            {
                                respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoSolicitud(" + D.IDS + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalObservacionesVehiculo(" + D.IDS + ", " + D.IDS_V + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Condiciones Iniciales</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarSolicitudSolicitante(" + D.IDS + ")'><i class='fa fa-close mr-2' aria-hidden='true'></i>Cancelar</button></td></tr>";
                            }                            
                        }                        
                    }
                    else
                    {
                        respuesta += "<td>Cancelada</td>";                        
                        if (D.RequiereChoferS == true)
                        {
                            respuesta += "<td>Si</td>";
                        }
                        else
                        {
                            respuesta += "<td>No</td>";
                        }
                        respuesta += "<td>" + D.MotivoCancelacionAjusteS + "</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='ArchivarSolicitudCancelada(" + D.IDS + ")'><i class='fa fa-bookmark mr-2' aria-hidden='true'></i>Archivar</button></td></td>";
                    }                    

                }
                respuesta += "</tbody></table>";
            }

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de seguimiento de escala.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaSeguimientoEscala(string IDS, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Motivo Cancelación</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            List<ObtenerSeguimientoSolicitudEscala> OSSE = new List<ObtenerSeguimientoSolicitudEscala>();
            Usuario U = (from t in GV.Usuario where t.NombreUsuarioU == usuariologueado select t).SingleOrDefault();

            if (IDS != "")
            {
                OSSE = (from s in GV.ObtenerSeguimientoSolicitudEscala where s.IDU == U.IDU && s.IDS == Convert.ToInt32(IDS) orderby s.FechaCreacionE descending select s).ToList();
            }
            else
            {
                OSSE = (from s in GV.ObtenerSeguimientoSolicitudEscala where s.IDU == U.IDU orderby s.FechaCreacionE descending select s).ToList();
            }

            if (OSSE.Count > 0)
            {
                foreach (ObtenerSeguimientoSolicitudEscala D in OSSE)
                {
                    
                    switch(D.EstatusE)
                    {
                        case 0:
                            respuesta += "<tr class='table-warning'><th scope='row'>E" + D.IDE + "</th>";
                            break;
                        case 3:
                            respuesta += "<tr class='table-danger'><th scope='row'>E" + D.IDE + "</th>";
                            break;
                        case 4:
                            respuesta += "<tr class='table-success'><th scope='row'>E" + D.IDE + "</th>";
                            break;
                        default:
                            respuesta += "<tr><th scope='row'>" + D.IDE + "E</th>";
                            break;
                    }

                    
                    respuesta += "<td>" + D.DestinoE + "</td>";
                    respuesta += "<td>" + D.MotivoE + "</td>";
                    if (D.EstatusE == 0)
                    {
                        respuesta += "<td>Pendiente de Autorización</td>";
                        respuesta += "<td></td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoEscala("+D.IDS+","+D.IDE+")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalCancelarEscala("+D.IDS+","+D.IDE+")'><i class='fa fa-window-close-o mr-2' aria-hidden='true'></i>Cancelar</button></td></tr>";
                    }
                    else if (D.EstatusE == 4)
                    {
                        respuesta += "<td>Asignada</td>";
                        respuesta += "<td></td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalDetalleSeguimientoEscala(" + D.IDS + "," + D.IDE + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Detalle</button><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalConcluirEscala(" + D.IDS + "," + D.IDE + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Concluir</button></td></tr>";
                    }
                    else if (D.EstatusE == 3)
                    {
                        respuesta += "<td>Cancelada</td>";
                        respuesta += "<td>" + D.MotivoCancelacionAjusteE + "</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='ArchivarEscalaCancelada(" + D.IDS + "," + D.IDE + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Archivar</button></td></tr>";
                    }
                }
            }

            respuesta += "</tbody></table>";

            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }


    /// <summary>
    /// Función para crear la tabla de consulta de vehículos asignados.
    /// </summary>
    /// <param name="chofer"></param>
    /// <param name="fechainicial"></param>
    /// <param name="fechafinal"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaConsultaVehiculosAsignados(string chofer, string fechainicial, string fechafinal, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Solicitante</th><th class='text-center color-fuente-strong'>Modelo</th><th class='text-center color-fuente-strong'>Color</th><th class='text-center color-fuente-strong'>Placas</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Regreso</th><th class='text-center color-fuente-strong'>Ruta</th><th class='text-center color-fuente-strong'>Chofer</th><th class='text-center color-fuente-strong'>Lugares Disponibles</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            Usuario UL = (from ul in GV.Usuario where ul.NombreUsuarioU == usuariologueado select ul).SingleOrDefault();
            List<ObtenerVehiculosAsignados> OVA = new List<ObtenerVehiculosAsignados>();

            if(chofer != "" && fechainicial != ""){

                OVA = (from s in GV.ObtenerVehiculosAsignados where s.Chofer.Contains(chofer) && s.FechaSalidaS.Date >= Convert.ToDateTime(fechainicial) && s.FechaSalidaS.Date <= Convert.ToDateTime(fechafinal) select s).ToList();
            }
            if (chofer == "" && fechainicial != "")
            {
                OVA = (from s in GV.ObtenerVehiculosAsignados where s.FechaSalidaS.Date >= Convert.ToDateTime(fechainicial) && s.FechaSalidaS.Date <= Convert.ToDateTime(fechafinal) select s).ToList();                
            }
            if (chofer != "" && fechainicial == "")
            {
                OVA = (from s in GV.ObtenerVehiculosAsignados where s.Chofer.Contains(chofer) select s).ToList();
            }
            if (chofer == "" && fechainicial == "")
            {
                OVA = (from s in GV.ObtenerVehiculosAsignados select s).ToList();
            }

            if (OVA.Count > 0)
            {
                foreach(ObtenerVehiculosAsignados D in OVA){
                    respuesta += "<tr class='table-info'><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>"+D.NombreU+"</td>";
                    respuesta += "<td>" + D.ModeloV + "</td>";
                    respuesta += "<td>" + D.ColorV + "</td>";
                    respuesta += "<td>" + D.PlacaV + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToString("dd - MM - yyyy") + " " + D.HoraSalidaS.ToString() + "</td>";
                    respuesta += "<td>" + D.FechaRegresoS.ToString("dd - MM - yyyy") + " " + D.HoraRegresoS.ToString() + "</td>";
                    respuesta += "<td>" + D.DescripcionRT + "</td>";
                    if (D.Chofer != null && D.Chofer != "")
                    {
                        respuesta += "<td>" + D.Chofer + "</td>";
                        respuesta += "<td>" + D.LugaresDisponiblesS + "</td>";
                        List<ObtenerEscalasAsignadas> OEA = (from s in GV.ObtenerEscalasAsignadas where s.IDS == D.IDS select s).ToList();
                        if (Convert.ToInt32(D.LugaresDisponiblesS) < 2 && OEA.Count > 0)
                        {
                            if(D.Chofer == UL.NombreU)
                            {   
                                if(D.KilometrajeS_V > 0)
                                {
                                    respuesta += "<td></tr>";                                    
                                }else{
                                    respuesta += "<td><button type='button' class='btn btn-outline-secondary   waves-effect btn-sm' onclick='AbrirModalAcompanante(" + D.IDS + ")'><i class='fa fa-list-alt mr-2' aria-hidden='true'></i>Con Escala</button><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalObservacionesVehiculoVA(" + D.IDS + ", " + D.IDS_V + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Condiciones Iniciales</button></td></tr>";
                                }                                
                            }else
                            {
                                respuesta += "<td></tr>";
                            }                            
                        }
                        else
                        {
                            if(D.Chofer == UL.NombreU)
                            {
                                if (D.KilometrajeS_V > 0)
                                {
                                    respuesta += "<td></tr>";
                                }
                                else
                                {
                                    respuesta += "<td><button type='button' class='btn btn-outline-info waves-effect btn-sm' onclick='AbrirModalObservacionesVehiculoVA(" + D.IDS + ", " + D.IDS_V + ")'><i class='fa fa-calendar-check-o mr-2' aria-hidden='true'></i>Condiciones Iniciales</button></td></tr>";
                                }                                
                            }
                            else
                            {
                                respuesta += "<td></tr>";
                            }                            
                        }
                        
                    }
                    else
                    {
                        respuesta += "<td>No requiere chofer.</td>";
                        respuesta += "<td>" + D.LugaresDisponiblesS + "</td>";
                        respuesta += "<td></td></tr>";
                    }                    
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }


    /// <summary>
    /// Función para obtener el detalle de los vehículos asignados
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaDetalleVehiculoAsignado(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerEscalasAsignadas> OEA = (from s in GV.ObtenerEscalasAsignadas where s.IDS == Convert.ToInt32(IDS) select s).ToList();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Solicitante</th><th class='text-center color-fuente-strong'>Destino</th></tr></thead><tbody>";

            if(OEA.Count > 0)
            {
                foreach (ObtenerEscalasAsignadas D in OEA)
                {
                    respuesta += "<tr class='table-info'><th scope='row'>" + D.NombreU + "</th>";
                    respuesta += "<td>"+ D.DestinoE + "</td></tr>";
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de concentrado de usuarios.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaConcentradoUsuarios(string nombre, string area)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Usuario> US = new List<Usuario>();
            if (nombre != "")
            {
                if (area == "TODAS")
                {
                    US = (from s in GV.Usuario where s.NombreU.Contains(nombre) orderby s.NombreU ascending select s).ToList();
                }
                else
                {
                    US = (from s in GV.Usuario where s.NombreU.Contains(nombre) && s.AreaU.Contains(area) orderby s.NombreU ascending select s).ToList();
                }
            }
            else
            {
                if (area == "TODAS")
                {
                    US = (from s in GV.Usuario orderby s.NombreU ascending select s).ToList();
                }
                else
                {
                    US = (from s in GV.Usuario where s.AreaU.Contains(area) orderby s.NombreU ascending select s).ToList();
                }
            }
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre</th><th class='text-center color-fuente-strong'>Área</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";

            if (US.Count > 0)
            {
                foreach (Usuario U in US)
                {
                    respuesta += "<tr><th scope='row'>"+U.IDU+"</th>";
                    respuesta += "<td>" + U.NombreU + "</td>";
                    respuesta += "<td>" + U.AreaU + "</td>";
                    if (U.EstatusU == 0)
                    {
                        respuesta += "<td>Baja</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalActivarUsuario(" + U.IDU + ")'><i class='fa fa-user mr-2' aria-hidden='true'></i>Activar</button></td>";
                    }
                    else
                    {
                        respuesta += "<td>Activo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalModificarUsuario(" + U.IDU + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Modificar</button></td>";
                    }
                                        
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de concentrado de roles.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaConcentradoRoles()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Rol> R = (from s in GV.Rol select s).ToList();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre</th><th class='text-center color-fuente-strong'>Descripción</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";

            if (R.Count > 0)
            {
                foreach (Rol D in R)
                {
                    respuesta += "<tr><th scope='row'>" + D.IDR + "</th>";
                    respuesta += "<td>" + D.NombreR + "</td>";
                    respuesta += "<td>" + D.DescripcionR + "</td>";
                    if(D.EstatusR == false)
                    {
                        respuesta += "<td>Baja</td>";
                    }else
                    {
                        respuesta += "<td>Activo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalConfirmarBajaRol(" + D.IDR + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Desactivar</button></td>";
                    }                    
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de concentrado de unidades de negocio.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaUnidadesNegocio()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Unidad> UN = (from s in GV.Unidad select s).ToList();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre</th><th class='text-center color-fuente-strong'>Dirección</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            if (UN.Count > 0)
            {
                foreach (Unidad D in UN)
                {
                    respuesta += "<tr><th scope='row'>" + D.IDUN + "</th>";
                    respuesta += "<td>" + D.NombreUN + "</td>";
                    respuesta += "<td>" + D.DireccionUN + "</td>";
                    if (D.EstatusUN == 1)
                    {
                        respuesta += "<td>Activo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalModificarUnidad("+D.IDUN+")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Modificar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalConfirmacionBajaUnidad("+D.IDUN+")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Baja</button></td>";
                    }
                    else
                    {
                        respuesta += "<td>Baja</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success  waves-effect btn-sm' onclick='AbrirModalConfirmacionActivarUnidad(" + D.IDUN + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Activar</button></td>";
                    }                    
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return "Error";
        }
        
    }

    /// <summary>
    /// Función para crear la tabla de concentrado de vehículos.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaConcentradoVehiculo()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Marca</th><th class='text-center color-fuente-strong'>Modelo</th><th class='text-center color-fuente-strong'>Color</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Acciones</th></tr></thead><tbody>";
            List<Vehiculo> V = (from s in GV.Vehiculo select s).ToList();

            if (V.Count > 0)
            {
                foreach (Vehiculo D in V)
                {
                    respuesta += "<tr><th scope='row'>" + D.IDV + "</th>";
                    respuesta += "<td>" + D.MarcaV + "</td>";
                    respuesta += "<td>" + D.ModeloV + "</td>";
                    respuesta += "<td>" + D.ColorV + "</td>";

                    if (D.EstatusV == 0)
                    {
                        respuesta += "<td>Baja</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-success waves-effect btn-sm' onclick='AbrirModalConfirmarActivarVehiculo(" + D.IDV + ")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Activar</button></td>";
                    }
                    else
                    {
                        respuesta += "<td>Activo</td>";
                        respuesta += "<td><button type='button' class='btn btn-outline-warning waves-effect btn-sm' onclick='AbrirModalModificarVehiculo("+D.IDV+")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Modificar</button><button type='button' class='btn btn-outline-danger waves-effect btn-sm' onclick='AbrirModalConfirmarBajaVehiculo("+D.IDV+")'><i class='fa fa-cog mr-2' aria-hidden='true'></i>Baja</button></td>";
                    }
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }

        catch (Exception e)
        {
            Log(e.Message);
            return "Error";
        }
    }

    /// <summary>
    /// Función para aprobar la solicitud.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AprobarSolicitud(string solicitud)
    {
        ModelDataDataContext GV = new ModelDataDataContext();
        try
        {
            Solicitud Sol = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(solicitud) select s).SingleOrDefault();
            Sol.EstatusS = 1;
            Sol.FechaAutorizaciónS = DateTime.Now;
            Usuario US = (from x in GV.Usuario where x.IDU == Sol.IDU select x).SingleOrDefault();
            GV.SubmitChanges();
            Correo CorreoAprobarSolicitud = new Correo();
            Array correoadministrador = ObtenerCorreoAdministrador();
            string asunto = "Solicitud pendiente de asignación";
            string cuerpomensaje = "Hay una nueva solicitud pendiente de asignación del solicitante: ";
            string nombresolicitante = US.NombreU;
            string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            foreach(string D in correoadministrador)
            {
                CorreoAprobarSolicitud.EnviarCorreo(D, mensaje, asunto);  
            }            
            return 1;
        }

        catch(Exception e)
        {
            Log(e.Message + " Aprobar Solicitud");
            return 0;
        }
    }

    /// <summary>
    /// Función para aprobar la solicitud de escala.
    /// </summary>
    /// <param name="IDE"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AprobarSolicitudEscala(string IDE)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            Usuario US = (from x in GV.Usuario where x.IDU == E.IDU select x).SingleOrDefault();
            E.EstatusE = 1;
            GV.SubmitChanges();
            Correo CorreoAprobarEscala = new Correo();
            Array correoadministrador = ObtenerCorreoAdministrador();            
            string asunto = "Escala pendiente de asignación";
            string cuerpomensaje = "Hay una nueva escala pendiente de asignación del solicitante: ";
            string nombresolicitante = US.NombreU;
            string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            foreach(string D in correoadministrador)
            {
                CorreoAprobarEscala.EnviarCorreo(D, mensaje, asunto);  
            }
            Ruta R = (from r in GV.Ruta where r.IDRT == E.IDRT select r).SingleOrDefault();
            Solicitud S = (from j in GV.Solicitud where j.IDS == R.IDS select j).SingleOrDefault();
            Usuario Solicitante = (from sol in GV.Usuario where sol.IDU == S.IDU select sol).SingleOrDefault();
            string correosolicitante = Solicitante.CorreoElectronicoU;
            Correo NotificaSolicitante = new Correo();
            string asuntoNS = "Escala autorizada para su viaje";
            string cuerpomensajeNS = "La solicitud de viaje del día " + S.FechaSalidaS.ToShortDateString() +" ha recibido una escala en " + E.DestinoE +" de existir algun inconveniente por favor notifiquelo al administrador de la aplicación la solicitud de escala pertenece al usuario: ";            
            string mensajeNS = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asuntoNS + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asuntoNS + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensajeNS + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            NotificaSolicitante.EnviarCorreo(correosolicitante, mensajeNS, asuntoNS);
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para Cancelar una solicitud.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <param name="motivoc"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int CancelarSolicitud(string solicitud, string motivoc)
    {
        ModelDataDataContext GV = new ModelDataDataContext();
        try
        {
            Solicitud Sol = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(solicitud) select s).SingleOrDefault();
            Usuario U = (from n in GV.Usuario where n.IDU == Sol.IDU select n).SingleOrDefault();
            if (Sol.EstatusS == 4)
            {
                Correo CorreoSolicitudAsignadaCancelada = new Correo();
                string asunto = "Solicitud Asignada cancelada por solicitante";
                string cuerpomensaje = "Le informamos que la solicitud: S" + Sol.IDS + " ha sido cancelada por el solicitente: ";
                string nombresolicitante = U.NombreU ;
                string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
                var Administradores = ObtenerCorreoAdministrador();
                foreach(string D in Administradores)
                {
                    CorreoSolicitudAsignadaCancelada.EnviarCorreo(D, mensaje, asunto);
                }

                asunto = "Solicitud cancelada";
                cuerpomensaje = "Lamentamos informarle que la solicitud: S" + Sol.IDS + " ha sido cancelada por el solicitante por lo cual la escala que usted solicito igualmente ha sido cancelada por el solicitante: ";
                mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<strong>" + nombresolicitante + "</strong><br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
                var Escalas = ObtenerCorreoEscalas(Convert.ToInt32(Sol.IDS));

                foreach (string N in Escalas)
                {
                    CorreoSolicitudAsignadaCancelada.EnviarCorreo(N, mensaje, asunto);
                }
            }
            Sol.EstatusS = 3;
            Sol.MotivoCancelacionAjusteS = motivoc;
            GV.SubmitChanges();
            return 1;
        }
        catch(Exception e)
        {
            Log(e.Message + " CancelarSolicitud");
            return 0;
        }
    }

    /// <summary>
    /// Función para cancelar una solicitud de escala se requiere el ID de la solicitud para aumentar un lugar disponible a la solicitud.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="IDE"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int CancelarSolicitudEscala(string IDS, string IDE, string motivoc)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            E.EstatusE = 3;
            E.MotivoCancelacionAjusteE = motivoc;
            GV.SubmitChanges();

            Solicitud S = (from t in GV.Solicitud where t.IDS == Convert.ToInt32(IDS) select t).SingleOrDefault();
            S.LugaresDisponiblesS = (Convert.ToInt32(S.LugaresDisponiblesS) + 1).ToString();
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }
    /// <summary>
    /// Función para actualizar la solicitud al estado de concluido (finalizado).
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="observacionesfinales"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ConcluirSolicitud(string IDS, string observacionesfinales)
    {
        try
        {
            DateTime FechaActual = DateTime.Now;
            ModelDataDataContext GV = new ModelDataDataContext();
            Solicitud S = (from s in GV.Solicitud where s.IDS == Convert.ToInt64(IDS) select s).SingleOrDefault();
            if (FechaActual < S.FechaSalidaS)
            {
                return 2;
            }
            S.EstatusS = 5;
            Solicitud_Vehiculo SV = (from s in GV.Solicitud_Vehiculo where s.IDS == Convert.ToInt64(IDS) select s).SingleOrDefault();
            SV.ObservacionesS_V = observacionesfinales;
            SV.FechaObservacionesS_V = DateTime.Now;
            GV.SubmitChanges();            
            return 1;
        }

        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para agregar observaciones al vehículo asignado.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="observacionesv"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AgregarObservacionesVehiculo(string IDS, string observacionesv, string kilometraje, string nivelcombustible, string tarjetacirculacion)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Solicitud_Vehiculo SV = (from s in GV.Solicitud_Vehiculo where s.IDS == Convert.ToInt32(IDS) select s).SingleOrDefault();
            List<Foto> Fotos = (from x in GV.Foto where x.IDS_V == SV.IDS_V select x).ToList();
            if (Fotos.Count > 0)
            {
                List<Usuario> Admins = (from a in GV.Usuario where a.IDR == 3 select a).ToList();
                if(Admins.Count > 0){
                    string asunto = "Incidencia registrada";
                    string cuerpomensaje = "Lamentamos informale que ha ocurrido un incidente con la solicitud número: " + IDS.ToString();                    
                    string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
                    foreach (Usuario u in Admins)
                    {
                        Correo EnviarIncidencia = new Correo();
                        EnviarIncidencia.EnviarCorreo(u.CorreoElectronicoU, mensaje, asunto);
                    }
                }                
            }
            SV.FechaCondicionesInicialesS_V = DateTime.Now;
            SV.CondicionesIniciales = observacionesv;
            SV.KilometrajeS_V = Convert.ToInt32(kilometraje);
            SV.NivelCombustibleS_V = Convert.ToInt32(nivelcombustible);
            SV.TarjetaCirculacionS_V = Convert.ToBoolean(tarjetacirculacion);
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para actualizar la escala al estado de conlcuido (finalizado).
    /// </summary>
    /// <param name="IDE"></param>
    /// <param name="observacionesfinales"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ConcluirEscala( string IDE, string observacionesfinales){

        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            E.EstatusE = 5;
            E.ObservacionesE = observacionesfinales;
            GV.SubmitChanges();
            return 1;

        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para requerir ajustes en una solicitud.
    /// </summary>
    /// <param name="solicitud"></param>
    /// <param name="motivoa"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AjustesRequeridos(string solicitud, string motivoa, string nomusuario)
    {
        ModelDataDataContext GV = new ModelDataDataContext();

        try
        {
            string usuariosolicitaajustes = ObtenerNombre(nomusuario);
            Solicitud Sol = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(solicitud) select s).SingleOrDefault();
            Sol.EstatusS = 2;
            Sol.MotivoCancelacionAjusteS = motivoa + " Solicitado por: " + usuariosolicitaajustes;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }

    }

    /// <summary>
    /// Función para requerir ajustes a una escala cómo director.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="IDE"></param>
    /// <param name="motivoa"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AjustesRequeridosEscala(string IDS, string IDE, string motivoa, string nomusuario)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string usuariosolicitaajustes = ObtenerNombre(nomusuario);
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            E.EstatusE = 2;
            E.MotivoCancelacionAjusteE = motivoa + " Solicitado por: " + usuariosolicitaajustes;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para asignar un vehiculo a una solicitud.
    /// </summary>
    /// <param name="IDS"></param>
    /// <param name="IDV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AsignarVehiculoSolicitud(string IDS, string IDV, string IDChofer)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Solicitud_Vehiculo SV = new Solicitud_Vehiculo
            {
                IDS = Convert.ToInt64(IDS),
                IDV = Convert.ToInt32(IDV),
                FechaAsignacionS_V = DateTime.Now
            };

            GV.Solicitud_Vehiculo.InsertOnSubmit(SV);
            Solicitud S = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(IDS) select s).SingleOrDefault();
            S.IDUChoferS = Convert.ToInt32(IDChofer);
            GV.SubmitChanges();

            Solicitud Sol = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(IDS) select s).SingleOrDefault();
            Sol.EstatusS = 4;            
            GV.SubmitChanges();

            Usuario User = (from u in GV.Usuario where u.IDU == Sol.IDU select u).SingleOrDefault();

            string asunto = "Vehículo Asignado";
            string cuerpomensaje = "Su solicitud número: S" + IDS.ToString() + " ha sido asignada, para más detalle ingrese a la aplicación.";
            string mensaje = "<html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1.0'/><title>" + asunto + "</title><style type='text/css'>#outlook a {padding:0;}body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}.ExternalClass {width:100%;}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}#backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}img {outline:none; text-decoration:none; -ms-interpolation-mode: bicubic;}a img {border:none;}.image_fix {display:block;}p {margin: 1em 0;}h1, h2, h3, h4, h5, h6 {color: black !important;}h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {color: blue !important;}h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}table td {border-collapse: collapse;}table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }a {color: #000;}@media only screen and (max-device-width: 480px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: black; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important; /* or whatever your want */pointer-events: auto;cursor: default;}}@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {a[href^='tel'], a[href^='sms'] {text-decoration: none;color: blue; /* or whatever your want */pointer-events: none;cursor: default;}.mobile_link a[href^='tel'], .mobile_link a[href^='sms'] {text-decoration: default;color: orange !important;pointer-events: auto;cursor: default;}}@media only screen and (-webkit-min-device-pixel-ratio: 2) {/* Put your iPhone 4g styles in here */}@media only screen and (-webkit-device-pixel-ratio:.75){/* Put CSS for low density (ldpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1){/* Put CSS for medium density (mdpi) Android layouts in here */}@media only screen and (-webkit-device-pixel-ratio:1.5){/* Put CSS for high density (hdpi) Android layouts in here */}/* end Android targeting */.bgBody{background: #ffffff;}.bgItem{background: #ffffff;}h2{color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;font-weight: normal;}p{color:#555;font-family:Helvetica, Arial, sans-serif;font-size:16px;line-height:160%;}</style><script type='colorScheme' class='swatch active'>{'name':'Default','bgBody':'ffffff','link':'000000','color':'555555','bgItem':'ffffff','title':'181818'}</script></head><body><!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. --><table cellpadding='0' width='100%' cellspacing='0' border='0' id='backgroundTable' class='bgBody'><tr><td><!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. --><table cellpadding='0' cellspacing='0' border='0' align='center' width='600' class='bgItem'><tr><td class='movableContentContainer'><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr height='40'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr><tr><td width='200' valign='top'>&nbsp;</td><td width='200' valign='top' align='center'><div class='contentEditableContainer contentImageEditable' ><div class='contentEditable' ><img src='http://mrc.sytes.net/GestionVehicular/img/Logo.png' width='155' height='155'  ata-default='placeholder' alt='Logo'/></div></div></td><td width='200' valign='top'>&nbsp;</td></tr><tr height='25'><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td><td width='200'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' colspan='3' align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><h2>" + asunto + "</h2></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' ><p >" + DateTime.Now.ToShortDateString() + "</p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500' align='left' style='padding-bottom:15px;'><div class='contentEditableContainer contentTextEditable'><div class='contentEditable' ><p>" + cuerpomensaje + "<br /><br /></p></div></div></td><td width='50'>&nbsp;</td></tr></table></div><div class='movableContent'><table cellpadding='0' cellspacing='0' border='0' align='center' width='600'><tr><td width='50'>&nbsp;</td><td width='500'  align='center' style='padding-bottom:10px;padding-top:25px;'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='color:#181818;font-family:Helvetica, Arial, sans-serif;font-size:22px;line-height: 20px;'><p style='color:#181818;'>Recuerde acceder a la aplicación para dar una respuesta a esta solicitud.</p></div></div></td><td width='50'>&nbsp;</td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ></td><td width='50'>&nbsp;</td></tr><tr><td colspan='3' height='30'></td></tr><tr><td width='50'>&nbsp;</td><td width='500' align='center' ><table cellpadding='0' cellspacing='0' border='0' align='center' width='400' height='50'><tr><td bgcolor='#09AA9C' align='center' style='border-radius:4px;' width='400' height='50'><div class='contentEditableContainer contentTextEditable' ><div class='contentEditable' style='text-align:center;'><a target='_blank' href='http://mrc.sytes.net/GestionVehicular/Login.aspx' style='color:#fff;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:16px;color:#fff;border-radius:4px;'>Acceder</a></div></div></td></tr></table></td><td width='50'>&nbsp;</td></tr><tr><td height='10' colspan='3'></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
            Correo NotificacionSolicitante = new Correo();
            NotificacionSolicitante.EnviarCorreo(User.CorreoElectronicoU, mensaje, asunto);
            return 1;
        }
        catch(Exception e)
        {
            Log(e.Message);
            return 0;
        }
        
    }

    /// <summary>
    /// Función para asignar (aprobar una escala) a una solicitud.
    /// </summary>
    /// <param name="IDE"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static int AsignarEscalaSolicitud(string IDE)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();            
            E.EstatusE = 4;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
            
    }

    /// <summary>
    /// Función para archivar una solicitud cancelada.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ArchivarSolicitudCancelada(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();

            Solicitud Solicitud = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(IDS) select s).SingleOrDefault();
            Solicitud.EstatusS = 6;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + "Archivar Solicitud");
            return 0;
        }
    }

    /// <summary>
    /// Función para archivar una escala cancelada.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int ArchivarEscalaCancelada(string IDS, string IDE)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Escala E = (from s in GV.Escala where s.IDE == Convert.ToInt32(IDE) select s).SingleOrDefault();
            E.EstatusE = 6;
            GV.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " Archivar Escala");
            return 0;
        }
    }

    /// <summary>
    /// Función para recuperar el área del usuario logueado.
    /// </summary>
    /// <param name="usuario"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerAreaUsuario(string usuario)
    {
        try
        {
            string area = "Sin área registrada";
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Usuario> US = (from s in GV.Usuario where s.NombreUsuarioU == usuario select s).ToList();
            if (US.Count == 1)
            {
                foreach (Usuario U in US)
                {
                    area = U.AreaU;
                }
            }

            return area;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "Sin área registrada";
        }
        
    }

    /// <summary>
    /// Función para validar que no existan solicitudes pendientes de concluir menores a la fecha actual.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    public static int ValidarSolicitudesSinConcluir(string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Solicitud> Sol = (from s in GV.Solicitud where s.IDU == Convert.ToInt32(IDU) && s.EstatusS == 4 select s).ToList();
            int cuentafechas = 0;
            string FechaActual = DateTime.Now.ToShortDateString();
            if(Sol.Count > 0)
            {
                foreach (Solicitud D in Sol)
                {
                    if (D.FechaSalidaS < Convert.ToDateTime(FechaActual))
                    {
                        cuentafechas++;
                    }
                }

                return cuentafechas;
            }
            else
            {
                return cuentafechas;
            }

            
        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1;
        }
    }

    /// <summary>
    /// Función para validar si existen escalas sin concluir.
    /// </summary>
    /// <param name="IDU"></param>
    /// <returns></returns>
    public static int ValidarSolicitudesEscalaSinConcluir(int IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudEscalaAsignada> OSA = (from s in GV.ObtenerSolicitudEscalaAsignada where s.IDU == IDU select s).ToList();
            int cuentafechas = 0;
            string FechaActual = DateTime.Now.ToShortDateString();
            if (OSA.Count > 0)
            {
                foreach (ObtenerSolicitudEscalaAsignada D in OSA)
                {
                    if (D.FechaSalidaS < Convert.ToDateTime(FechaActual))
                    {
                        cuentafechas++;
                    }
                }
                return cuentafechas;
            }
            else
            {
                return cuentafechas;
            }
            
        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1;
        }
    }

    /// <summary>
    /// Función para validar si la solicitud tiene escalas pendientes de aprobación.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    public static int ValidaExistenEscalasSolicitud(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudEscalaPendienteAsignacion> OSEPA = (from s in GV.ObtenerSolicitudEscalaPendienteAsignacion where s.IDS == Convert.ToInt32(IDS) select s).ToList();
            if (OSEPA.Count > 0)
            {
                return 1; //Si hay
            }
            else
            {
                return 0; //No hay;
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1;
        }
    }

    /// <summary>
    /// Función para validar si hay vehículos disponibles.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    public static int ValidarDisponibilidadVehiculo(DateTime fechasalida, TimeSpan horasalida, DateTime fecharegreso, TimeSpan horaregreso)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudVehiculos> VehiculosOcupados = (from t in GV.ObtenerSolicitudVehiculos where t.FechaSalidaS <= fechasalida && t.FechaRegresoS >= fechasalida select t).ToList();
            List<ObtenerVehiculosDisponibles> VehiculosActivos = (from x in GV.ObtenerVehiculosDisponibles where x.EstatusV == 1 select x).ToList();
            if (VehiculosOcupados.Count == VehiculosActivos.Count)
            {
                return 1; //Ya no hay vehículos disnponibles en fecha y hora seleccionada.
            }
            else
            {
                return 2; //Aún hay vehículos en la fecha y hora seleccionada.
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }

    }

    /// <summary>
    /// Función para validar la disponibilidad de Chofer.
    /// </summary>
    /// <param name="fechasalida"></param>
    /// <param name="horasalida"></param>
    /// <param name="fecharegreso"></param>
    /// <param name="horaregreso"></param>
    /// <returns></returns>
    public static int ValidarDisponibilidadChofer(DateTime fechasalida, TimeSpan horasalida, DateTime fecharegreso, TimeSpan horaregreso)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Solicitud> S = (from s in GV.Solicitud where s.RequiereChoferS == true && s.EstatusS == 4 && s.IDUChoferS != -1 && (s.FechaSalidaS <= fechasalida && s.FechaRegresoS >= fechasalida) select s).ToList();
            List<Usuario> U = (from u in GV.Usuario where u.IDR == 4 select u).ToList();
            if(S.Count == U.Count)
            {
                return 2; //Ya no hay chofer disponible
            }
            else
            {
                return 1; //Aún hay chofer
            }

        }
        catch (Exception e)
        {
            Log(e.Message);
            return 0;
        }
    }

    /// <summary>
    /// Función para obtener los vehiculos que ya están asignados en la fecha y horario de la solicitud que se quiere asignar.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    public static Array ValidarVehiculosAsignados(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Solicitud S = (from s in GV.Solicitud where s.IDS == Convert.ToInt32(IDS) select s).SingleOrDefault();
            List<ObtenerSolicitudVehiculos> OSV = (from t in GV.ObtenerSolicitudVehiculos where (t.FechaSalidaS <= S.FechaSalidaS && t.FechaRegresoS >= S.FechaSalidaS) select t).ToList();
            if (OSV.Count > 0)
            {
                int[] A = new int[200];                
                int contador = 0;
                foreach (ObtenerSolicitudVehiculos D in OSV)
                {
                    A[contador] = Convert.ToInt32(D.IDV);
                    Console.WriteLine(D.FechaSalidaS);
                    contador++;
                }
                return A;
            }
            else
            {
             Array[] A = new Array[0];
             return A;
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para validar si aún hay choferes disponibles para la solicitud requerida.
    /// </summary>
    /// <param name="IDS"></param>
    /// <returns></returns>
    public static Array ValidarChoferAsignado(string IDS)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Solicitud S = (from u in GV.Solicitud where u.IDS == Convert.ToInt32(IDS) select u).SingleOrDefault();
            List<Solicitud> S1 = (from s in GV.Solicitud where s.FechaSalidaS == S.FechaSalidaS && s.RequiereChoferS == true && s.EstatusS == 4 && s.IDUChoferS != -1 select s).ToList();
            if (S1.Count > 0)
            {
                int[] C = new int[200];
                int contador = 0;
                foreach (Solicitud D in S1)
                {
                    C[contador] = Convert.ToInt32(D.IDUChoferS);
                    contador++;
                }
                return C;
            }
            else
            {
                Array[] C = new Array[0];
                return C;
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            Array[] C = new Array[0];
            return C;
        }
    }


    /// <summary>
    /// Función para verificar si existen solicitudes que requieran atención.
    /// </summary>
    /// <param name="ul"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int NotificarSolicitudes(string ul)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from s in GV.Usuario where s.NombreUsuarioU == ul select s).SingleOrDefault();
            List<ObtenerSolicitudesPendienteAjustes> OSPA = (from q in GV.ObtenerSolicitudesPendienteAjustes where q.IDU == US.IDU select q).ToList();
            List<ObtenerSolicitudesEscalaPendienteAjustes> OSEPA = (from w in GV.ObtenerSolicitudesEscalaPendienteAjustes where w.IDU == US.IDU select w).ToList();
            List<ObtenerSeguimientoSolicitud> OSS = (from e in GV.ObtenerSeguimientoSolicitud where e.IDU == US.IDU select e).ToList();
            List<ObtenerSeguimientoSolicitudEscala> OSSE = (from r in GV.ObtenerSeguimientoSolicitudEscala where r.IDU == US.IDU select r).ToList();

            if(OSPA.Count > 0 || OSEPA.Count > 0 || OSS.Count > 0 || OSSE.Count > 0){
                return 1; //Hay solicitudes que requieren atención.
            }
            else
            {
                return 0; //No hay ningun tipo de solicitud
            }

        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1; // Error en la matrix.
        }
    }

    /// <summary>
    /// Función para validar si existen solicitudes pendientes de ajustes.
    /// </summary>
    /// <param name="ul"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int NotificarSolicitudesAjustes(string ul)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from s in GV.Usuario where s.NombreUsuarioU == ul select s).SingleOrDefault();
            List<ObtenerSolicitudesPendienteAjustes> OSPA = (from q in GV.ObtenerSolicitudesPendienteAjustes where q.IDU == US.IDU select q).ToList();
            List<ObtenerSolicitudesEscalaPendienteAjustes> OSEPA = (from w in GV.ObtenerSolicitudesEscalaPendienteAjustes where w.IDU == US.IDU select w).ToList();            

            if (OSPA.Count > 0 || OSEPA.Count > 0 )
            {
                return 1; //Hay solicitudes que requieren atención.
            }
            else
            {
                return 0; //No hay ningun tipo de solicitud
            }

        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1; // Error en la matrix.
        }
    }

    /// <summary>
    /// Función para validar si existen solicitudes con seguimiento activo.
    /// </summary>
    /// <param name="ul"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int NotificarSolicitudesSeguimiento(string ul)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from s in GV.Usuario where s.NombreUsuarioU == ul select s).SingleOrDefault();
            List<ObtenerSeguimientoSolicitud> OSS = (from e in GV.ObtenerSeguimientoSolicitud where e.IDU == US.IDU select e).ToList();
            List<ObtenerSeguimientoSolicitudEscala> OSSE = (from r in GV.ObtenerSeguimientoSolicitudEscala where r.IDU == US.IDU select r).ToList();

            if (OSS.Count > 0 || OSSE.Count > 0)
            {
                return 1; //Hay solicitudes que requieren atención.
            }
            else
            {
                return 0; //No hay ningun tipo de solicitud
            }

        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1; // Error en la matrix.
        }
    }


    /// <summary>
    /// Función para verificar si hay notificaciones pendientes de aprobar.
    /// </summary>
    /// <param name="ul"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int NotificarSolicitudesPendienteAprobar(string ul)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string area = ObtenerAreaUsuario(ul);
            List<ObtieneSolicitudPendienteAprobacion> OSPA = (from s in GV.ObtieneSolicitudPendienteAprobacion where s.AreaU == area select s).ToList();
            List<ObtenerSolicitudEscalaPendienteAprobacion> OSEPA = (from t in GV.ObtenerSolicitudEscalaPendienteAprobacion where t.AreaU == area select t).ToList();
            if (OSPA.Count > 0 || OSEPA.Count > 0)
            {
                return 1; //Hay solicitudes pendientes.
            }
            else
            {
                return 0; // No hay ningun tipo de solicitud pendiente
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1; //Error en la Matrix
        }
    }

    /// <summary>
    /// Función para validar si existen solicitudes pendientes de asignar.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int NotificarSolicitudesPendientesAsignacion()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerSolicitudPendienteAsignacion> OSPA = (from s in GV.ObtenerSolicitudPendienteAsignacion select s).ToList();
            if (OSPA.Count > 0)
            {
                return 1; //Si hay
            }
            else
            {
                return 0; //No hay
            }
        }
        catch (Exception e)
        {
            Log(e.Message);
            return -1;
        }
    }

    /// <summary>
    /// Función para eliminar las imagenes que se subieron 
    /// </summary>
    /// <param name="IDSV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int EliminarEvidenciaVehiculo(string IDSV)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();

            List<Foto> Archivos = (from s in GV.Foto where s.IDS_V == Convert.ToInt32(IDSV) select s).ToList();

            if (Archivos.Count > 0)
            {
                foreach (Foto D in Archivos)
                {
                    Documento Documento = (from n in GV.Documento where n.IDD == D.IDD select n).SingleOrDefault();
                    File.Delete(Documento.RutaRelativaD);
                    GV.Documento.DeleteOnSubmit(Documento);
                    GV.Foto.DeleteOnSubmit(D);
                    GV.SubmitChanges();
                }
            }            
            return 1;
        }
        catch (Exception e)
        {
            Log(e.Message + " ElimianrEvidenciaVehiculo");
            return 0;
        }
    }



    /// <summary>
    /// Obtiene el listado de unidades para reportes.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerUnidades()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Destinos> Destinos = (from s in GV.Destinos orderby s.NombreUN ascending select s).ToList();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            if (Destinos.Count > 0)
            {
                foreach (Destinos D in Destinos)
                {
                    respuesta += "<option value=" + D.IDUN + ">" + D.NombreUN + "</option>";
                }                
            }
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message);
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }

    }

    /// <summary>
    /// Función para obtener los otros destinos para el usuario logueado se utiliza para reportes.
    /// </summary>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerOtrosDestinos(string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario UL = (from s in GV.Usuario where s.NombreUsuarioU == usuariologueado select s).SingleOrDefault();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            List<Solicitud> OtrosDestinos = (from o in GV.Solicitud where o.IDU == UL.IDU select o).ToList();

            if (OtrosDestinos.Count > 0)
            {
                foreach (Solicitud D in OtrosDestinos)
                {
                    if(D.DestinoS <= 0)
                    {
                        respuesta += "<option value=" + D.OtroDestinoS + ">" + D.OtroDestinoS + "</option>";
                    }                    
                }
            }

            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para crear la tabla del reporte del solicitante.
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="OtroDestino"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteSolicitante(string Unidad, string OtroDestino, string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Mensaje del Sistema</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Requerimientos Director/Administrador</th></tr></thead><tbody>";
            List<ReporteSolicitante> ReporteSolicitante = new List<ReporteSolicitante>();
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();

            if (Convert.ToInt32(Unidad) > 0)
            {
                ReporteSolicitante = (from s in GV.ReporteSolicitante where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == Convert.ToInt32(Unidad) && s.IDU == UL.IDU select s).ToList();
            }
            else           
            if (Convert.ToInt32(OtroDestino) > 0)
            {
                ReporteSolicitante = (from s in GV.ReporteSolicitante where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.OtroDestinoS == OtroDestino && s.IDU == UL.IDU select s).ToList();
            }
            if (Convert.ToInt32(OtroDestino) <= 0 && Convert.ToInt32(Unidad) <= 0)
            {
                ReporteSolicitante = (from s in GV.ReporteSolicitante where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == UL.IDU select s).ToList();
            }

            if (ReporteSolicitante.Count > 0)
            {
                foreach(ReporteSolicitante D in ReporteSolicitante)
                {
                    respuesta += "<tr><th scope='row'>S" + D.IDS + "</th>";
                    if (D.DestinoS <= 0)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }

                    respuesta += "<td>" + D.MotivoS + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToShortDateString() + "</td>";
                    respuesta += "<td>" + D.ObservacionesS + "</td>";
                    respuesta += "<td>" + D.ObservacionesSistemaS + "</td>";
                    if (D.EstatusS == 5)
                    {
                        respuesta += "<td>Finalizada</td>";
                    }
                    if (D.EstatusS == 6)
                    {
                        respuesta += "<td>Cancelada/Archivada</td>";
                    }
                    respuesta += "<td>" + D.MotivoCancelacionAjusteS + "</td>";
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteSolicitante");
            return "Error";
        }
    }

    
    /// <summary>
    /// Función para obtener las unidades de negocio que funciona como negocio para la gráfica del reporte.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDestinosGraficaReporteSolicitante()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Unidad> Unidades = (from s in GV.Unidad orderby s.NombreUN ascending select s).ToList();
            string[] Respuesta = new string[Unidades.Count];
            if (Unidades.Count > 0)
            {                
                int aux = 0;
                foreach (Unidad D in Unidades)
                {
                    Respuesta[aux] = D.NombreUN;
                    aux++;
                }
            }
            return Respuesta;
         
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerDestinosGraficaReporteSolicitante");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para obtener los usuarios de acuerdo al área del director para llenar la gráfica.
    /// </summary>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtieneSolicitantesAreaGraficaReporteSolicitantesDirector(string Unidad, string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            List<Usuario> Solicitantes = (from s in GV.Usuario where s.AreaU == UL.AreaU orderby s.NombreU ascending select s).ToList();
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            if (Convert.ToInt32(Unidad) > 0)
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == UL.AreaU && p.DestinoS == Convert.ToInt32(Unidad) orderby p.NombreU ascending select p).ToList();
            }
            else
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == UL.AreaU orderby p.NombreU ascending select p).ToList();
            }
            string[] SolicitantesAreaAux = new string[Solicitantes.Count];            
            int aux = 0;

                foreach (ReporteDirector D in ReporteDirector)
                {
                    if (!SolicitantesAreaAux.Contains(D.NombreU))
                    {
                        SolicitantesAreaAux[aux] = D.NombreU;
                        aux++;
                    }                                                                                
                }
                string[] SolicitantesArea = new string[aux];
                int aux2 = 0;
                foreach (ReporteDirector D in ReporteDirector)
                {                   
                    if (!SolicitantesArea.Contains(D.NombreU))
                    {
                        SolicitantesArea[aux2] = D.NombreU;
                        aux2++;
                    }
                }
            return SolicitantesArea;

        }
        catch(Exception e)
        {
            Log(e.Message + " ObtieneSolicitantesAreaGraficaReporteSolicitantesDirector");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para obtener la información para llenar la gráfica de reporte de solicitante.
    /// </summary>
    /// <param name="usuariologueado"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaReporteSolicitante(string usuariologueado, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Unidad> Unidades = (from s in GV.Unidad orderby s.NombreUN ascending select s).ToList();
            Usuario UL = (from s in GV.Usuario where s.NombreUsuarioU == usuariologueado select s).SingleOrDefault();
            int[] Valor = new int[Unidades.Count];
            int aux = 0;
            if (Unidades.Count > 0)
            {
                foreach(Unidad D in Unidades)
                {
                    Valor[aux] = BuscaSolicitudUnidad(UL.IDU, D.NombreUN, FechaIni, FechaFin);
                    aux++;
                }
            }
            return Valor;

        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerInfoGraficaReporteSolicitante");
            Array[] A = new Array[0];
            return A;
        }
    }


    /// <summary>
    /// Función para obtener el número de veces que aparece una unidad en la reporteria de reporte de solicitante
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="NombreUN"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaSolicitudUnidad(int IDU, string NombreUN, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteSolicitante> ReporteSolicitante = (from p in GV.ReporteSolicitante where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.IDU == IDU && p.NombreUN == NombreUN select p).ToList();
            return ReporteSolicitante.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " BuscaSolicitudUnidad");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener el número de veces que aparece una unidad en la reporteria de reporte unidad director.
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="NombreUN"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaSolicitudUnidadDirector(int IDU, string area, string NombreUN, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            if (IDU > 0)
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == area && p.IDU == IDU && p.NombreUN == NombreUN select p).ToList();
            }
            else
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == area && p.NombreUN == NombreUN select p).ToList();
            }
            return ReporteDirector.Count;
        }
        catch(Exception e)
        {
            Log(e.Message + " BuscaSolicitudUnidadDirector");
            return -1;
        }
    }

    /// <summary>
    /// Función para contar cuantas veces aparece un solicitante en el reporte del director y obtener los valores para la gráfica.
    /// </summary>
    /// <param name="IDU"></param>
    /// <param name="IDUN"></param>
    /// <param name="NombreUN"></param>
    /// <param name="area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaSolicitudSolicitanteDirector(int IDU, int IDUN, string area, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            if(IDUN > 0)
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == area && p.IDU == IDU && p.DestinoS == IDUN select p).ToList();
            }
            else
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == area && p.IDU == IDU select p).ToList();
            }
            return ReporteDirector.Count;

        }
        catch(Exception e)
        {
            Log(e.Message + " BuscaSolicitudSolicitanteDirector");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener el personal a cargo de el usuario recibido.
    /// </summary>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtieneSolicitantesArea(string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            List<Usuario> PersonalACargo = (from s in GV.Usuario where s.AreaU == UL.AreaU && s.IDU != UL.IDU orderby s.NombreU ascending select s).ToList();
            if(PersonalACargo.Count > 0)
            {
                foreach (Usuario D in PersonalACargo)
                {
                    respuesta += "<option value=" + D.IDU + ">" + D.NombreU + "</option>";
                }
            }

            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtieneSolicitantesArea");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para obtener todos los vehículos para el reporte de incidencias.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerVehiculosIncidencias()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
            List<Vehiculo> Vehiculos = (from s in GV.Vehiculo select s).ToList();
            if (Vehiculos.Count > 0)
            {
                foreach (Vehiculo D in Vehiculos)
                {
                    respuesta += "<option value=" + D.IDV + ">" + D.MarcaV + " " + D.ModeloV + " " + D.ColorV + " " + D.PlacaV + "</option>";
                }
            }
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerVehiculosIncidencias");
            return "<option value=" + 0 + ">SELECCIONE UNA OPCIÓN POR FAVOR</option>";
        }
    }

    /// <summary>
    /// Función para crear la tabla del reporte del director.
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteDirector(string Unidad, string Solicitante, string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Área Solicitante</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Mensaje del Sistema</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Requerimientos Director/Administrador</th></tr></thead><tbody>";
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            if (Convert.ToInt32(Unidad) > 0 && Convert.ToInt32(Solicitante) > 0)
            {
                ReporteDirector = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == Convert.ToInt32(Unidad) && s.AreaU == UL.AreaU && s.IDU == Convert.ToInt32(Solicitante) orderby s.NombreU ascending select s).ToList();
            }
            if (Convert.ToInt32(Unidad) > 0 && Convert.ToInt32(Solicitante) <= 0)
            {
                ReporteDirector = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == Convert.ToInt32(Unidad) && s.AreaU == UL.AreaU  orderby s.NombreU ascending select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Convert.ToInt32(Solicitante) > 0)
            {
                ReporteDirector = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == UL.AreaU && s.IDU == Convert.ToInt32(Solicitante) orderby s.NombreU ascending select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Convert.ToInt32(Solicitante) <= 0)
            {
                ReporteDirector = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == UL.AreaU orderby s.NombreU ascending select s).ToList();
            }

            if (ReporteDirector.Count > 0)
            {
                foreach(ReporteDirector D in ReporteDirector)
                {
                    respuesta += "<tr><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>" + D.NombreU + "</td>";
                    respuesta += "<td>" + D.AreaU + "</td>";

                    if (D.DestinoS <= 0)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }                    
                    respuesta += "<td>" + D.MotivoS + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToShortDateString() + "</td>";
                    respuesta += "<td>" + D.ObservacionesS + "</td>";
                    respuesta += "<td>" + D.ObservacionesSistemaS + "</td>";
                    if (D.EstatusS == 5)
                    {
                        respuesta += "<td>Finalizada</td>";
                    }
                    if (D.EstatusS == 6)
                    {
                        respuesta += "<td>Cancelada/Archivada</td>";
                    }
                    respuesta += "<td>" + D.MotivoCancelacionAjusteS + "</td>";
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteDirector");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener los valores de la gráfica de Unidades en el reporte de director.
    /// </summary>
    /// <param name="Solicitante"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaUnidadesReporteDirector(string Solicitante, string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            List<Unidad> Unidades = (from s in GV.Unidad orderby s.NombreUN ascending select s).ToList();            
            int[] Valor = new int[Unidades.Count];
            int aux = 0;
            if(Unidades.Count > 0)
            {
                foreach(Unidad D in Unidades)
                {
                    Valor[aux] = BuscaSolicitudUnidadDirector(Convert.ToInt32(Solicitante), UL.AreaU, D.NombreUN, FechaIni, FechaFin);
                    aux++;
                }
            }
            return Valor;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerInfoGraficaUnidadesReporteDirector");
            Array[] A = new Array[0];
            return A;
        }
    }


    /// <summary>
    /// Función para obtener los valores de la gráfica de Solicitantes en el reporte de director.
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaReporteDirectorSolicitantes(string Unidad, string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario UL = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();
            List<Usuario> Solicitantes = (from s in GV.Usuario where s.AreaU == UL.AreaU orderby s.NombreU ascending select s).ToList();
            List<ReporteDirector> ReporteDirector = new List<ReporteDirector>();
            if (Convert.ToInt32(Unidad) > 0)
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == UL.AreaU && p.DestinoS == Convert.ToInt32(Unidad) orderby p.NombreU ascending select p).ToList();
            }
            else
            {
                ReporteDirector = (from p in GV.ReporteDirector where p.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && p.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && p.AreaU == UL.AreaU orderby p.NombreU ascending select p).ToList();
            }
            string[] SolicitantesAreaAux = new string[Solicitantes.Count];
            int aux = 0;

            foreach (ReporteDirector D in ReporteDirector)
            {
                if (!SolicitantesAreaAux.Contains(D.NombreU))
                {
                    SolicitantesAreaAux[aux] = D.NombreU;
                    aux++;
                }
            }
            string[] SolicitantesArea = new string[aux];
            int aux2 = 0;
            foreach (ReporteDirector D in ReporteDirector)
            {
                if (!SolicitantesArea.Contains(D.NombreU))
                {
                    SolicitantesArea[aux2] = D.NombreU;
                    aux2++;
                }
            }
            int[] Valores = new int[aux];
            int auxV = 0;
            foreach (string D in SolicitantesArea)
                {
                    Usuario US = (from n in GV.Usuario where n.NombreU == D select n).SingleOrDefault();
                    Valores[auxV] = BuscaSolicitudSolicitanteDirector(US.IDU, Convert.ToInt32(Unidad), UL.AreaU, FechaIni, FechaFin);
                    auxV++;
                }            
            return Valores;

        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerInfoGraficaReporteDirectorSolicitantes");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para crear la tabla de Reporte del Administrador 
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="Area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteAdministrador(string Unidad, string Area, string FechaIni, string FechaFin, string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteAdministrador = new List<ReporteDirector>();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Área Solicitante</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>Fecha Solicitud Salida</th><th class='text-center color-fuente-strong'>Fecha Registro Salida</th><th class='text-center color-fuente-strong'>Fecha Solicitud Regreso</th><th class='text-center color-fuente-strong'>Fecha Registro Regreso</th><th class='text-center color-fuente-strong'>Observaciones</th><th class='text-center color-fuente-strong'>Mensaje del Sistema</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Requerimientos Director/Administrador</th></tr></thead><tbody>";
            if (Convert.ToInt32(Unidad) > 0 && Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area && s.DestinoS == Convert.ToInt32(Unidad) && s.IDU == Convert.ToInt32(IDU) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) > 0 && Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area && s.DestinoS == Convert.ToInt32(Unidad) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) > 0 && Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == Convert.ToInt32(IDU) && s.DestinoS == Convert.ToInt32(Unidad) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) > 0 && Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == Convert.ToInt32(Unidad) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area && s.IDU == Convert.ToInt32(IDU) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == Convert.ToInt32(IDU) select s).ToList();
            }
            if (Convert.ToInt32(Unidad) <= 0 && Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }

            string F1, F2;
            if (ReporteAdministrador.Count > 0)
            {
                foreach (ReporteDirector D in ReporteAdministrador)
                {
                    respuesta += "<tr><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>" + D.NombreU + "</td>";
                    respuesta += "<td>" + D.AreaU + "</td>";

                    if (D.DestinoS <= 0)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }
                    respuesta += "<td>" + D.MotivoS + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToShortDateString() + " " + D.HoraSalidaS + "</td>";
                    F1 = D.FechaCondicionesInicialesS_V.ToString();
                    F2 = D.FechaObservacionesS_V.ToString();
                    F1 = F1.Replace("a.m.","");
                    F1 = F1.Replace("p.m.", "");
                    F2 = F2.Replace("a.m.", "");
                    F2 = F2.Replace("p.m.", "");
                    respuesta += "<td>" + F1 + "</td>";
                    respuesta += "<td>" + D.FechaRegresoS.ToShortDateString() + " " + D.HoraRegresoS + "</td>";
                    respuesta += "<td>" + F2 + "</td>";
                    respuesta += "<td>" + D.ObservacionesS + "</td>";
                    respuesta += "<td>" + D.ObservacionesSistemaS + "</td>";
                    if (D.EstatusS == 5)
                    {
                        respuesta += "<td>Finalizada</td>";
                    }
                    if (D.EstatusS == 6)
                    {
                        respuesta += "<td>Cancelada/Archivada</td>";
                    }
                    respuesta += "<td>" + D.MotivoCancelacionAjusteS + "</td>";
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " CrearTablaReporteAdministrador");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener el número de solicitudes por unidad para la gráfica del reporte del administrador por unidades.
    /// </summary>
    /// <param name="IDUN"></param>
    /// <param name="Area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaSolicitudUnidadReporteAdministrador(int IDUN, string Area, string FechaIni, string FechaFin, string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteAdministrador = new List<ReporteDirector>();
            if(Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0){
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area && s.DestinoS == IDUN && s.IDU == Convert.ToInt32(IDU) select s).ToList();
            }
            if (Area != "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area && s.DestinoS == IDUN  select s).ToList();
            }
            if (Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == Convert.ToInt32(IDU) && s.DestinoS == IDUN select s).ToList();
            }
            if (Area == "Seleccione un área por favor." && Convert.ToInt32(IDU) <= 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == IDUN select s).ToList();
            }

            return ReporteAdministrador.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " BuscaSolicitudUnidadReporteAdministrador");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener la información de la gráfica de unidades en reporte de administrador.
    /// </summary>
    /// <param name="Area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaReporteAdministradorUnidades(string Area, string FechaIni, string FechaFin, string IDU)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();            
            List<Unidad> Unidades = (from u in GV.Unidad select u).ToList();
            int[] Valores = new int[Unidades.Count];
            int aux = 0;
            if (Unidades.Count > 0)
            {
                foreach(Unidad D in Unidades)
                {
                    Valores[aux] = BuscaSolicitudUnidadReporteAdministrador(D.IDUN, Area, FechaIni, FechaFin, IDU);
                    aux++;
                }
            }

            return Valores;

        }
        catch (Exception e)
        {
            Log(e.Message);
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para obtener las áreas disponibles para la gráfica de areas en reporte de adminsitrador.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerAreasGraficaAreasReporteAdministrador()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerAreas> Areas = (from s in GV.ObtenerAreas select s).ToList();
            string[] AreasDisponibles = new string[Areas.Count];
            int aux = 0;
            if (Areas.Count > 0)
            {
                foreach (ObtenerAreas D in Areas)
                {
                    AreasDisponibles[aux] = D.AreaU;
                    aux++;
                }
            }
            return AreasDisponibles;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerAreasGraficaAreasReporteAdministrador");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para contar el número de solicitudes por área para la gráfica de areas en reporte de administrador.
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="Area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaAreaSolicitudReporteAdminsitrador(int Unidad, string Area, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteDirector> ReporteAdministrador = new List<ReporteDirector>();

            if (Unidad > 0)
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.DestinoS == Unidad && s.AreaU == Area select s).ToList();
            }
            else
            {
                ReporteAdministrador = (from s in GV.ReporteDirector where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaU == Area select s).ToList();
            }
            return ReporteAdministrador.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " BuscaAreaSolicitudReporteAdminsitrador");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener la información de la gráfica de areas en el reporte de administrador.
    /// </summary>
    /// <param name="Unidad"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaAreasReporteAdministrador(string Unidad, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerAreas> Areas = (from a in GV.ObtenerAreas select a).ToList();
            int[] Valores = new int[Areas.Count];
            int aux = 0;
            if (Areas.Count > 0)
            {
                foreach (ObtenerAreas D in Areas)
                {
                    Valores[aux] = BuscaAreaSolicitudReporteAdminsitrador(Convert.ToInt32(Unidad), D.AreaU, FechaIni, FechaFin);
                    aux++;
                }
            }
                return Valores;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerInfoGraficaAreasReporteAdministrador");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para crear la tabla de incidencias en el reporte de administrador.
    /// </summary>
    /// <param name="Vehiculo"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteAdministradorIncidencias(string Vehiculo, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteIncidencias> Incidencias = new List<ReporteIncidencias>();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No.</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Fecha Salida</th><th class='text-center color-fuente-strong'>Fecha Condiciones Iniciales</th><th class='text-center color-fuente-strong'>Condiciones Iniciales</th><th class='text-center color-fuente-strong'>Fecha Conclución</th><th class='text-center color-fuente-strong'>Concluciones</th><th class='text-center color-fuente-strong'>Vehículo</th><th class='text-center color-fuente-strong'>Estatus</th><th class='text-center color-fuente-strong'>Imagenes</th></tr></thead><tbody>";
            if (Convert.ToInt32(Vehiculo) > 0)
            {
                Incidencias = (from s in GV.ReporteIncidencias where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDV == Convert.ToInt32(Vehiculo) select s).ToList();
            }
            else
            {
                Incidencias = (from s in GV.ReporteIncidencias where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }

            if(Incidencias.Count > 0)
            {
                foreach(ReporteIncidencias D in Incidencias)
                {
                    respuesta += "<tr><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>" + D.NombreU + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToShortDateString() + "</td>";
                    respuesta += "<td>" + D.FechaCondicionesInicialesS_V + "</td>";
                    respuesta += "<td>" + D.CondicionesIniciales + "</td>";
                    respuesta += "<td>" + D.FechaObservacionesS_V + "</td>";
                    respuesta += "<td>" + D.ObservacionesS_V + "</td>";
                    respuesta += "<td>" + D.MarcaV + " " + D.ModeloV + " " + D.ColorV + " " + D.PlacaV + "</td>";
                    if (D.EstatusS == 5)
                    {
                        respuesta += "<td>Concluida</td>";
                    }
                    else
                    {
                        respuesta += "<td>Cancelada</td>";
                    }
                    respuesta += "<td><button type='button' class='btn btn-info' onclick='AbrirModalImagenesIncidencias(" + D.IDS_V + ")'>Imagenes<i class='fa fa-image ml-2 color-fuente-strong' aria-hidden='true'></i></button></td>";

                }
            }

            respuesta += "</tbody></table>";
            return respuesta;

            
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteAdministradorIncidencias");
            return "Error";
        }
    }

    /// <summary>
    /// Función para obtener los vehículos para la gráfica del reporte de incidencias en reporte del administrador.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerVehiculosGraficaReporteIncidencias()
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Vehiculo> VehiculosList = (from s in GV.Vehiculo select s).ToList();
            string[] Vehiculos = new string[VehiculosList.Count];
            int aux = 0;
            if (VehiculosList.Count > 0)
            {
                foreach(Vehiculo D in VehiculosList)
                {
                    Vehiculos[aux] = D.MarcaV + " " + D.ModeloV + " " + D.ColorV + " " + D.PlacaV;
                    aux++;
                }
            }
            return Vehiculos;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerVehiculosGraficaReporteIncidencias");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para recuperar el número de veces que aparece un vehículo en las incidencias para llenar la gráfica de incidencias.
    /// </summary>
    /// <param name="IDV"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int BuscaVehiculoIncidencias(int IDV, DateTime FechaIni, DateTime FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteIncidencias> Incidencias = (from s in GV.ReporteIncidencias where s.IDV == IDV && s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            return Incidencias.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " BuscaVehiculoIncidencias");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener los datos que llena la gráfica de incidencias en el reporte de incidencias del administrador.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerInfoGraficaReporteIncidencias(string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Vehiculo> Vehiculos = (from v in GV.Vehiculo select v).ToList();
            int[] Valores = new int[Vehiculos.Count];
            int aux = 0;
            if (Vehiculos.Count > 0)
            {
                foreach (Vehiculo D in Vehiculos)
                {
                    Valores[aux] = BuscaVehiculoIncidencias(D.IDV, Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin));
                    aux++;
                }
            }
            return Valores;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerInfoGraficaReporteIncidencias");
            Array[] A = new Array[0];
            return A;
        }
    }

    /// <summary>
    /// Función para obtener el carrusel de imagenes de incidencias.
    /// </summary>
    /// <param name="IDSV"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerCarruselImagenesIncidencias(string IDSV)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<Foto> Imagenes = (from s in GV.Foto where s.IDS_V == Convert.ToInt32(IDSV) select s).ToList();
            string respuesta = "<ol class='carousel-indicators'>";
            int aux = 0;
            if(Imagenes.Count > 0)
            {
                /*Llenamos la lista desordenada*/
                foreach(Foto D in Imagenes)
                {
                    if (aux == 0)
                    {
                        respuesta += "<li data-target='#CarruselIncidencias' data-slide-to='0' class='active'></li>";
                    }
                    else
                    {
                        respuesta += "<li data-target='#CarruselIncidencias' data-slide-to='" + aux + "'></li>";
                    }                    
                    aux++;
                }
                respuesta += "</ol>";
                aux = 0;
                respuesta += "<div class='carousel-inner' role='listbox'>";

                /*Llenamos los div que son los contenedores de las imagenes.*/
                foreach (Foto D in Imagenes)
                {
                    Documento Documento = (from d in GV.Documento where d.IDD == D.IDD select d).SingleOrDefault();                    
                    if(aux == 0)
                    {
                        respuesta += @"<div class='carousel-item active'><img class='d-block w-100' src='Archivos\" + Documento.NombreD + "'></div>";
                    }
                    else
                    {
                        respuesta += @"<div class='carousel-item'><img class='d-block w-100' src='Archivos\" + Documento.NombreD + "'></div>";
                    }  
                    aux++;
                }
                respuesta += "</div><a class='carousel-control-prev' href='#CarruselIncidencias' role='button' data-slide='prev'><span class='carousel-control-prev-icon' aria-hidden='true'></span><span class='sr-only'>Previous</span></a><a class='carousel-control-next' href='#CarruselIncidencias' role='button' data-slide='next'><span class='carousel-control-next-icon' aria-hidden='true'></span><span class='sr-only'>Next</span></a>";
            }
            return respuesta;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerCarruselImagenesIncidencias");
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de top vehículo.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteTopVehiculo(string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Vehículo</th><th class='text-center color-fuente-strong'>No. de Veces Utilizado</th></tr></thead><tbody>";
            List<ReporteTopVehiculoResult> TopVehiculo = GV.ReporteTopVehiculo(Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin)).ToList();
            if(TopVehiculo.Count > 0)
            {
                foreach(ReporteTopVehiculoResult D in TopVehiculo)
                {
                    respuesta += "<tr><th scope='row'>" + D.MarcaV + " " + D.ModeloV + " " + D.ColorV + " " + D.PlacaV + "</th>";
                    respuesta += "<td>" + D.NoVecesUtilizado + "</td>";
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteTopVehiculo");
            return "Error";
        }
    }

    /// <summary>
    /// Función para crear la tabla de conteo de vehículos por área.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaVehiculoArea(string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Vehículo</th>";
            List<ObtenerAreas> Areas = (from a in GV.ObtenerAreas select a).ToList();

            if(Areas.Count > 0)
            {
                foreach(ObtenerAreas D in Areas)
                {
                    respuesta += "<th class='text-center color-fuente-strong'>" + D.AreaU + "</th>";
                }
            }
            respuesta += "</tr></thead><tbody>";

            List<Vehiculo> Vehiculos = (from v in GV.Vehiculo select v).ToList();
            if(Vehiculos.Count > 0)
            {
                int valor = 0;
                foreach(Vehiculo V in Vehiculos)
                {

                    respuesta += "<tr><th scope='row'>" + V.MarcaV + " " + V.ModeloV + " " + V.ColorV + " " + V.PlacaV + "</th>";                    
                    foreach(ObtenerAreas A in Areas)
                    {
                        valor = ObtenerConteoVehiculoPorArea(V.IDV, A.AreaU, Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin));                        
                        respuesta += "<td>" + valor + "</td>";                     
                    }
                }
                respuesta += "<tr><th scope='row'>TOTALES</th>";
                foreach(ObtenerAreas P in Areas)
                {
                    respuesta += "<td>" + ObtenerConteoTotalPorArea(P.AreaU,Convert.ToDateTime(FechaIni),Convert.ToDateTime(FechaFin)) + "</td>";
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaVehiculoArea");
            return "Error";
        }
    }

    /// <summary>
    /// /// Función conteo de vehículo en especifico por área.
    /// </summary>
    /// <param name="IDV"></param>
    /// <param name="area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int ObtenerConteoVehiculoPorArea(int IDV, string area, DateTime FechaIni, DateTime FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerVehiculosArea> Vehiculos = (from s in GV.ObtenerVehiculosArea where s.IDV == IDV && s.AreaU == area && s.FechaSalidaS.Date >= FechaIni && s.FechaSalidaS.Date <= FechaFin select s).ToList();
            return Vehiculos.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerConteoVehiculoPorArea");
            return -1;
        }
    }

    /// <summary>
    /// Función para obtener el total de vehículos pedidos por área.
    /// </summary>
    /// <param name="area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    public static int ObtenerConteoTotalPorArea(string area, DateTime FechaIni, DateTime FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ObtenerVehiculosArea> Vehiculos = (from s in GV.ObtenerVehiculosArea where s.AreaU == area && s.FechaSalidaS.Date >= FechaIni && s.FechaSalidaS.Date <= FechaFin select s).ToList();
            return Vehiculos.Count;
        }
        catch (Exception e)
        {
            Log(e.Message + " ObtenerConteoTotalPorArea");
            return -1;
        }
    }

    /// <summary>
    /// Función para crear la tabla de reporte de escala.
    /// </summary>
    /// <param name="solicitante"></param>
    /// <param name="area"></param>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteEscala(string solicitante, string area, string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No. de Escala</th><th class='text-center color-fuente-strong'>Nombre Escala</th><th class='text-center color-fuente-strong'>Area Escala</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo</th><th class='text-center color-fuente-strong'>No. Solicitud</th><th class='text-center color-fuente-strong'>Nombre Solicitante</th><th class='text-center color-fuente-strong'>Área Solicitante</th></tr></thead><tbody>";
            List<ReporteEscalas> Escalas = new List<ReporteEscalas>();
            if (Convert.ToInt32(solicitante) > 0 && area != "TODAS")
            {
                Escalas = (from s in GV.ReporteEscalas where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == Convert.ToInt32(solicitante) && s.AreaEscala == area select s).ToList();
            }
            if (Convert.ToInt32(solicitante) > 0 && area == "TODAS")
            {
                Escalas = (from s in GV.ReporteEscalas where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.IDU == Convert.ToInt32(solicitante)  select s).ToList();
            }
            if (Convert.ToInt32(solicitante) <= 0 && area != "TODAS")
            {
                Escalas = (from s in GV.ReporteEscalas where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) && s.AreaEscala == area select s).ToList();
            }
            if (Convert.ToInt32(solicitante) <= 0 && area == "TODAS")
            {
                Escalas = (from s in GV.ReporteEscalas where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }

            if(Escalas.Count > 0)
            {
                foreach(ReporteEscalas D in Escalas)
                {
                    respuesta += "<tr><th scope='row'>E" + D.IDE + "</th>";
                    respuesta += "<td>" + D.NombreEscala + "</td>";
                    respuesta += "<td>" + D.AreaEscala + "</td>";
                    respuesta += "<td>" + D.DestinoE + "</td>";
                    respuesta += "<td>" + D.MotivoE + "</td>";
                    respuesta += "<td>S" + D.IDS + "</td>";
                    respuesta += "<td>" + D.NombreSolicitud + "</td>";
                    respuesta += "<td>" + D.AreaSolicitud + "</td>";
                }
            }
            respuesta += "</tbody></table>";
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteEscala");
            return "Error";
        }
    }


    /// <summary>
    /// Función para obtener los vehículos para la gráfica de top de vehículos.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerVehiculosGraficaTop(string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteTopVehiculoResult> ListVehiculo = GV.ReporteTopVehiculo(Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin)).ToList();
            string[] Vehiculos = new string[ListVehiculo.Count];
            int aux = 0;
            if(ListVehiculo.Count > 0)
            {
                foreach(ReporteTopVehiculoResult D in ListVehiculo)
                {
                    Vehiculos[aux] = D.MarcaV + " " + D.ModeloV + " " + D.ColorV + " " + D.PlacaV;
                    aux++;
                }
            }
            return Vehiculos;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerVehiculosGraficaTop");
            string[] Vehiculos = new string[0];
            return Vehiculos;
        }
    }

    /// <summary>
    /// Función para obtener los valores para la gráfica de top vehículos
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerValoresVehiculosGraficaTop(string FechaIni, string FechaFin)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            List<ReporteTopVehiculoResult> ListVehiculos = GV.ReporteTopVehiculo(Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin)).ToList();            
            int[] Valores = new int[ListVehiculos.Count];
            int aux = 0;
            if(ListVehiculos.Count > 0)
            {
                foreach(ReporteTopVehiculoResult D in ListVehiculos)
                {
                    Valores[aux] = Convert.ToInt32(D.NoVecesUtilizado);
                    aux++;
                }
            }
            return Valores;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerValoresVehiculosGraficaTop");
            int[] Valores = new int[0];
            return Valores;
        }
    }

    /// <summary>
    /// Función para crear la tabla del reporte de canceladas por solicitante.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="usuariologueado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteSolicitanteCancelada(string FechaIni, string FechaFin, string usuariologueado)
    {
        try
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            string respuesta = "<table class='table table-responsive table-striped table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>No. de Solicitud</th><th class='text-center color-fuente-strong'>Solicitante</th><th class='text-center color-fuente-strong'>Área</th><th class='text-center color-fuente-strong'>Destino</th><th class='text-center color-fuente-strong'>Motivo Solicitud</th><th class='text-center color-fuente-strong'>Fecha</th><th class='text-center color-fuente-strong'>Motivo Canelación</th></tr></thead><tbody>";
            Usuario U = (from u in GV.Usuario where u.NombreUsuarioU == usuariologueado select u).SingleOrDefault();

            List<ReporteCancelada> Canceladas = new List<ReporteCancelada>();

            if(U.IDR == 1)
            {
                Canceladas = (from s in GV.ReporteCancelada where s.IDU == U.IDU && s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }
            if (U.IDR == 2)
            {
                Canceladas = (from s in GV.ReporteCancelada where s.AreaU == U.AreaU && s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }
            if (U.IDR == 3)
            {
                Canceladas = (from s in GV.ReporteCancelada where s.FechaSalidaS.Date >= Convert.ToDateTime(FechaIni) && s.FechaSalidaS.Date <= Convert.ToDateTime(FechaFin) select s).ToList();
            }
                

            if(Canceladas.Count > 0)
            {
                foreach(ReporteCancelada D in Canceladas)
                {
                    respuesta += "<tr><th scope='row'>S" + D.IDS + "</th>";
                    respuesta += "<td>" + D.NombreU + "</td>";
                    respuesta += "<td>" + D.AreaU + "</td>";
                    if(D.DestinoS <= 0)
                    {
                        respuesta += "<td>" + D.OtroDestinoS + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.NombreUN + "</td>";
                    }
                    respuesta += "<td>" + D.MotivoS + "</td>";
                    respuesta += "<td>" + D.FechaSalidaS.ToString("dd-MM-yyyy") + "</td>";
                    respuesta += "<td>" + D.MotivoCancelacionAjusteS + "</td>";
                }
            }

            respuesta += "</tbody></table>";
            return respuesta;

        }
        catch(Exception e)
        {
            Log(e.Message + " CrearTablaReporteSolicitanteCancelada");
            return "Error";
        }
    }
}