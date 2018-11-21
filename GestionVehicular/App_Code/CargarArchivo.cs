using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

 /// <summary>
    /// Descripción breve de CargarArchivo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class CargarArchivo : System.Web.Services.WebService
    {
        /// <summary>
        /// Metodo Web para subir un documento INE/Licencia Conducir
        /// </summary>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Guardar()
        {
 
                HttpContext Contexto = HttpContext.Current;
                HttpFileCollection ColeccionArchivos = Context.Request.Files;
                string Data = Context.Request.Files.AllKeys[0].ToString();
                string[] data;
                data = Data.Split('-');
                string IDU = data[0];
                string tipodocumento = data[1];
                String NombreArchivo = "";
                NombreArchivo = IDU + "_" + ColeccionArchivos[0].FileName;
                String DatosArchivo = System.IO.Path.GetFileName(ColeccionArchivos[0].FileName);
                String CarpetaParaGuardar = Server.MapPath("Archivos") + "\\" + NombreArchivo;
                ModelDataDataContext GV = new ModelDataDataContext();

                int VDocumento = ValidaExistenciaDocumento(Convert.ToInt32(IDU), Convert.ToInt32(tipodocumento));
                int IDD;
                switch (VDocumento)
                {
                    case 1:
                        IDD = EliminarDocumentoExistente(Convert.ToInt32(IDU), Convert.ToInt32(tipodocumento));
                        ColeccionArchivos[0].SaveAs(CarpetaParaGuardar);
                        Documento DU = (from x in GV.Documento where x.IDD == IDD select x).SingleOrDefault();
                        DU.NombreD = NombreArchivo;
                        DU.RutaRelativaD = CarpetaParaGuardar;
                        GV.SubmitChanges();
                        Contexto.Response.ContentType = "application/json";
                        Contexto.Response.Write("{\"success\":true,\"msg\":\"" + NombreArchivo + "\"}");
                        Contexto.Response.End();
                        break;
                    case 0:
                        ColeccionArchivos[0].SaveAs(CarpetaParaGuardar);                        
                        Documento Documento = new Documento
                        {
                            NombreD = NombreArchivo,
                            TipoD = Convert.ToInt16(tipodocumento),
                            RutaRelativaD = CarpetaParaGuardar,
                        };

                        GV.Documento.InsertOnSubmit(Documento);
                        GV.SubmitChanges();

                        IDD = Documento.IDD;
                        Usuario US = (from s in GV.Usuario where s.IDU == Convert.ToInt32(IDU) select s).SingleOrDefault();
                        switch (Convert.ToInt32(tipodocumento))
                        {
                            case 0:
                                US.IDINED = IDD;
                                break;
                            case 1:
                                US.IDLicenciaConducirD = IDD;
                                break;
                            default:
                                break;
                        }                        
                        GV.SubmitChanges();
                        Contexto.Response.ContentType = "application/json";
                        Contexto.Response.Write("{\"success\":true,\"IDD\":"+IDD+",\"msg\":\"" + NombreArchivo + "\"}");
                        Contexto.Response.End();
                        break;
                    case -1:
                        break;
                    default:
                        break;
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

        /// <summary>
        /// Método Web para subir un documento Poliza De Seguro/ Tarjeta de Circulación
        /// </summary>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GuardarDocumentoVehiculo()
        {
            HttpContext Contexto = HttpContext.Current;
            HttpFileCollection ColeccionArchivos = Context.Request.Files;
            string Data = Context.Request.Files.AllKeys[0].ToString();
            string[] data;
            data = Data.Split('-');
            string IDV = data[0];
            string tipodocumento = data[1];
            String NombreArchivo = "";
            NombreArchivo = IDV + "_" + ColeccionArchivos[0].FileName;
            String DatosArchivo = System.IO.Path.GetFileName(ColeccionArchivos[0].FileName);
            String CarpetaParaGuardar = Server.MapPath("Archivos") + "\\" + NombreArchivo;
            ModelDataDataContext GV = new ModelDataDataContext();
            int IDD;
            int ValidaDocumentoVehiculo = ValidaExistenciaDocumentoVehiculo(Convert.ToInt32(IDV),Convert.ToInt32(tipodocumento));

            switch(ValidaDocumentoVehiculo)
            {
                case 0:
                    ColeccionArchivos[0].SaveAs(CarpetaParaGuardar);
                    Documento Documento = new Documento
                        {
                            NombreD = NombreArchivo,
                            TipoD = Convert.ToInt16(tipodocumento),
                            RutaRelativaD = CarpetaParaGuardar,
                        };

                    GV.Documento.InsertOnSubmit(Documento);
                    GV.SubmitChanges();

                    IDD = Documento.IDD;
                    Vehiculo VH = (from s in GV.Vehiculo where s.IDV == Convert.ToInt32(IDV) select s).SingleOrDefault();
                    switch(Convert.ToInt32(tipodocumento))
                    {
                        case 2:
                            VH.IDPolizaD = IDD;
                            break;
                        case 3:
                            VH.IDTarjetaCirculacionD = IDD;
                            break;
                        default:
                            break;
                    }
                    GV.SubmitChanges();
                    Contexto.Response.ContentType = "application/json";
                    Contexto.Response.Write("{\"success\":true,\"IDD\":"+IDD+",\"msg\":\"" + NombreArchivo + "\"}");
                    Contexto.Response.End();
                    break;
                case 1:
                    IDD = EliminarDocumentoVehiculo(Convert.ToInt32(IDV),Convert.ToInt32(tipodocumento));
                    ColeccionArchivos[0].SaveAs(CarpetaParaGuardar);
                    Documento DU = (from x in GV.Documento where x.IDD == IDD select x).SingleOrDefault();
                    DU.NombreD = NombreArchivo;
                    DU.RutaRelativaD = CarpetaParaGuardar;
                    GV.SubmitChanges();
                    Contexto.Response.ContentType = "application/json";
                    Contexto.Response.Write("{\"success\":true,\"msg\":\"" + NombreArchivo + "\"}");
                    Contexto.Response.End();
                    break;
                default:
                    break;
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GuardarFotoReporteVehiculo()
        {
            HttpContext Contexto = HttpContext.Current;
            HttpFileCollection ColeccionArchivos = Context.Request.Files;
            string Data = Context.Request.Files.AllKeys[0].ToString();
            String NombreArchivo = "";
            ModelDataDataContext GV = new ModelDataDataContext();
            int aux = 0;
            for (int i = 0; i < ColeccionArchivos.Count; i++)
            {

                NombreArchivo = "ReporteV" + Data + "_" + ColeccionArchivos[i].FileName;
                String DatosArchivo = System.IO.Path.GetFileName(ColeccionArchivos[i].FileName);
                String CarpetaParaGuardar = Server.MapPath("Archivos") + "\\" + NombreArchivo;
                ColeccionArchivos[i].SaveAs(CarpetaParaGuardar);
                Documento imagen = new Documento
                {
                    NombreD = NombreArchivo,
                    TipoD = 4,
                    RutaRelativaD = CarpetaParaGuardar
                };
                GV.Documento.InsertOnSubmit(imagen);
                GV.SubmitChanges();

                int IDD = imagen.IDD;

                Solicitud_Vehiculo IDSV = (from n in GV.Solicitud_Vehiculo where n.IDS == Convert.ToInt32(Data) select n).SingleOrDefault();

                Foto FotoDocumento = new Foto { 
                
                    IDS_V = IDSV.IDS_V,
                    IDD = IDD
                };
                GV.Foto.InsertOnSubmit(FotoDocumento);
                GV.SubmitChanges();
                aux++;
            }
            Contexto.Response.ContentType = "application/json";
            Contexto.Response.Write("{\"success\":true,\"msg\":\"Se Subieron los archivos\"}");
            Contexto.Response.End();
        }


        /// <summary>
        /// Función que valida si ya existe un documento asociado al vehiculo seleccionado
        /// </summary>
        /// <param name="IDV"></param>
        /// <param name="tipo"></param>
        /// <returns></returns>
        protected int ValidaExistenciaDocumentoVehiculo(int IDV, int tipo)
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo V = (from t in GV.Vehiculo where t.IDV == IDV select t).SingleOrDefault();
            List<Documento> DV = new List<Documento>();
            switch (tipo)
            {
                case 2:
                    DV = (from s in GV.Documento where s.IDD == V.IDPolizaD && s.TipoD == tipo select s).ToList();
                    break;
                case 3:
                    DV = (from s in GV.Documento where s.IDD == V.IDTarjetaCirculacionD && s.TipoD == tipo select s).ToList();
                    break;
                default:
                    break;
            }

            if (DV.Count > 0)
            {
                return 1; //Ya existe un documento para este vehiculo.
            }
            else
            {
                return 0; //No hay documentos para el IDV de vehículo recibido.
            }
        }

        /// <summary>
        /// Función que valida si ya existe un documento asociado al usuario seleccionado.
        /// </summary>
        /// <param name="IDU"></param>
        /// <param name="tipo"></param>
        /// <returns></returns>
        protected int ValidaExistenciaDocumento(int IDU, int tipo)
        {
            try
            {
                ModelDataDataContext GV = new ModelDataDataContext();

                Usuario US = (from t in GV.Usuario where t.IDU == IDU select t).SingleOrDefault();
                List<Documento> D = new List<Documento>();
                switch (tipo)
                {
                    case 0:
                        D = (from s in GV.Documento where s.IDD == US.IDINED && s.TipoD == tipo select s).ToList();
                        break;
                    case 1:
                        D = (from s in GV.Documento where s.IDD == US.IDLicenciaConducirD && s.TipoD == tipo select s).ToList();
                        break;
                    default:
                        break;
                }                
                if (D.Count > 0)
                {
                    return 1; //Ya existe un documento asociado a este usuario.
                }
                else
                {
                    return 0; //No hay documentos para el IDU de usuario recibido.
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        /// <summary>
        /// Función que elimina de manera física el documento que tenga asociado un vehiculo.
        /// </summary>
        /// <param name="IDV"></param>
        /// <param name="tipo"></param>
        /// <returns></returns>
        protected int EliminarDocumentoVehiculo(int IDV, int tipo)
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Vehiculo VH = (from s in GV.Vehiculo where s.IDV == IDV select s).SingleOrDefault();
            Documento DE = new Documento();
            Int32 IDD = 0;
            switch(tipo)
            {
                case 2:
                    DE = (from t in GV.Documento where t.IDD == VH.IDPolizaD select t).SingleOrDefault();
                    IDD = DE.IDD;
                    break;
                case 3:
                    DE = (from t in GV.Documento where t.IDD == VH.IDTarjetaCirculacionD select t).SingleOrDefault();
                    IDD = DE.IDD;
                    break;
                default:
                    break;
            }
            File.Delete(DE.RutaRelativaD);
            return DE.IDD;
        }

        /// <summary>
        /// Función que elimina de manera física el documento asociado a un usuario.
        /// </summary>
        /// <param name="IDU"></param>
        /// <param name="tipo"></param>
        /// <returns></returns>
        protected int EliminarDocumentoExistente(int IDU, int tipo)
        {
            ModelDataDataContext GV = new ModelDataDataContext();
            Usuario US = (from t in GV.Usuario where t.IDU == IDU select t).SingleOrDefault();
            Documento DE = new Documento();
            Int32 IDD = 0;
            switch(tipo)
            {
                case 0:
                    DE = (from s in GV.Documento where s.IDD == US.IDINED select s).SingleOrDefault();
                    IDD = DE.IDD;
                    break;
                case 1:
                    DE = (from s in GV.Documento where s.IDD == US.IDLicenciaConducirD select s).SingleOrDefault();
                    IDD = DE.IDD;
                    break;
                default:
                    break;
            }

            File.Delete(DE.RutaRelativaD);
            return IDD;
                        
        }
    }

