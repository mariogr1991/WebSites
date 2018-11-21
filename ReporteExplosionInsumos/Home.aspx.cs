using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using LinqToExcel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Globalization;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
                
        //bool SessionActiva = Convert.ToBoolean(Session["Validate"].ToString());
        //if (SessionActiva != true)
        //{
        //    Response.Redirect("http://mrc.sytes.net/ReporteInsumos/Login.aspx");
        //}
        //else
        //{
        //    Session.Timeout = 2;
        //    NombreUsuario.Text = Session["User"].ToString();
        //}
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
    /// Función para obtenener el listado de las unidades de negocio.
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerUnidadNegocio()
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            List<Unidad> Unidades = (from s in REI.Unidad select s).ToList();
            string respuesta = "<option value='-1'>Seleccione una unidad...</option>";
            if(Unidades.Count > 0)
            {
                foreach(Unidad D in Unidades)
                {
                    respuesta += "<option value=" + D.IDUN + ">" + D.NombreUN + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerUnidadNegocio");
            return "<option value='-1'>Seleccione una unidad...</option>";
        }
    }


    /// <summary>
    /// Función para agregar un documento a la base de datos.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="NombreArchivo"></param>
    /// <param name="tipo"></param>
    /// <param name="IDUN"></param>
    /// <param name="IDU"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int AgregarDocumento(string FechaIni, string FechaFin, string NombreArchivo, string tipo, string IDUN, string IDU, string IDI, string SubTipo)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            Documento Documento = new Documento { 
                FechaCreacionD = DateTime.Now,
                HoraCreacionD = TimeSpan.Parse(DateTime.Now.TimeOfDay.ToString()),
                FechaPeriodoIniD = Convert.ToDateTime(FechaIni),
                FechaPeriodoFinD = Convert.ToDateTime(FechaFin),
                RutaD = ConfigurationManager.AppSettings["RutaBuscar"] + NombreArchivo,
                NombreD = NombreArchivo,
                TipoD = Convert.ToByte(tipo),
                IDUN = Convert.ToInt32(IDUN),
                IDU = Convert.ToInt32(IDU),
                SubTipoD = Convert.ToByte(SubTipo)

            };

            REI.Documento.InsertOnSubmit(Documento);
            REI.SubmitChanges();
            LeerArchivo(NombreArchivo, Convert.ToInt32(tipo), Documento.IDD, Convert.ToInt32(IDI), FechaIni, FechaFin, Convert.ToInt32(IDUN), SubTipo);
            return Documento.IDD;
        }
        catch(Exception e)
        {
            Log(e.Message + " AgregarDocumento");
            return 0;
        }
    }

    /// <summary>
    /// Función para leer el documento Excel y guardar los datos en la base de datos.
    /// </summary>
    /// <param name="DocExcel"></param>
    /// <param name="tipo"></param>
    /// <param name="IDD"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string LeerArchivo(string DocExcel, int tipo, int IDD, int IDI, string FechaIni, string FechaFin, int IDUN, string SubTipo)
    {
        try
        {
            string path = ConfigurationManager.AppSettings["RutaBuscar"] + DocExcel;
            REIDataContext REI = new REIDataContext();
            string respuesta = "";
            ExcelQueryFactory Librito = new ExcelQueryFactory(path);

            switch (tipo)
            {
                case 0:
                    var resultadoI = (from datito in Librito.Worksheet("Hoja1")
                                     let elmeeeeent = new FinalPeriodo
                                     {
                                         Codigo = datito["Codigo"],
                                         Categoria = datito["Categoria"],
                                         Producto = datito["Producto"],
                                         UM = datito["UM"],
                                         PrecioUnitario = datito["PrecioUnitario"],
                                         InventarioInicial = datito["InventarioInicial"],
                                         Compras = datito["Compras"],
                                         CantidadUtilizada = datito["CantidadUtilizada"],
                                         InventarioFinal = datito["InventarioFinal"],
                                         FechaUltimoInventario = datito["FechaUltimoInventario"],
                                     }
                                     select elmeeeeent).ToList();
                    if (resultadoI.Count > 0)
                    {
                        foreach (FinalPeriodo D in resultadoI)
                        {
                            Inventario In = new Inventario
                            {
                                CodigoI = Convert.ToInt32(D.Codigo),
                                CategoriaI = D.Categoria,
                                ProductoI = D.Producto,
                                UMI = D.UM,
                                CostoUnitarioI = Convert.ToDecimal(D.PrecioUnitario),
                                InventarioInicialI = Convert.ToDecimal(D.InventarioInicial),
                                ComprasI = Convert.ToDecimal(D.Compras),
                                UtilizadoI = Convert.ToDecimal(D.CantidadUtilizada),
                                InventarioFinalI = Convert.ToDecimal(D.InventarioFinal),
                                FechaUltimoInventarioI = Convert.ToDateTime(D.FechaUltimoInventario),
                                IDD = IDD,
                                FechaIniPeriodoI = Convert.ToDateTime(FechaIni),
                                FechaFinPeriodoI = Convert.ToDateTime(FechaFin),
                                IDUNI = IDUN,
                                SubTipoI = Convert.ToByte(SubTipo)

                            };
                            REI.Inventario.InsertOnSubmit(In);
                            REI.SubmitChanges();
                        }
                    }
                    break;
                case 1:
                    var resultadoV = (from datito in Librito.Worksheet("Hoja1")
                                      let elmeeeeent = new VariacionPeriodo
                                     {
                                         Codigo = datito["Codigo"],
                                         Categoria = datito["Categoria"],
                                         Producto = datito["Producto"],
                                         UM = datito["UM"],
                                         PrecioUnitario = datito["PrecioUnitario"],
                                         Diferencia = datito["Diferencia"],
                                         Utilizado = datito["Utilizado"],
                                         FechaUltimoInventario = datito["FechaUltimoInventario"],
                                     }
                                     select elmeeeeent).ToList();
                    if (resultadoV.Count > 0)
                    {
                        foreach (VariacionPeriodo D in resultadoV)
                        {
                            Variacion Va = new Variacion
                            {
                                CodigoV = Convert.ToInt32(D.Codigo),
                                CategoriaV = D.Categoria,
                                ProductoV = D.Producto,
                                UMV = D.UM,
                                CostoUnitarioV = Convert.ToDecimal(D.PrecioUnitario),
                                DiferenciaV = Convert.ToDecimal(D.Diferencia),
                                UtilizadoV = Convert.ToDecimal(D.Utilizado),
                                FechaUltimoInventarioV = Convert.ToDateTime(D.FechaUltimoInventario),
                                IDD = IDD,
                                FechaIniPeriodoV = Convert.ToDateTime(FechaIni),
                                FechaFinPeriodoV = Convert.ToDateTime(FechaFin),
                                IDUNV = IDUN,
                                SubTipoV = Convert.ToByte(SubTipo)
                                

                            };
                            REI.Variacion.InsertOnSubmit(Va);
                            REI.SubmitChanges();
                        }
                    }
                    break;
                case 2:
                    Inventario IActualizar = (from s in REI.Inventario where s.IDI == IDI select s).SingleOrDefault();
                    IActualizar.DetalleI = IDD;
                    REI.SubmitChanges();
                    break;
                default:
                    break;
            }
                
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " LeerArchivo");
            return "Error";
        }
    }

    public class FinalPeriodo
    {
        public string Codigo { get; set; }
        public string Categoria { get; set; }
        public string Producto { get; set; }
        public string UM { get; set; }
        public string PrecioUnitario { get; set; }
        public string InventarioInicial { get; set; }
        public string Compras { get; set; }        
        public string CantidadUtilizada { get; set; }
        public string InventarioFinal { get; set; }      
        public string FechaUltimoInventario { get; set; }
        
    }

    public class VariacionPeriodo
    {
        public string Codigo { get; set; }
        public string Categoria { get; set; }
        public string Producto { get; set; }
        public string UM { get; set; }
        public string PrecioUnitario { get; set; }
        public string Diferencia { get; set; }
        public string Utilizado { get; set; }
        public string FechaUltimoInventario { get; set; }
    }

    /// <summary>
    /// Función para obtener los insumos por periodo, unidad de negocio y área operativa.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="IDUN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ObtenerInsumosPeriodo(string FechaIni, string FechaFin, string IDUN, string AreaOperativa)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            string respuesta = "<option value='-1'>Seleccione un insumo...</option>";
            List<InventarioDocumento> Insumos = (from s in REI.InventarioDocumento where s.SubTipoI == Convert.ToInt16(AreaOperativa) && s.IDUN == Convert.ToInt32(IDUN) && s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinD == Convert.ToDateTime(FechaFin) orderby s.ProductoI ascending select s).ToList();
            if(Insumos.Count > 0)
            {
                foreach(InventarioDocumento D in Insumos)
                {
                    respuesta += "<option value=" + D.IDI + ">" + D.ProductoI + "</option>";
                }
            }
            return respuesta;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerInsumosPeriodo");
            return "<option value='-1'>Seleccione un insumo...</option>";
        }
    }

    /// <summary>
    /// Función para obtener los insumos por un periodo de fecha
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    public static string ObtenerInsumosPeriodoGrafica(string FechaIni, string FechaFin)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            string respuesta = "<option value='-1'>Seleccione un insumo...</option>";
            //List<InventarioDocumento> Insumos = (from s in REI.InventarioDocumento where s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinD == Convert.ToDateTime(FechaFin) orderby s.ProductoI ascending select s).ToList();
            List<InventarioDocumento> Insumos = (from dist in REI.InventarioDocumento where dist.FechaIniPeriodoI == Convert.ToDateTime(FechaIni) && dist.FechaFinPeriodoI == Convert.ToDateTime(FechaFin) select new InventarioDocumento{
                IDI = dist.IDI,
                CodigoI = dist.CodigoI,
                CategoriaI = dist.CategoriaI,
                ProductoI = dist.ProductoI,
                UMI = dist.UMI,
                CostoUnitarioI = dist.CostoUnitarioI,
                InventarioInicialI = dist.InventarioInicialI,
                ComprasI = dist.ComprasI,
                UtilizadoI = dist.UtilizadoI,
                InventarioFinalI = dist.InventarioFinalI,
                FechaUltimoInventarioI = dist.FechaUltimoInventarioI,
                DetalleI = dist.DetalleI,
                IDD = dist.IDD,
                FechaIniPeriodoI = dist.FechaIniPeriodoI,
                FechaFinPeriodoI = dist.FechaFinPeriodoI,
                IDUNI = dist.IDUNI,
                SubTipoI = dist.SubTipoI,
                FechaPeriodoIniD = dist.FechaPeriodoIniD,
                FechaPeriodoFinD = dist.FechaPeriodoFinD,
                IDUN = dist.IDUN,
                SubTipoD = dist.SubTipoD

            }).GroupBy(n => n.ProductoI).Select(y => y.First()).OrderBy(t => t.ProductoI).ToList();
            if (Insumos.Count > 0)
            {
                foreach (InventarioDocumento D in Insumos)
                {
                    respuesta += "<option value=" + D.ProductoI + ">" + D.ProductoI + "</option>";
                }
            }
            return respuesta;
        }

        catch(Exception e)
        {
            Log(e.Message + " ObtenerInsumosPeriodoGrafica");
            return "<option value='-1'>Seleccione un insumo...</option>";
        }
    }

    /// <summary>
    /// Función para obtener los datos para la gráfica de comparativa de insumo entre unidades
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="Insumo"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatosInsumoUnidadGrafica(string FechaIni, string FechaFin, string Insumo)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            List<ObtenerDatosInsumoUnidadResult> Datos = REI.ObtenerDatosInsumoUnidad(Insumo,Convert.ToDateTime(FechaIni),Convert.ToDateTime(FechaFin)).ToList();
            string[,] Valores=new string[Datos.Count,2];
            CultureInfo cultura = new CultureInfo("es-MX");
            int aux = 0;
            decimal x;
            if (Datos.Count > 0)
            {
                foreach (ObtenerDatosInsumoUnidadResult D in Datos)
                {
                    for (int i = 0; i < 2; i++)
                    {
                        if(i == 0)
                        {
                            Valores[aux, i] = D.NombreUN;
                        }
                        else
                        {
                            x = Convert.ToDecimal(D.Variacion);
                            Valores[aux, i] = x.ToString(cultura);
                        }
                    }
                    aux++;
                }
            }
            return Valores;
;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerInsumosPeriodoGrafica");
            string[,] Valores = new string[0, 0];  
            return Valores;
        }
    }


    /// <summary>
    /// Función para crear la gráfica de comparativa de insumo por área operativa de una unidad.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="Insumo"></param>
    /// <param name="Unidad"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static Array ObtenerDatosInsumoUnidadGraficaArea(string FechaIni, string FechaFin, string Insumo, string Unidad)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            List<ObtenerDatosInsumoUnidadAreaResult> Datos = REI.ObtenerDatosInsumoUnidadArea(Insumo, Convert.ToDateTime(FechaIni), Convert.ToDateTime(FechaFin), Convert.ToInt32(Unidad)).ToList();
            string[,] Valores = new string[Datos.Count, 2];
            CultureInfo cultura = new CultureInfo("es-MX");
            int aux = 0;
            decimal x;
            if (Datos.Count > 0)
            {
                foreach (ObtenerDatosInsumoUnidadAreaResult D in Datos)
                {
                    for (int i = 0; i < 2; i++)
                    {
                        if (i == 0)
                        {
                            Valores[aux, i] = D.SubTipoD.ToString();
                        }
                        else
                        {
                            x = Convert.ToDecimal(D.Variacion);
                            Valores[aux, i] = x.ToString(cultura);
                        }
                    }
                    aux++;
                }
            }
            return Valores;
        }
        catch(Exception e)
        {
            Log(e.Message + " ObtenerDatosInsumoUnidadGraficaArea");
            string[,] Valores = new string[0, 0];
            return Valores;
        }
    }


    /// <summary>
    /// Función para crear la tabla del reporte concentrado.
    /// </summary>
    /// <param name="FechaIni"></param>
    /// <param name="FechaFin"></param>
    /// <param name="IDUN"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string CrearTablaReporteConcentrado(string FechaIni, string FechaFin, string IDUN, string Insumo, string AreaOperativa, string CheckCostos)
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            string respuesta;
            CultureInfo cultura = new CultureInfo("es-MX");
            if(Convert.ToBoolean(CheckCostos) == true)
            {
                 respuesta = "<table class='table table-responsive table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong' colspan='6'></th><th class='text-center color-fuente-strong' colspan='2'>Inventario Inicial</th><th class='text-center color-fuente-strong' colspan='2'>Entradas</th><th class='text-center color-fuente-strong' colspan='2'>Utilizado RL</th><th class='text-center color-fuente-strong' colspan='2'>Inventario Final</th><th class='text-center color-fuente-strong' colspan='2'></th><th class='text-center color-fuente-strong' colspan='2'>Variación</th><th class='text-center color-fuente-strong' colspan='1'></th></tr><tr><th class='text-center color-fuente-strong'>Unidad</th><th class='text-center color-fuente-strong'>Área Operativa</th><th class='text-center color-fuente-strong'>Categoria</th><th class='text-center color-fuente-strong'>Producto</th><th class='text-center color-fuente-strong'>Unidad de Medida</th><th class='text-center color-fuente-strong'>Costo Unitario</th><th class='text-center color-fuente-strong'>#</th><th class='text-center color-fuente-strong'>$</th><th class='text-center color-fuente-strong'>#</th><th class='text-center color-fuente-strong'>$</th><th class='text-center color-fuente-strong'>#</th><th class='text-center color-fuente-strong'>$</th><th class='text-center color-fuente-strong'>#</th><th class='text-center color-fuente-strong'>$</th><th class='text-center color-fuente-strong'>Uso Total</th><th class='text-center color-fuente-strong'>Venta</th><th class='text-center color-fuente-strong'>#</th><th class='text-center color-fuente-strong'>$</th><th class='text-center color-fuente-strong'>Detalle</th></tr></thead><tbody>";
            }else{
                 respuesta = "<table class='table table-responsive table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'></tr><tr><th class='text-center color-fuente-strong'>Unidad</th><th class='text-center color-fuente-strong'>Área Operativa</th><th class='text-center color-fuente-strong'>Categoria</th><th class='text-center color-fuente-strong'>Producto</th><th class='text-center color-fuente-strong'>Unidad de Medida</th><th class='text-center color-fuente-strong'>Costo Unitario</th><th class='text-center color-fuente-strong'>Inventario Inicial</th><th class='text-center color-fuente-strong'>Entradas</th><th class='text-center color-fuente-strong'>Utilizado RL</th><th class='text-center color-fuente-strong'>Inventario Final</th><th class='text-center color-fuente-strong'>Uso Total</th><th class='text-center color-fuente-strong'>Venta</th><th class='text-center color-fuente-strong'>Variación</th><th class='text-center color-fuente-strong'>Detalle</th></tr></thead><tbody>";
            }            
            List<ReporteInsumos> Insumos = new List<ReporteInsumos>();            
            if(Convert.ToInt32(IDUN) > 0)
            {
                Insumos = (from s in REI.ReporteInsumos where s.ProductoI.Contains(Insumo) && s.SubTipoD == Convert.ToInt16(AreaOperativa) && s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoIniDV == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinDV == Convert.ToDateTime(FechaFin) && s.IDUN == Convert.ToInt32(IDUN) && s.IDUNV == Convert.ToInt32(IDUN) orderby s.CategoriaI, s.ProductoI ascending select s).ToList();                
            }
            else
            {
                Insumos = (from s in REI.ReporteInsumos where s.ProductoI.Contains(Insumo) && s.SubTipoD == Convert.ToInt16(AreaOperativa) && s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinD == Convert.ToDateTime(FechaFin) && s.FechaPeriodoIniDV == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinDV == Convert.ToDateTime(FechaFin) orderby s.CategoriaI, s.ProductoI ascending select s).ToList();                
            }
            
            if(Insumos.Count > 0)
            {
                foreach(ReporteInsumos D in Insumos)
                {
                    respuesta += "<tr class='table-warning'><th scope='row'>" + D.NombreUN + "</th>";
                    switch(D.SubTipoD)
                    {
                        case 0:
                            respuesta += "<td>Piso</td>";
                            break;
                        case 1:
                            respuesta += "<td>Cocina</td>";
                            break;
                        case 2:
                            respuesta += "<td>Panaderia</td>";
                            break;
                    }                    
                    respuesta += "<td>" + D.CategoriaI + "</td>";
                    respuesta += "<td>" + D.ProductoI + "</td>";
                    respuesta += "<td>" + D.UMI + "</td>";
                    respuesta += "<td>" + D.CostoUnitarioI.ToString("C", cultura) + "</td>";

                    if (Convert.ToBoolean(CheckCostos) == true)
                    {
                        respuesta += "<td>" + D.InventarioInicialI + "</td>";
                        respuesta += "<td>" + Convert.ToDecimal(D.TotalInventarioInicialI).ToString("C", cultura) + "</td>";
                        respuesta += "<td>" + D.ComprasI + "</td>";
                        respuesta += "<td>" + Convert.ToDecimal(D.TotalComprasI).ToString("C", cultura) + "</td>";
                        respuesta += "<td>" + D.UtilizadoI + "</td>";
                        respuesta += "<td>" + Convert.ToDecimal(D.TotalUtilizadoI).ToString("C", cultura) + "</td>";
                        respuesta += "<td>" + D.InventarioFinalI + "</td>";
                        respuesta += "<td>" + Convert.ToDecimal(D.TotalInventarioFinalI).ToString("C", cultura) + "</td>";
                        respuesta += "<td>" + D.DiferenciaV + "</td>";
                        respuesta += "<td>" + D.UtilizadoV + "</td>";
                        respuesta += "<td>" + D.Cantidad + "</td>";
                        respuesta += "<td>" + Convert.ToDecimal(D.Perdida_Favor).ToString("C", cultura) + "</td>";
                    }
                    else
                    {
                        respuesta += "<td>" + D.InventarioInicialI + "</td>";                        
                        respuesta += "<td>" + D.ComprasI + "</td>";                        
                        respuesta += "<td>" + D.UtilizadoI + "</td>";                       
                        respuesta += "<td>" + D.InventarioFinalI + "</td>";                        
                        respuesta += "<td>" + D.DiferenciaV + "</td>";
                        respuesta += "<td>" + D.UtilizadoV + "</td>";
                        respuesta += "<td>" + D.Cantidad + "</td>";                        
                    }


                    if(D.DetalleI > 0)
                    {
                        respuesta += "<td><a type='button' class='btn btn-primary' href='" + ConfigurationManager.AppSettings["RutaPDF"] + D.NombreD + "' target='_blank'>Ver Detalle<i class='fa fa-question-circle-o ml-1'></i></a></td>";
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
            Log(e.Message + " CrearTablaReporteConcentrado");
            return "respuesta";
        }
    }
}

public class Test
{
    public string Name { get; set;}
    public string Position { get; set; }
    public string Office { get; set; }
    public string Extn { get; set; }
    public string Start { get; set; }
    public string Salary { get; set; }


}