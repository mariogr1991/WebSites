<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" UICulture="es" Culture="es-MX" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- Hoja de estilos del framework y estilos personalizados  -->
<link href="CSS/style.css" rel="stylesheet" type="text/css"/>
<link href="CSS/Prueba.css" rel="stylesheet" type="text/css"/>
<link  rel="shortcut icon" href="IMG/ICONO_satisfaccion.ico"/>
<script type="text/javascript" src="JS/Funciones.js"></script>
<!-- DatePicker para el calendario---->
<link href="DatePicker/css/bootstrap-datetimepicker.css" rel="stylesheet" />
<!-- Font Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
<!-- Bootstrap core CSS -->
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"/>--%>
<link href="CSS/bootstrap.css" rel="stylesheet" />
<!-- Material Design Bootstrap -->
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/css/mdb.min.css" rel="stylesheet"/>--%>
<link href="CSS/mdb.css" rel="stylesheet" />
    <title>Explosión de Insumos</title>

</head>
<body>
    <!--NavBar--------------------------------------------------------------------------------------------------------->
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar" style="background-color:;">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>                          
        <img id="NavLogo" src="img/Logo.png" class="rounded float-left" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>          
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav" >
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalInfo">Manual<span class="sr-only"></span></a>
                </li>
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalInstrucciones">Instrucciones<span class="sr-only"></span></a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto nav-flex-icons">
                <li class="nav-item item-inactivo">
                    <i class="fa fa-user-circle-o fa-3x nav-link color-fuente-strong" style="text-align:center"></i>
                </li>
                <li class="nav-item item-inactivo">
                    <asp:HyperLink ID="NombreUsuario" runat="server" class="nav-link color-fuente-strong"></asp:HyperLink>                                 
                </li>
                <li class="nav-item item-inactivo">                    
                    <button type="button" class="btn btn-danger btn-rounded btn-sm" onclick="CerrarSesion()">Cerrar Sesión<i class="fa fa-power-off ml-2" aria-hidden="true"></i></button>                                                   
                </li>                 
            </ul>            
        </div>
    </nav>                 
    <hr />
    <!----------------------------------------------------------------------------------------------------------------------->
    <!--Pill/Tab Contenedor de información----------------------------------------------------------------------------------->
 <div class="container" style="margin-top:160px; max-width:1400px;">
  <h1 class="color-fuente text-center">BIENVENIDO</h1>  
  <h3 class="color-fuente text-center">AL REPORTE DE EXPLOSIÓN DE INSUMOS</h3>
  <!--Panel de selección------------------------------------------------------------------------------------------------------->     
  <ul class="nav nav-pills" style="margin-left:auto; margin-bottom:150px; margin-top:80px;">
    <li id="0"><a data-toggle="pill" href="#SubirArchivos"><i class="fa fa-file-text fa-3x nav-link color-fuente-strong" style="text-align:center"></i>SUBIR ARCHIVOS</a></li>
    <li id="1"><a data-toggle="pill" href="#Reportes"><i class="fa fa-list-alt fa-3x nav-link color-fuente-strong" style="text-align:center"></i>REPORTES</a></li> 
  </ul>      
  <!----------------------------------------------------------------------------------------------------------------------------->
  <!--Paneles por contenido------------------------------------------------------------------------------------------------------>
 <div class="tab-content">
<!-- Contenido de Subir Archivos------------------------------------------------------------>
     <div id="SubirArchivos" class="tab-pane fade">
<!-- Modal de Subir Archivos ------------------------------------------------->
<div class="modal fade" id="ModalSubirArchivos" tabindex="-1" role="dialog" aria-labelledby="ModalSubirArchivos" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente" id="exampleModalLabel">Subir Archivos</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-sm-12 col-lg-3">
                            <p class="red-text">*Recuerde subir unicamente documentos Excel</p>                                                          
                            <div id="filename"></div>
                            <div id="progress"></div>
                            <div id="progressBar"></div>   
                            <input class="btn-cyan" type="file" name="Excel" title="" id="NombreArchivo"/>  
                        </div>
                        <div class="col-sm-12 col-lg-4">
                           <div class="md-form">
                                <i class="fa fa-hdd-o prefix blue-text"></i>                           
                                <label for="TipoArchivo">Tipo Documento</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraEI" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="TipoArchivo" onchange="CambioTipoDocumento()">
                                    <option value="-1">Seleccione una opción...</option>
                                    <option value="0">Final de periodo</option>
                                    <option value="1">Variación</option>                                    
                                    <option value="2">Detalle Insumo</option>                                                                        
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-wrench prefix blue-text"></i>                           
                                <label for="SubTipoArchivo">Área Operativa</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="INESTA" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="SubTipoArchivo" onchange="">
                                    <option value="-1">Seleccione una opción...</option>
                                    <option value="0">Piso</option>
                                    <option value="1">Cocina</option>                                    
                                    <option value="2">Panaderia</option>                                                                        
                                </select>
                           </div>
                           <div id="SelectDetalleInsumo">
                               <div class="md-form">
                                    <i class="fa fa-hdd-o prefix blue-text"></i>                           
                                    <label for="Insumo">Insumo</label>
                               </div>
                               <div class="md-form">
                                    <input type="text" id="InputextraEINS" class="form-control validate" readonly="true"/>
                                    <select class="form-control" id="Insumo" onchange="">
                                    </select>
                               </div>
                           </div>                           
                        </div>
                        <div class="col-sm-12 col-lg-5">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="FechaIniI" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="FechaIniI">Fecha Inicial</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="FechaFinI" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="FechaFinI">Fecha Final</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-building-o prefix blue-text"></i>                           
                                <label for="UnidadNegocio">Unidad de Negocio</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraEIIDUN" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="UnidadNegocio" onchange="ObtenerInsumos()">                                                                       
                                </select>
                           </div>
                        </div>                       
                     </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="SubirArchivo()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Termina Modal de Subir Archivos ------------------------------------->
<!------ Modal de Subir Archivo con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="SubirArchivoExito" tabindex="-1" role="dialog" aria-labelledby="SubirArchivoExito" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-success" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡Éxito!</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>            
          <div class="modal-body">  
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <div id="MensajeSubirArchivoExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Subir Archivo con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al Subir Archivo -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorSubirArchivo" tabindex="-1" role="dialog" aria-labelledby="ErrorSubirArchivo" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡UPS! Algo no va bien</p>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>          
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <div id="MensajeErrorSubirArchivo">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al Subir Archivo -------------------------------------------------------------------------------------------->
         <div class="text-center">
            <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalSubirArchivos()" data-target="#ModalSubirArchivos">Subir Archivos<i class="fa fa-cloud-upload ml-2 color-fuente-strong" aria-hidden="true"></i></button>                     
        </div>
     </div> 
<!-- Termina contenido de Subir Archivo ------------------------------------------------->     
<!-- Inicia contenido de Reportes --------------------------------------------------------------->
     <div id="Reportes" class="tab-pane fade">
<!-- Modal de Reporte Concentrado ------------------------------------------------->
<div class="modal fade" id="ModalReporteConcentrado" tabindex="-1" role="dialog" aria-labelledby="ModalReporteConcentrado" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVARCLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Reporte Concentrado</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">                                                    
                            <div class="col-lg-4 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaIni">Fecha Inicio</label>
                                </div>
                                <div class="md-form">                                                      
                                    <label for="ReporteUnidadNegocio">Unidad de Negocio</label>
                                </div>
                                <div class="md-form">
                                    <input type="text" id="ReporteAD" class="form-control validate" readonly="true"/>
                                    <select class="form-control" id="ReporteUnidadNegocio" onchange="">                                    
                                    </select>
                               </div>
                               <div class="md-form">                                                      
                                    <label for="ReporteAreaOperativa">Área Operativa</label>
                                </div>
                                <div class="md-form">
                                    <input type="text" id="ReporteAO" class="form-control validate" readonly="true"/>
                                    <select class="form-control" id="ReporteAreaOperativa" onchange="">
                                        <option value="-1">Seleccione una opción...</option>
                                        <option value="0">Piso</option>
                                        <option value="1">Cocina</option>                                    
                                        <option value="2">Panaderia</option>                                 
                                    </select>
                               </div>                                                                 
                            </div>
                            <div class="col-lg-4 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaFin">Fecha Fin</label>
                                </div>
                                <div class="md-form">
                                    <i class="fa fa-cart-arrow-down prefix grey-text"></i>
                                    <input type="text" id="ProductoRE" class="form-control validate"/>
                                    <label for="ProductoRE">Insumo</label>
                                </div>
                                <div class="row" style="margin-left:20px;">
                                    <label class="switchpersonalizado">
                                        <input type="checkbox" id="CheckCostos" name="CheckCostos"/>
                                        <span class="slider round"></span>
                                    </label>                       
                               <span>Costos</span>                       
                        </div>  
                            </div>          
                            <div class="col-lg-4 col-sm-12">
                                <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearTablaReporteConcentrado()">Buscar<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>                                
                            </div>
                            <div id="TablaReporteConcentrado">
                                                                
                            </div>                                    
                     </div>  
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Reporte Concentrado ------------------------------------->
<!-- Modal de Error Reporte -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorReporteConcentrado" tabindex="-1" role="dialog" aria-labelledby="ErrorReporteConcentrado" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡UPS! Algo no va bien</p>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>          
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <div id="MensajeErrorReporteConcentrado">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Reporte -------------------------------------------------------------------------------------------->
<!-- Modal de Reporte Estadisticas ------------------------------------------------->
<div class="modal fade" id="ModalReporteEstadisticas" tabindex="-1" role="dialog" aria-labelledby="ModalReporteEstadisticas" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVARELogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Gráfica</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">  
                       <div class="col-sm-12 col-lg-6">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix blue-text"></i>
                                    <input type="text" id="FechaIniGrafica" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" onchange="ObtenerInsumosGrafica()"/>
                                    <label for="FechaIniGrafica">Fecha Inicio</label>
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix blue-text"></i>
                                    <input type="text" id="FechaFinGrafica" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" onchange="ObtenerInsumosGrafica()"/>
                                    <label for="FechaFinGrafica">Fecha Fin</label>
                                </div>
                                </div>                                
                                <div class="md-form">                                
                                    <div class="md-form">
                                        <i class="fa fa-hdd-o prefix blue-text"></i>                           
                                        <label for="Insumo">Insumo</label>
                                </div>
                                <div class="md-form">
                                        <input type="text" id="InputExtraInsumoGrafica" class="form-control validate" readonly="true"/>
                                        <select class="form-control" id="GraficaInsumoConcentrado" onchange="">
                                        </select>
                               </div> 
                               <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearGraficaInsumoFecha()">Buscar Insumo<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>                                
                           </div> 
                           <div id="GFechaInsumoUnidad" class="col-lg-12 col-sm-12">                                                
                           </div>   
                         </div>                                                 
                         <div class="col-sm-12 col-lg-6">
                              <div class="md-form">                                        
                               <div class="md-form">
                                        <i class="fa fa-building prefix blue-text"></i>                           
                                        <label for="UnidadReporteInsumo">Unidad</label>
                               </div>
                               <div class="md-form">
                                        <input type="text" id="InputExtraInsumoUnidadReporte" class="form-control validate" readonly="true"/>
                                        <select class="form-control" id="UnidadReporteInsumo" onchange="">
                                            
                                        </select>
                               </div>  
                               <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearGraficaInsumoFechaArea()">Buscar Insumo por Área Operativa<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>                                
                               </div>
                           <div id="GFechaInsumoArea" class="col-lg-12 col-sm-12">                                                
                           </div>  
                         </div>                                                                        
                     </div>  
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Reporte Estadisticas ------------------------------------->
<!-- Modal de Error Reporte -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorReporte" tabindex="-1" role="dialog" aria-labelledby="ErrorReporte" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡UPS! Algo no va bien</p>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>          
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <div id="MensajeErrorReporte">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Reporte -------------------------------------------------------------------------------------------->
        <div class="text-center">
          <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalReporte()" data-target="#ModalReporteConcentrado">Reportes<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>                  
          <button type="button" class="btn btn-primary btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalReporteEstadisticas()" data-target="#ModalReporteEstadisticas">Estadisticas<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>                            
        </div>
     </div>
<!-- Termina contenido de Reportes -------------------------------------------------------------->
  </div>
  <!----Finaliza Panel por Contenido------------------------------------------------------------------------------------------------------------------------>
</div>
 <!---Finaliza Pill/Tab-------------------------------------------------------------------------------------------------------------------->
 <!-- Modal de Ayuda del Portal -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalInfo" tabindex="-1" role="dialog" aria-labelledby="ModalInfo" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-info" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Manual</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>  
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>                  
                  <a type="button" class="btn btn-primary">Ir al manual de usuario.<i class="fa fa-question-circle-o ml-1"></i></a>              
              </div>
          </div>                                              
      </div>      
  </div>
  </div>
<!-- Finaliza Modal de Ayuda del Portal ----------------------------------------------------------------------------------------->
 <!-- Modal de Ayuda de Instrucciones -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalInstrucciones" tabindex="-1" role="dialog" aria-labelledby="ModalInstrucciones" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-info" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Instrucciones</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>  
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>                  
                       <div class="col-lg-12 col-sm-12" style="margin-top:10px; margin-bottom:60px;">
                            <h4>Instrucciones: </h4>
                            <p> Califica  de la siguiente forma con base al comportamiento observado durante el entrenamiento </p>
                            <div class="col-lg-12 col-sm-12">
                                <p>Inaceptable : No se cumple con el requisito.</p>
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star-o amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star-o amber-text fa-3x" aria-hidden="true"></i>                                
                                <br />
                                <p>Bueno : Cumple con lo esperado, pero podria mejorar.</p>                                 
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star-o amber-text fa-3x" aria-hidden="true"></i>
                                <br />
                                <p>Excelente : Supera las expectativas.</p>
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>
                                <i class="fa fa-star amber-text fa-3x" aria-hidden="true"></i>                                
                            </div>                                               
                      </div>              
              </div>
          </div>                                              
      </div>      
  </div>
  </div>
<!-- Finaliza Modal de Ayuda de Instrucciones ----------------------------------------------------------------------------------------->
</body>
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.13.0/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/js/mdb.min.js"></script>
<script src="http://momentjs.com/downloads/moment.min.js"></script>
<script src="DatePicker/js/bootstrap-datetimepicker.js"></script>
<script src="DatePicker/js/locales/bootstrap-datetimepicker.es.js"></script>
<script src="Js/TEST.js"></script>
<script src="Js/jquery.table2excel.js"></script>
<script type="text/javascript">

    $(document).ready(function () {

        $('.form_date').datetimepicker({
            format: 'dd-mm-yyyy',
            language: 'es',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0,

        });

        $("#SelectDetalleInsumo").hide();


    });

</script>