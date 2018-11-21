using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DataTable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static Array CrearTablaReporteConcentrado()
    {
        try
        {
            REIDataContext REI = new REIDataContext();
            string respuesta = "<table class='table table-responsive table-hover table-fixed w-auto'><thead class='blue-grey lighten-4'><tr><th class='text-center color-fuente-strong'>Unidad</th><th class='text-center color-fuente-strong'>Producto</th><th class='text-center color-fuente-strong'>Unidad de Medida</th><th class='text-center color-fuente-strong'>Costo Unitario</th><th class='text-center color-fuente-strong'>Inventario Inicial</th><th class='text-center color-fuente-strong'>$ Inventario Inicial</th><th class='text-center color-fuente-strong'>Compras</th><th class='text-center color-fuente-strong'>$ Compras</th><th class='text-center color-fuente-strong'>Utilizado</th><th class='text-center color-fuente-strong'>$ Utilizado</th><th class='text-center color-fuente-strong'>Inventario Final</th><th class='text-center color-fuente-strong'>$ Inventario Final</th><th class='text-center color-fuente-strong'>Inventario Inicial - Compras </th><th class='text-center color-fuente-strong'>$ Inventario Inicial - Compras</th><th class='text-center color-fuente-strong'>Diferencia Variación</th><th class='text-center color-fuente-strong'>Variación Utilizado</th><th class='text-center color-fuente-strong'>Variación</th><th class='text-center color-fuente-strong'>$ Variación</th><th class='text-center color-fuente-strong'>Detalle</th></tr></thead><tbody>";
            List<ReporteInsumos> Insumos = new List<ReporteInsumos>();
            Array AInsumos;
            Insumos = (from s in REI.ReporteInsumos orderby s.Perdida_Favor ascending select s).ToList();
            //if (Convert.ToInt32(IDUN) > 0)
            //{
            //    //Insumos = (from s in REI.ReporteInsumos where s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinD == Convert.ToDateTime(FechaFin) && s.IDUN == Convert.ToInt32(IDUN) orderby s.Perdida_Favor ascending select s).ToList();string FechaIni, string FechaFin, string IDUN
            //    AInsumos = (from s in REI.ReporteInsumos  orderby s.Perdida_Favor ascending select s).ToArray();
            //}
            //else
            //{
            //    //Insumos = (from s in REI.ReporteInsumos where s.FechaPeriodoIniD == Convert.ToDateTime(FechaIni) && s.FechaPeriodoFinD == Convert.ToDateTime(FechaFin) orderby s.Perdida_Favor ascending select s).ToList();
            //    AInsumos = (from s in REI.ReporteInsumos  orderby s.Perdida_Favor ascending select s).ToArray();
            //}
            int aux = 0;
            if (Insumos.Count > 0)
            {
                Array[] RAI = new Array[Insumos.Count];
                foreach (ReporteInsumos D in Insumos)
                {
                    string[] datos = new string[18];
                    respuesta += "<tr class='table-warning'><th scope='row'>" + D.NombreUN + "</th>";
                    datos[0] = D.NombreUN;
                    respuesta += "<td>" + D.ProductoI + "</td>";
                    datos[1] = D.ProductoI;
                    respuesta += "<td>" + D.UMI + "</td>";
                    datos[2] = D.UMI;
                    respuesta += "<td>$ " + D.CostoUnitarioI + "</td>";
                    datos[3] = D.CostoUnitarioI.ToString("C");
                    respuesta += "<td>" + D.InventarioInicialI + "</td>";
                    datos[4] = D.InventarioInicialI.ToString();
                    respuesta += "<td>$ " + D.TotalInventarioInicialI + "</td>";
                    datos[5] = Convert.ToDecimal(D.TotalInventarioInicialI).ToString("C");
                    respuesta += "<td>" + D.ComprasI + "</td>";
                    datos[6] = D.ComprasI.ToString();
                    respuesta += "<td>$ " + D.TotalComprasI + "</td>";
                    datos[7] = Convert.ToDecimal(D.TotalComprasI).ToString("C");
                    respuesta += "<td>" + D.UtilizadoI + "</td>";
                    datos[8] = D.UtilizadoI.ToString();
                    respuesta += "<td>$ " + D.TotalUtilizadoI + "</td>";
                    datos[9] = Convert.ToDecimal(D.TotalUtilizadoI).ToString("C");
                    respuesta += "<td>" + D.InventarioFinalI + "</td>";
                    datos[10] = D.InventarioFinalI.ToString();
                    respuesta += "<td>$ " + D.TotalInventarioFinalI + "</td>";
                    datos[11] = Convert.ToDecimal(D.TotalInventarioFinalI).ToString("C");
                    respuesta += "<td>" + D.DifrenciaInventarioInicialCompras + "</td>";
                    datos[12] = D.DifrenciaInventarioInicialCompras.ToString();
                    respuesta += "<td>$ " + D.TotlaDifrenciaInventarioInicialCompras + "</td>";
                    datos[13] = Convert.ToDecimal(D.TotalInventarioInicialI).ToString("C");
                    respuesta += "<td>" + D.DiferenciaV + "</td>";
                    datos[14] = D.DiferenciaV.ToString();
                    respuesta += "<td>" + D.UtilizadoV + "</td>";
                    datos[15] = D.UtilizadoV.ToString();
                    respuesta += "<td>" + D.Cantidad + "</td>";
                    datos[16] = D.Cantidad.ToString();
                    respuesta += "<td>$ " + D.Perdida_Favor + "</td>";
                    datos[17] = Convert.ToDecimal(D.Perdida_Favor).ToString("C");

                    RAI[aux] = datos;
                    aux++;
                }
                return RAI;
            }
            else
            {
                Array RAI = new Array[0];
                return RAI;
            }
     

            respuesta += "</tbody></table>";
            

        }
        catch (Exception e)
        {
            string[] respuesta = new string[1];
            respuesta[0] = "Error";
            return respuesta;
        }
    }
 
}
