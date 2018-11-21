using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    public static MRCDataContext MRC = new MRCDataContext();    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            bool SessionActiva = Convert.ToBoolean(Session["Validate"].ToString());
            if (SessionActiva != true)
            {
                Response.Redirect("http://mrc.sytes.net/MRC/Login.aspx");
            }
            else
            {
                //Session.Timeout = 60;
                //NombreUsuario.Text = Session["User"].ToString();
            }
        }

        catch (Exception P)
        {
            Response.Redirect("http://mrc.sytes.net/MRC/Error.aspx");
        }
    }

    /// <summary>
    /// Función para obtener el menu de acuerdo al puesto del usuario logueado. 
    /// </summary>
    /// <param name="NumeroEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearMenu(string NumeroEmpleado)
    {
        try
        {
            string respuesta = "";
            Usuario U = (from s in MRC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NumeroEmpleado) select s).SingleOrDefault();
            Puesto P = (from s in MRC.Puesto where s.IDP == U.IDPU select s).SingleOrDefault();
            List<ObtenerMenuPuestoResult> PM = MRC.ObtenerMenuPuesto(P.IDP).ToList();
            if(PM.Count > 0)
            {
                
                foreach(ObtenerMenuPuestoResult D in PM)
                {
                    /*Se crea el menu padre*/
                    Random R = new Random();
                    Menu MPadre = (from s in MRC.Menu where s.IDM == D.IDPadreM select s).SingleOrDefault();
                    respuesta += "<div class='dropdown for-notification'>";
                    respuesta += "<button class='btn btn-secondary dropdown-toggle' type='button' id='" + MPadre.NombreM +"' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
                    respuesta += "<img src='IMG/Iconos/" + MPadre.IconoM + "' class='icono-menu' title='"+ MPadre.NombreM +"'/>";
                    respuesta += "<label>" + MPadre.NombreM + "</label>";
                    respuesta += "<span class='count bg-danger'>" + R.Next(1, 100) + "</span></button>";
                    respuesta += "<div class='dropdown-menu' aria-labelledby='notification'>";
                    List<ObtenerSubMenuPuesto> SubMenu = (from s in MRC.ObtenerSubMenuPuesto where s.IDPadreM == D.IDPadreM && s.IDP == P.IDP select s).ToList();

                    foreach(ObtenerSubMenuPuesto X in SubMenu)
                    {
                        /*Se crea submenu hijo*/
                        switch (X.IDM)
                        {
                            case 19:
                                respuesta += "<a class='dropdown-item media bg-flat-color-2' data-toggle='modal' data-target='#ModalPerfiles' onclick='LimpiarModalPerfil()'>";
                                break;
                            case 20:
                                respuesta += "<a class='dropdown-item media bg-flat-color-2' data-toggle='modal' data-target='#ModalMenus' onclick='LimpiarModalMenus()'>";
                                break;
                            case 21:
                                respuesta += "<a class='dropdown-item media bg-flat-color-2' data-toggle='modal' data-target='#ModalUsuarios'>";
                                break;
                            default:
                                respuesta += "<a class='dropdown-item media bg-flat-color-2' href='" + X.URLM + "Name=mgressr" + "'target='_blank'>";
                                break;
                        }                                                
                        respuesta += "<i class='" + X.IconoM + "'></i>";
                        respuesta += "<p>" + X.NombreM + "</p>";
                        respuesta += "</a>";
                    }
                    respuesta += "</div>";
                    respuesta += "</div>";
                }

                
            }
            return respuesta;
            
        }
        catch(Exception e)
        {
            return e.Message.ToString();
        }
    }

    /// <summary>
    /// Función para obtener los datos del usuario logueado
    /// </summary>
    /// <param name="NumeroEmpleado"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerDatosUsuario(string NumeroEmpleado)
    {
        try
        {

            Usuario U = (from s in MRC.Usuario where s.NumeroEmpleadoU == Convert.ToInt32(NumeroEmpleado) select s).SingleOrDefault();
            return U.NombreUsuarioU;
        }

        catch(Exception e)
        {
            return e.Message;
        }
    }

    /// <summary>
    /// Función para obtener el listado de puestos.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerPuestos()
    {
        try
        {
            List<Puesto> Puestos = (from s in MRC.Puesto select s).ToList();
            string respuesta = "<option value='-1'>Seleccione una opción...</option>";
            if(Puestos.Count > 0)
            {
                foreach (Puesto D in Puestos)
                {
                    respuesta += "<option value='" + D.IDP + "'>" + D.NombreP + "</option>";
                }
            }

            return respuesta;
        }
        catch (Exception e)
        {
            return e.Message;
        }
    }


    /// <summary>
    /// Función para obtener el lsitado de aplicaciones disponibles
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerMenus()
    {
        try
        {
            List<Menu> Menus = (from s in MRC.Menu where s.TipoM == true select s).ToList();
            string respuesta = "<option value='-1'>Seleccione una opción...</option>";
            if(Menus.Count > 0)
            {
                foreach(Menu D in Menus)
                {
                    respuesta += "<option value='" + D.IDM +"'>" + D.NombreM + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            return e.Message;
        }
    }


    [System.Web.Services.WebMethod]
    public static string ObtenerMenusPadres()
    {
        try
        {
            List<Menu> Menus = (from s in MRC.Menu where s.TipoM == false select s).ToList();
            string respuesta = "<option value='-1'>Seleccione una opción...</option>";
            if (Menus.Count > 0)
            {
                foreach (Menu D in Menus)
                {
                    respuesta += "<option value='" + D.IDM + "'>" + D.NombreM + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            return e.Message;
        }
    }


    /// <summary>
    /// Función para obtener el listado de roles de canelita :3 
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerRolesDeCanela()
    {
        try
        {
            List<Rol> Roles = (from s in MRC.Rol select s).ToList();
            string respuesta = "<option value='-1'>Seleccione una opción...</option>";

            if(Roles.Count > 0)
            {
                foreach(Rol D in Roles)
                {
                    respuesta += "<option value='" + D.IDR + "'>" + D.NombreR + "</option>";
                }
            }

            return respuesta;
        }
        catch(Exception e)
        {
            return e.Message;
        }
    }

    /// <summary>
    /// Función para guardar un nuevo registro en la tabla PuestoMenu
    /// </summary>
    /// <param name="Puesto"></param>
    /// <param name="Menu"></param>
    /// <param name="Rol"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int GuardarPuestoMenu(string Puesto, string Menu, string Rol)
    {
        try
        {
            List<PuestoMenu> VerificaExisteCombinacion = (from s in MRC.PuestoMenu where s.IDP == Convert.ToInt32(Puesto) && s.IDM == Convert.ToInt32(Menu) && s.IDR == Convert.ToInt32(Rol) select s).ToList();

            if(VerificaExisteCombinacion.Count > 0)
            {
                return 2;
            }
            else
            {
                PuestoMenu PuestoMenu = new PuestoMenu
                {
                    IDP = Convert.ToInt32(Puesto),
                    IDM = Convert.ToInt32(Menu),
                    EstatusPM = true,
                    IDR = Convert.ToInt32(Rol)
                };

                MRC.PuestoMenu.InsertOnSubmit(PuestoMenu);
                MRC.SubmitChanges();
                return 1;
            }

        }
        catch(Exception e)
        {
            return 0; 
        }
    }


}