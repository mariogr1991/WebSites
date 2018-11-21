<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- Hoja de estilos del framework y estilos personalizados  -->
<link href="CSS/style.css" rel="stylesheet" type="text/css"/>
<link href="CSS/Prueba.css" rel="stylesheet" type="text/css"/>
<link  rel="shortcut icon" href="img/auto.png"/>
<script type="text/javascript" src="Js/Funciones.js"></script>
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
    <title>Portal de Gestión Vehicular</title>
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
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalInfo">Ayuda<span class="sr-only"></span></a>
                </li>
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalNumeros">Número de Emergencia<span class="sr-only"></span></a>
                </li>
                <li class="nav-item dropdown item-inactivo">
                    <a class="nav-link dropdown-toggle color-fuente-strong" id="Reglamentos" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Reglamentos de Transito</a>
                    <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" target="_blank" href="http://www.ssp.df.gob.mx/reglamentodetransito/documentos/nuevo_reglamento_transito.pdf ">CDMX</a>
                        <a class="dropdown-item" target="_blank" href="http://legislacion.edomex.gob.mx/sites/legislacion.edomex.gob.mx/files/files/pdf/rgl/vig/rglvig079.pdf">Estado de México</a>
                        <a class="dropdown-item" target="_blank" href="http://www.ordenjuridico.gob.mx/Estatal/QUERETARO/Reglamentos/QROREG09.pdf">Querétaro</a>
                        <a class="dropdown-item" target="_blank" href="http://datos.pachuca.gob.mx/transparencia/4/PDFS/reglamento_de_transito_y_vialidad.pdf">Hidalgo</a>
                    </div>
                </li>
                <li class="nav-item dropdown item-inactivo">
                    <a class="nav-link dropdown-toggle color-fuente-strong" id="Manuales" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Manuales</a>
                    <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                  <a id="Manual1" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGCREARSOLICITUD.pdf" target="_blank">¿Cómo crear una solicitud?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual2" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGREALIZARAJUSTES.pdf" target="_blank">¿Cómo realizar ajustes?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual3" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGAGREGARCONDICIONESINICIALESYCONCLUIRVIAJE.pdf" target="_blank">¿Cómo registar las condiciones iniciales?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual4" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGAGREGARCONDICIONESINICIALESYCONCLUIRVIAJE.pdf" target="_blank">¿Cómo concluir una solicitud?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual5" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGSOLICITARESCALA.pdf" target="_blank">¿Cómo solicitar una escala?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual6" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGAUTORIZARSOLICITUDYSOLICITARAJUSTES.pdf" target="_blank">¿Cómo autorizar una solicitud?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual7" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGASIGNARVEHÍCULOCANCELARYSOLICITARAJUSTES.pdf" target="_blank">¿Cómo asignar un vehículo?<i class="fa fa-question-circle-o ml-1"></i></a>
                  <a id="Manual8" class="dropdown-item" href="http://mrc.sytes.net/GestionVehicular/Manuales/MOLOGASIGNARESCALA.pdf" target="_blank">¿Cómo asignar una escala?<i class="fa fa-question-circle-o ml-1"></i></a>
                    </div>
                </li>
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalTips">Tips<span class="sr-only"></span></a>
                </li>
                <li class="nav-item item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="modal" data-target="#ModalCostos">Costos<span class="sr-only"></span></a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto nav-flex-icons">
                <li class="nav-item item-inactivo">
                    <i class="fa fa-user-circle-o fa-3x nav-link color-fuente-strong" style="text-align:center"></i>
                </li>
                <li class="nav-item item-inactivo">
                    <asp:HyperLink ID="RolUsuario" runat="server" class="nav-link color-fuente-strong text"></asp:HyperLink>                                                    
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
  <h3 class="color-fuente text-center">AL CONTROL DE VEHÍCULOS UTILITARIOS</h3>
  <!--Panel de selección------------------------------------------------------------------------------------------------------->     
  <ul class="nav nav-pills" style="margin-left:auto; margin-bottom:150px; margin-top:80px;">
    <li id="0"><a data-toggle="pill" href="#DisponibilidadVehículos"><i class="fa fa-line-chart fa-3x nav-link color-fuente-strong" style="text-align:center"></i>RUTAS DISPONIBLES</a></li>
    <li id="1"><a data-toggle="pill" href="#Principal"><i class="fa fa-folder fa-3x nav-link color-fuente-strong" style="text-align:center"></i>SOLICITUDES</a></li>
    <li id="2"><a data-toggle="pill" href="#Autorizacion"><i class="fa fa-rocket fa-3x nav-link color-fuente-strong" style="text-align:center"></i>AUTORIZACIÓN</a></li>
    <li id="3"><a data-toggle="pill" href="#Asignacion"><i class="fa fa-exchange fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ASIGNACIÓN DE VEHÍCULO</a></li> 
    <li id="4"><a data-toggle="pill" href="#VehiculosAsignados"><i class="fa fa-automobile fa-3x nav-link color-fuente-strong" style="text-align:center"></i>VEHÍCULOS ASIGNADOS</a></li> 
    <li id="5"><a data-toggle="pill" href="#Administracion"><i class="fa fa-users fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ADMINISTRACIÓN</a></li>    
    <li id="6"><a data-toggle="pill" href="#Reportes"><i class="fa fa-list-alt fa-3x nav-link color-fuente-strong" style="text-align:center"></i>REPORTES</a></li> 
  </ul>      
  <!----------------------------------------------------------------------------------------------------------------------------->
  <!--Paneles por contenido------------------------------------------------------------------------------------------------------>
 <div class="tab-content">
<!-- Contenido de Disponibilidad Vehículos ------------------------------------------------------->
    <div id="DisponibilidadVehículos" class="tab-pane fade">            
<!--Modal de Disponibilidad de Vehículos--------------------------------------------------------------------->    
      <div class="modal fade" id="ModalDisponibilidadV" tabindex="-1" role="dialog" aria-labelledby="ModalDisponibilidadV" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MDVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Disponibilidad de Vehículos</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <h4>Seleccione un rango de fecha salida</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">                                
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="BFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="BFechaSalidaIni">Inicio</label>
                           </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="BFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="BFechaSalidaFin">Fin</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="ObtenerDisponibilidadVehiculo()">Buscar</button>
                           </div>
                        </div>                         
                    </div>
                    <div id="TablaDisponibilidadV" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!------Finaliza modal Disponibilidad de vehículos------------------------------------------>

<!-- Modal de Error de Rango de Fechas Disnponibilidad de Vehículos-------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorRangoFechas" tabindex="-1" role="dialog" aria-labelledby="ErrorRangoFechas" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡UPS! Algo no va bien</p>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>          
          <div class="modal-body">
              <div id="MensajeErrorRangoFechas" class="text-center">
                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Rango de Fechas Disnponibilidad de Vehículos-------------------------------------------------------------------------------------------->
<!--Modal de Agregar Escalas ---------------------------------->        
<div class="modal fade right" id="AgregarEscalaSolicitudExistente" tabindex="-1" role="dialog" aria-labelledby="AgregarEscalaSolicitudExistente" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="TituloEscala">Solicitar Escala</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div id="CuerpoAgregarEscala" class="modal-body">
                <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="ESolicitante" class="form-control validate" readonly="true" value="x"/>
                                <input id="EIDU" readonly="true" hidden="hidden"/>
                                <label for="ESolicitante">Solicitante</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="EPuesto" class="form-control validate" readonly="true" value="x"/>
                                <label for="EPuesto">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>
                                <input type="text" id="EArea" class="form-control validate" readonly="true" value="x"/>
                                <label for="EArea">Área</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-phone prefix red-text"></i>
                                <input type="text" id="ETelefono" class="form-control validate" value="Sin Télefono"/>
                                <label for="ETelefono">Teléfono</label>
                          </div>                               
                        </div>
                        <div class="col-lg-6 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="ENoSolicitud" class="form-control validate" value="0"/>
                                <label for="ENoSolicitud">No. Solicitud</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>
                                <input type="text" id="EDestino" class="form-control validate"/>
                                <label for="EDestino">Destino</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="EArribo" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii"/>
                                <label for="EArribo">Hora de Arribo Aprox.</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-tags prefix red-text"></i>
                                <input type="text" id="EMotivo" class="form-control validate" />
                                <label for="EMotivo">Motivo</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="EObservaciones" class="md-textarea form-control" rows="2"></textarea>
                                <label for="EObservaciones">Observaciones</label>
                         </div>                     
                        </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar <i class="fa fa-thumbs-o-down ml-1"></i></button>
                <button type="button" class="btn btn-default" onclick="AgregarEscalaSolicitudExistente()">Solicitar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal de Disponibilidad de Vehículos------------------------------------------------------------>
<!------ Modal de Escala Registrada con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EscalaRegistrada" tabindex="-1" role="dialog" aria-labelledby="EscalaRegistrada" aria-hidden="true">
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
                  <div id="MensajeEscalaRegistradaExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Escala Registrada con Éxito------------------------------------------------------------------------->
<!-- Modal de Error de Escala-------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEscala" tabindex="-1" role="dialog" aria-labelledby="ErrorEscala" aria-hidden="true">
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
                  <div id="MensajeErrorEscala">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error de Escala-------------------------------------------------------------------------------------------->
       <div class="text-center">
           <button type="button" class="btn btn-indigo btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalDisponibilidadVehiculo()" data-target="#ModalDisponibilidadV">Rutas Disponibles<i class="fa fa-hourglass-2 ml-2 color-fuente-strong" aria-hidden="true"></i></button>           
       </div>          
    </div>
<!-- Finaliza Contenido de Disponibilidad Vehículos ----------------------------------------------> 
<!--Contenido de Crear Solicitud ----------------------------------------->    
    <div id="Principal" class="tab-pane fade">       
      <!--Modal de Creación de Solicitud----------------------------------------------------------------------------------------->             
      <div class="modal fade" id="ModalCrearSolicitud" tabindex="-1" role="dialog" aria-labelledby="ModalCrearSolicitud" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCSLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Elaborar Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>                
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="Solicitante" class="form-control validate" readonly="true" value="x"/>                                
                                <label for="Solicitante">Solicitante</label>                                
                           </div>
                            <input type="text" id="IdUsuario" class="form-control validate" readonly="true" value="" hidden="hidden"/>
                           <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="Puesto" class="form-control validate" readonly="true" value="x" />
                                <label for="Puesto">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>
                                <input type="text" id="Area" class="form-control validate" readonly="true" value="x" />
                                <label for="Area">Área</label>
                          </div>                          
                          <div class="md-form">
                                <i class="fa fa-phone prefix red-text"></i>
                                <input type="text" id="Telefono" class="form-control validate" value="Sin Télefono" />
                                <label for="Telefono">Teléfono</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-stethoscope prefix grey-text"></i>
                                <input type="text" id="NSS" class="form-control validate" value="Sin NSS Registrado" readonly="true" data-toggle="tooltip" data-placement="top" title="Motivo de la Solicitud"/>
                                <label for="NSS">NSS</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-user prefix red-text"></i>
                                <input type="text" id="SolicitanteContactoEmergencia" class="form-control validate" value=" "/>                                
                                <label for="SolicitanteContactoEmergencia">Contacto en caso de emergencia</label>                                
                          </div>
                          <div class="md-form">
                                <i class="fa fa-phone prefix red-text"></i>
                                <input type="text" id="TelefonoEmergencia" class="form-control validate" value=" " />
                                <label for="TelefonoEmergencia">Teléfono en caso de emergencia</label>
                          </div>
                          <div class="md-form">
                              <button type="button" class="btn btn-info btn-rounded btn-lg" data-toggle="modal" data-target="#ModalINE">INE<i class="fa fa-address-card-o ml-2" aria-hidden="true"></i></button>
                              <button type="button" class="btn btn-info btn-rounded btn-lg" data-toggle="modal" data-target="#ModalLicenciaConducir">Licencia de Conducir<i class="fa fa-address-card-o ml-2" aria-hidden="true"></i></button>
                          </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                          <div class="md-form">
                                <i class="fa fa-tags prefix red-text"></i>
                                <input type="text" id="Motivo" class="form-control validate" />
                                <label for="Motivo">Motivo</label>
                          </div>
                            <div class="md-form">
                                <i class="fa fa-briefcase prefix grey-text"></i>
                                <input type="text" id="Origen" class="form-control validate" readonly="true" value="CORPORATIVO"/>
                                <label for="Origen">Origen</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>                           
                                <label for="Destinos">Destino</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="Inputextra" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="Destinos" onchange="OnChangeSelectDestinosCreacionSolicitud()">                                    
                                </select>
                           </div>
                           <div id="OtroDestinoOculto" class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>
                                <input type="text" id="OtroDestino" class="form-control validate" onblur="OnBlurOtroDestino()"/>                                
                                <label for="OtroDestino">Otro</label>
                           </div>                          
                           <div class="md-form">
                                <i class="fa fa-calendar prefix red-text"></i>
                                <input type="text" id="FechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" onchange="OnChangeFecha()"/>
                                <label for="FechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="HoraSalida" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii"/>
                                <label for="HoraSalida">Hora Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix red-text"></i>
                                <input type="text" id="FechaRegreso" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" onchange="OnChangeFecha()"/>
                                <label for="FechaRegreso">Fecha Regreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="HoraRegreso" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii"/>
                                <label for="HoraRegreso">Hora Regreso</label>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#AgregarEscalas" onclick="LimpiarEscalas()" >Agregar Escalas</button>
                           </div>                           
                        </div> 
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-road prefix grey-text"></i>
                                <input type="text" id="Ruta" class="form-control validate" readonly="true" value="Sin ruta"/>
                                <label for="Ruta">Ruta</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="Observaciones" class="md-textarea form-control" rows="4"></textarea>
                                <label for="Observaciones">Observaciones</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-odnoklassniki prefix grey-text"></i>
                                <input type="text" id="Disponible" class="form-control validate" readonly="true" value="4"/>
                                <label for="Disponible">Lugares Disponibles</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="Dias" class="form-control validate" readonly="true" value="0" />
                                <label for="Dias">Número de Días</label>
                           </div>
                            <div class="row" style="margin-left:25px; margin-top:25px;">
                                <p>¿Requiere Chofer?</p>
                                <label class="contenedor">Si
                                <input type="radio" name="choferCS" id="SI" value="True"/>
                                <span class="marcado"></span>
                            </label>
                            <label class="contenedor">No
                                <input type="radio" name="choferCS" id="NO" value="False"/>
                                <span class="marcado"></span>
                            </label>                            
                            </div>                            
                        </div>                       
                    </div>                                                                                                                                                                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button id="EnviarSolicitud" class="btn btn-default" data-toggle="modal" onclick="ConfirmarSolicitud()">Enviar <i class="fa fa-paper-plane-o ml-1"></i></button>
            </div>
        </div>
    </div>
</div>

<!------Finaliza modal de creación de solicitud ----------------------------------------------------------------------------------------------------------------------------->
<!------ Modal de Solicitud Registrada con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="Registrada" tabindex="-1" role="dialog" aria-labelledby="Registrada" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-success" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">¡Éxito! Solicitud Enviada</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>            
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>Su solicitud ha sido generada con éxito, recuerde que el director de su área debe de aprobar la solicitud.</p>
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitud Registrada con Éxito------------------------------------------------------------------------->
<!-- Modal de Error Solicitud--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorSolicitud" tabindex="-1" role="dialog" aria-labelledby="ErrorSolicitud" aria-hidden="true">
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
                  <div id="MensajeErrorSolicitud">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Solicitud-------------------------------------------------------------------------------------------->
<!--Modal de Agregar Escalas ---------------------------------->       
<div class="modal fade right" id="AgregarEscalas" tabindex="-1" role="dialog" aria-labelledby="AgregarEscalas" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="exampleModalLabel">Agregar Escalas</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="nextinput" value="0" readonly="true" hidden="hidden"/>
                <label class="red-text">Recuerde agregar todas las escalas que vaya a requerir y dar click en Guardar.</label>                                
                <div class="col-12" id="CampoDinamico">

                </div>
                <button type="button" class="btn btn-warning" onclick="AgregaCampo()"><i class="fa fa-plus-square-o fa-4x"></i> Agregar Escala</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar sin cambios</button>
                <button type="button" class="btn btn-default" onclick="CalcularRutaEscalas()">Guardar Escalas</button>
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal de Agregar Escalas ------------------------->
<!--Modal de Ver/Subir INE ------------------------------------->
<div class="modal fade" id="ModalINE" tabindex="-1" role="dialog" aria-labelledby="ModalINE" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="TituloModalINE">INE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                   <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>                                                          
                   <div id="filename"></div>
                   <div id="progress"></div>
                   <div id="progressBar"></div>   
                   <input class="btn-cyan" type="file" name="SubirINEEEEE" title=""/>                                                                                 
                   <button type="button" class="btn btn-default" data-toggle="modal" data-target="#ImagenINE">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Ver/Subir INE ------------------------------->
<!--Modal Imagen INE ------------------------------------------->
<div class="modal fade" id="ImagenINE" tabindex="-1" role="dialog" aria-labelledby="ImagenINE" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="VerINEIDD" hidden="hidden" readonly="true"/>
                <img id="VerINE" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen INE ---------------------------------->
<!--Modal de Ver/Subir Licencia de Conducir ------------------------------------->
<div class="modal fade" id="ModalLicenciaConducir" tabindex="-1" role="dialog" aria-labelledby="ModalLicenciaConducir" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="TituloModalLC">Licencia de Conducir</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>                
                <div id="filenameLC"></div>
                <div id="progressLC"></div>
                <div id="progressBarLC"></div>   
                <input class="btn-cyan" type="file" name="SubirLC"/>   
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#ImagenLC">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Ver/Subir Licencia de Conducir ------------------------------->
<!--Modal Imagen Licencia de Conducir ------------------------------------------->
<div class="modal fade" id="ImagenLC" tabindex="-1" role="dialog" aria-labelledby="ImagenLC" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="VerLCIDD" hidden="hidden" readonly="true"/>
                <img id="VerLC" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen Licencia de Conducir ---------------------------------->                          

<!-- Modal de Solicitudes Pendientes de Ajustes ------------------------------------------------------------->
      <div class="modal fade" id="ModalSolicitudAjustes" tabindex="-1" role="dialog" aria-labelledby="ModalSolicitudAjustes" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MSALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Pendiente de Ajustes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <h3>Solicitudes</h3>
                            <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="AFechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="AFechaSalida">Fecha Salida</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaTablaAjusteSolicitud()">Buscar</button>
                           </div>
                        </div>                         
                    </div>
                    <div id="TablaAjusteSolicitud" class="col-12">
                                                                                                                                                                  
                    </div>                    
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <h3>Escalas</h3>
                            <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="ANoSolicitud" class="form-control validate"/>
                                <label for="ANoSolicitud">No. Solicitud</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaAjusteEscala()">Buscar</button>
                           </div>
                        </div>                         
                    </div>
                    <div id="TablaAjusteEscala" class="col-12">
                                                                                                                                                                  
                    </div>     
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitudes Pendientes de Ajustes ---------------------------------------------------->
<!-- Modal de Ajustar Solicitud ----------------------------------------------------------------------------->
<div class="modal fade" id="ModalAjustarSolicitud" tabindex="-1" role="dialog" aria-labelledby="ModalAjustarSolicitud" aria-hidden="true" style="overflow:auto">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MASLogo" src="img/Logo.png" class="rounded" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title font-weight-bold color-fuente text-center" id="TituloModalAjustarSolicitud">Ajustar Solicitud</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <input id="ASIDS" readonly="true" hidden="hidden"/>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="ASObservacionesAjustes" class="md-textarea form-control red-text" rows="4" readonly="readonly" >" "</textarea>
                                <label for="ASObservacionesAjustes">Ajustes Solicitados</label>
                           </div>
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="ASSolicitante" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASSolicitante">Solicitante</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="ASPuesto" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASPuesto">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>
                                <input type="text" id="ASArea" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASArea">Área</label>
                          </div>                          
                          <div class="md-form">
                                <i class="fa fa-phone prefix red-text"></i>
                                <input type="text" id="ASTelefono" class="form-control validate" value=" "/>
                                <label for="ASTelefono">Teléfono</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-stethoscope prefix grey-text"></i>
                                <input type="text" id="ASNSS" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASNSS">NSS</label>
                          </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                          <div class="md-form">
                                <i class="fa fa-tags prefix red-text"></i>
                                <input type="text" id="ASMotivo" class="form-control validate" value=" "/>
                                <label for="ASMotivo">Motivo</label>
                          </div>
                            <div class="md-form">
                                <i class="fa fa-briefcase prefix grey-text"></i>
                                <input type="text" id="ASOrigen" class="form-control validate" readonly="true" value="CORPORATIVO"/>
                                <label for="ASOrigen">Origen</label>
                           </div> 
                           <div class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>                           
                                <label for="ASDestino">Destino</label>
                           </div>
                           <div class="md-form">
                                <input type="text" id="InputextraDestinoA" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="ASDestino" onchange="OnChangeSelectDestinosAjusteSolicitud()">                                    
                                </select>
                           </div>
                           <div id="OtroDestinoOcultoA" class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>
                                <input type="text" id="OtroDestinoA" class="form-control validate" value=" " onblur="OnBlurOtroDestinoAjustes()"/>                                
                                <label for="OtroDestino">Otro</label>
                           </div>        
                           <div class="md-form">
                                <i class="fa fa-calendar prefix red-text"></i>
                                <input type="text" id="ASFechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" " onchange="OnChangeFechaAjustes()"/>
                                <label for="ASFechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="ASHoraSalida" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="ASHoraSalida">Hora Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix red-text"></i>
                                <input type="text" id="ASFechaRegreso" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" " onchange="OnChangeFechaAjustes()"/>
                                <label for="ASFechaRegreso">Fecha Regreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="ASHoraRegreso" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="ASHoraRegreso">Hora Regreso</label>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#ASAgregarEscalas" onclick="LimpiarEscalas()" >Agregar Escalas</button>
                           </div>                           
                        </div> 
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-road prefix grey-text"></i>
                                <input type="text" id="ASRuta" class="form-control validate" value=" "/>
                                <label for="ASRuta">Ruta</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="ASObservaciones" class="md-textarea form-control" rows="4" >" "</textarea>
                                <label for="ASObservaciones">Observaciones</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-odnoklassniki prefix grey-text"></i>
                                <input type="text" id="ASDisponible" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASDisponible">Lugares Disponibles</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="ASDias" class="form-control validate" readonly="true" value=" "/>
                                <label for="ASDias">Número de Días</label>
                           </div>
                            <div class="row">
                                <p>¿Requiere Chofer?</p>
                                <label class="contenedor">Si
                                <input id="ASSI" type="radio" name="choferA" value="True"/>
                                <span class="marcado"></span>
                            </label>
                            <label class="contenedor">No
                                <input id="ASNO" type="radio" name="choferA" value="False"/>
                                <span class="marcado"></span>
                            </label>                            
                            </div>                            
                        </div>                       
                    </div> 
            </div>
            <div class="modal-footer d-flex justify-content-center"> 
                <button id="ASGuardarAjustesSolicitud" class="btn btn-default" data-toggle="modal" onclick="GuardarAjustesSolicitud()">Guardar y Enviar <i class="fa fa-paper-plane-o ml-1"></i></button>               
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Ajustar Solicitud -------------------------------------------------------------------->
<!--Modal de Agregar Escalas En Ajuste de Solicitud---------------------------------->       
<div class="modal fade right" id="ASAgregarEscalas" tabindex="-1" role="dialog" aria-labelledby="AgregarEscalas" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="ASTituloAgregarEscalas">Agregar Escalas</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="ASnextinput" value="0" readonly="true" hidden="hidden"/>
                <label class="red-text">Recuerde agregar todas las escalas que vaya a requerir y dar click en Guardar.</label>                
                <div class="col-12" id="ASCampoDinamico">

                </div>
                <button type="button" class="btn btn-warning" onclick="ASAgregaCampo()"><i class="fa fa-plus-square-o fa-4x"></i> Añadir Escala</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar sin cambios</button>
                <button type="button" class="btn btn-default" onclick="CalcularRutaEscalasAjustes()">Guardar Escalas</button>
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal de Agregar Escalas En Ajuste de Solicitud ------------------------->
<!------ Modal de Ajustes en Solicitud realizados con éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AjustesSolicitudExito" tabindex="-1" role="dialog" aria-labelledby="AjustesSolicitudExito" aria-hidden="true">
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
                  <p>Los cambios se han guardado.</p>
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Ajustes en Solicitud realizados con éxito------------------------------------------------------------------------->
<!-- Modal de Error Ajustes de Solicitud--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorSolicitudAjustes" tabindex="-1" role="dialog" aria-labelledby="ErrorSolicitudAjustes" aria-hidden="true">
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
                  <div id="MensajeErrorSolicitudAjustes">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Ajustes de Solicitud------------------------------------------------------------------------------------------->
<!-- Modal de Ajustar Escala --------------------------------------------------------->
<div class="modal fade" id="ModalAjustarEscala" tabindex="-1" role="dialog" aria-labelledby="ModalAjustarEscala" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente" id="TituloAjustarEscala">Ajustar Escala</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-sm-12 col-lg-6">
                           <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="AEObservacionesAjustes" class="md-textarea form-control red-text" rows="4" readonly="readonly">" "</textarea>
                                <label for="AEObservacionesAjustes">Ajustes Solicitados</label>
                           </div>
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="AESolicitante" class="form-control validate" readonly="true" value="x" />
                                <label for="AESolicitante">Solicitante</label>
                           </div>
                           <div class="md-form">                                
                                <input type="text" id="AEIDE" class="form-control validate" readonly="true" value=" " hidden="hidden" />                                
                           </div>
                           <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="AEPuesto" class="form-control validate" readonly="true" value="x" />
                                <label for="AEPuesto">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>
                                <input type="text" id="AEArea" class="form-control validate" readonly="true" value="x" />
                                <label for="AEArea">Área</label>
                          </div>
                          </div>
                          <div class="col-sm-12 col-lg-6">
                          <div class="md-form">
                                <i class="fa fa-phone prefix red-text"></i>
                                <input type="text" id="AETelefono" class="form-control validate" value=" " />
                                <label for="AETelefono">Teléfono</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AENoSolicitud" class="form-control validate" value="0" />
                                <label for="AENoSolicitud">No. Solicitud</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-plane prefix red-text"></i>
                                <input type="text" id="AEDestino" class="form-control validate" value=" "/>
                                <label for="AEDestino">Destino</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-clock-o prefix red-text"></i>
                                <input type="text" id="AEArribo" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="AEArribo">Hora de Arribo Aprox.</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-tags prefix red-text"></i>
                                <input type="text" id="AEMotivo" class="form-control validate" value=" "/>
                                <label for="AEMotivo">Motivo</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="AEObservaciones" class="md-textarea form-control" rows="2" data-toggle="tooltip" data-placement="top" title="Comentarios">" "</textarea>
                                <label for="AEObservaciones">Observaciones</label>
                         </div>                          
                     </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar sin cambios</button>
                <button type="button" class="btn btn-default" onclick="GuardarAjustesEscala()">Guardar Escalas</button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Ajustar Escala ------------------------------------------------>
<!------ Modal de Ajustes en Solicitud de Escala realizados con éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AjustesSolicitudEscalaExito" tabindex="-1" role="dialog" aria-labelledby="AjustesSolicitudEscalaExito" aria-hidden="true">
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
                  <p>Los cambios se han guardado.</p>
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Ajustes en Solicitud de Escala realizados con éxito------------------------------------------------------------------------->
<!-- Modal de Error Ajustes de Solicitud de Escala --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorSolicitudEscalaAjustes" tabindex="-1" role="dialog" aria-labelledby="ErrorSolicitudEscalaAjustes" aria-hidden="true">
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
                  <div id="MensajeErrorSolicitudEscalaAjustes">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Ajustes de Solicitud de Escala ------------------------------------------------------------------------------------------->
<!-- Modal de Seguimiento de Solicitudes --------------------------------------------->
 <div class="modal fade" id="ModalSeguimientoSolicitudes" tabindex="-1" role="dialog" aria-labelledby="ModalSeguimientoSolicitudes" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MSSLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Seguimiento</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <h3>Solicitud</h3>
                            <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="SSFechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="SSFechaSalida">Fecha Salida</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaSeguimientoSolicitud()">Buscar</button>
                           </div>
                        </div>                         
                    </div>
                    <div id="TablaSeguimientoSolicitud" class="col-12">
                                                                                                                                                                  
                    </div>                    
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <h3>Escala</h3>
                            <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="SENoSolicitud" class="form-control validate"/>
                                <label for="SENoSolicitud">No. Solicitud</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaSeguimientoEscala()">Buscar</button>
                           </div>
                        </div>                         
                    </div>
                    <div id="TablaSeguimientoEscala" class="col-12">
                                                                                                                                                                  
                    </div>     
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Modal de Seguimiento de Solicitudes --------------------------------------------->
<!-- Modal Detalle de Seguimiento de Solicitudes ------------------------------------->                                                 
<div class="modal fade" id="ModalDetalleSeguimientoSolicitud" tabindex="-1" role="dialog" aria-labelledby="ModalDetalleSeguimientoSolicitud" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MDSSLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Detalle Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                       <div class="col-lg-6 col-sm-12">
                           <h5 class="text-center">Datos Solicitud</h5>
                           <div class="md-form">
                                <i class="fa fa-briefcase prefix green-text"></i>
                                <input type="text" id="DSOrigen" class="form-control validate" readonly="true" value="Corporativo"/>
                                <label for="DSOrigen">Origen</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-plane prefix green-text"></i>
                                <input type="text" id="DSDestino" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSDestino">Destino</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix green-text"></i>
                                <input type="text" id="DSFechaSalida" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="DSFechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix green-text"></i>
                                <input type="text" id="DSHoraSalida" class="form-control validate" readonly="true" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="DSHoraSalida">Hora Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix green-text"></i>
                                <input type="text" id="DSFechaRegreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="DSFechaRegreso">Fecha Regreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix green-text"></i>
                                <input type="text" id="DSHoraRegreso" class="form-control validate" readonly="true" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="DSHoraRegreso">Hora Regreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-road prefix green-text"></i>
                                <input type="text" id="DSRuta" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSRuta">Ruta</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-pencil prefix green-text"></i>
                                <textarea  id="DSObservaciones" class="md-textarea form-control" readonly="readonly" rows="4">" "</textarea>
                                <label for="DSObservaciones">Observaciones</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-odnoklassniki prefix green-text"></i>
                                <input type="text" id="DSDisponible" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSDisponible">Lugares Disponibles</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix green-text"></i>
                                <input type="text" id="DSDias" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSDias">Número de Días</label>
                           </div>                        
                        </div>
                        <div class="col-lg-6 col-sm-12">
                            <h5 class="text-center">Datos Vehículo Asignado</h5>
                           <div class="md-form">
                                <i class="fa fa-registered prefix indigo-text"></i>
                                <input type="text" id="DSMarca" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSMarca">Marca</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-shopping-bag prefix indigo-text"></i>
                                <input type="text" id="DSModelo" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSModelo">Modelo</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-tag prefix indigo-text"></i>
                                <input type="text" id="DSPolizaSeguro" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSPolizaSeguro">Poliza Seguro</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-tachometer prefix indigo-text"></i>
                                <input type="text" id="DSColor" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSColor">Color</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-cc-diners-club prefix indigo-text"></i>
                                <input type="text" id="DSPlaca" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSPlaca">Placa</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-ticket prefix indigo-text"></i>
                                <input type="text" id="DSNoSerie" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSNoSerie">No de Serie</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user-plus prefix indigo-text"></i>
                                <input type="text" id="DSChofer" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSDias">Chofer</label>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#SSImagenPS">Poliza Seguro<i class="fa fa-certificate ml-1"></i></button>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#SSImagenTC">Tarjeta de Circulación<i class="fa fa-address-card-o ml-1"></i></button>                               
                           </div>  
                        </div>
                     </div>                                                                                      
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Detalle de Seguimiento de Solicitudes ---------------------------->
<!--Modal Imagen Poliza de Seguro en Seguimiento de Solicitud ------------------------------------------->
<div class="modal fade" id="SSImagenPS" tabindex="-1" role="dialog" aria-labelledby="SSImagenPS" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="SSVerPS" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen Poliza de Seguro en Seguimiento de Solicitud ---------------------------------->
<!--Modal Imagen Tarjeta Circulación en Seguimiento de Solicitud ------------------------------------------->
<div class="modal fade" id="SSImagenTC" tabindex="-1" role="dialog" aria-labelledby="SSImagenTC" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="SSVerTC" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen Tarjeta Circulación en Seguimiento de Solicitud ---------------------------------->
<!-- Modal de Concluir Solicitud en Seguimiento de Solicitud ------------------------->
<div class="modal fade" id="ModalConcluirSolicitud" tabindex="-1" role="dialog" aria-labelledby="ModalConcluirSolicitud" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Concluir Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <input id="CSIDS" readonly="true" hidden="hidden" />
                        <textarea  id="CSObservaciones" class="md-textarea form-control" rows="4"></textarea>
                        <label for="CSObservaciones">Observaciones</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="ConcluirSolicitudSeguimiento()">Concluir <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Concluir Solicitud en Seguimiento de Solicitud ---------------->
<!-- Modal de Cancelar Solicitud en Seguimiento de Solicitud ------------------------->
<div class="modal fade" id="ModalCancelarSolicitud" tabindex="-1" role="dialog" aria-labelledby="ModalCancelarSolicitud" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <input id="CCSIDS" readonly="true" hidden="hidden"/>
                        <textarea  id="CCSObservaciones" class="md-textarea form-control" rows="4"></textarea>
                        <label for="CCSObservaciones">Observaciones</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarSolicitudSeguimiento()">Cancelar<i class="fa fa-window-close-o ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Solicitud en Seguimiento de Solicitud ---------------->
<!-- Modal de Observaciones Vehículo en Seguimiento de Solicitud ------------------------->
<div class="modal fade" id="ModalObservacionesVehiculo" tabindex="-1" role="dialog" aria-labelledby="ModalObservacionesVehiculo" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                  <img id="MAVACISLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Condiciones Vehículo</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <h4>Datos Principales</h4>
                    <div class="col-lg-2 col-sm-12">     
                        <div class="md-form">
                            <i class="fa fa-tachometer prefix red-text"></i>                        
                            <input type="text" id="CSOKilometraje" class="form-control validate"/>
                            <label for="CSOKilometraje">Kilometraje</label>
                        </div>
                    </div> 
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">
                            <i class="fa fa-pencil prefix red-text"></i>
                            <input id="ObserveIDS" readonly="true" hidden="hidden" />
                            <input id="ObserveIDSV" readonly="true" hidden="hidden" />
                            <textarea  id="OVObservaciones" class="md-textarea form-control" rows="4"></textarea>
                            <label for="CSObservaciones">Observaciones</label>
                        </div>
                        <div class="row" style="margin-left:20px;">
                            <label class="switchpersonalizado">
                                <input type="checkbox" id="TarjetaCirculacionCH" name="TarjetaCirculacionCH"/>
                                <span class="slider round"></span>
                            </label>                       
                            <span>Tarjeta de Circulación</span>                       
                        </div>    
                    </div>
                    <div class="col-lg-7 col-sm-12">
                        <div class="row" style="margin-left:25px; margin-top:25px;">  
                            <div class="col-2">
                                <p>Nivel de Combustible</p>                                                
                            </div>                                                  
                            <p class="red-text">Bajo (0 a 7 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustible" id="Bajo" value="0"/>
                            <span class="marcado"></span>
                         </label>
                            <p class="orange-text">Medio (8 a 14 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustible" id="Medio" value="1"/>
                            <span class="marcado"></span>
                         </label>                            
                            <p class="green-text">Alto (Lleno 15 a 20 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustible" id="Lleno" value="2"/>
                            <span class="marcado"></span>
                         </label>                        
                        </div>  
                    </div>                                                                                                                                                                                                                                                                  
                    <p class="black-text">Subir imagenes</p>
                    <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>                                                          
                    <div id="filenameReporteVeh"></div>
                    <div id="progressReporteVeh"></div>
                    <div id="progressBarReporteVeh"></div>   
                    <input class="btn-cyan" type="file" name="SubirReporteVehiculo" multiple="true"/>                                                      
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="AgregarObservacionesVehiculo()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
                <button type="button" class="btn btn-danger" onclick="CancelarObservacionesVehículo()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Observaciones Vehículo en Seguimiento de Solicitud ---------------->
<!-- Modal Detalle de Seguimiento de Escala ------------------------------------------>
<div class="modal fade" id="ModalDetalleSeguimientoEscala" tabindex="-1" role="dialog" aria-labelledby="ModalDetalleSeguimientoEscala" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="DSELogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Detalle Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <h5>Detalle Solicitud</h5>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="DSENoSolicitud" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSENoSolicitud">Número de Solicitud</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-road prefix grey-text"></i>
                                <input type="text" id="DSERuta" class="form-control validate" readonly="true" value=" "/>
                                <label for="DSERuta">Ruta</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="DSEFechaSalida" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="DSEFechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix grey-text"></i>
                                <input type="text" id="DSEHoraSalida" class="form-control validate" readonly="true" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="DSEHoraSalida">Hora Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="DSEFechaRegreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="DSEFechaRegreso">Fecha Regreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-clock-o prefix grey-text"></i>
                                <input type="text" id="DSEHoraRegreso" class="form-control validate" readonly="true" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="DSEHoraRegreso">Hora Regreso</label>
                           </div>
                        </div>
                        <div class="col-lg-6 col-sm-12">
                          <h5>Detalle Escala</h5>
                          <div class="md-form">
                                <i class="fa fa-plane prefix grey-text"></i>
                                <input type="text" id="DSEDestino" class="form-control validate" value=" "/>
                                <label for="DSEDestino">Destino</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-clock-o prefix grey-text"></i>
                                <input type="text" id="DSEArribo" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii" value=" "/>
                                <label for="DSEArribo">Hora de Arribo Aprox.</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-tags prefix grey-text"></i>
                                <input type="text" id="DSEMotivo" class="form-control validate" value=" "/>
                                <label for="DSEMotivo">Motivo</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-pencil prefix grey-text"></i>
                                <textarea  id="DSEObservaciones" class="md-textarea form-control" rows="2" >" "</textarea>
                                <label for="DSEObservaciones">Observaciones</label>
                         </div>                          
                        </div>
                    </div>                                                                                                          
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Detalle de Seguimiento de Escala ------------------------------>
<!-- Modal de Concluir Solicitud Escala en Seguimiento de Solicitud ------------------------->
<div class="modal fade" id="ModalConcluirEscala" tabindex="-1" role="dialog" aria-labelledby="ModalConcluirEscala" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Concluir Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <input id="CEOIDE" readonly="true" hidden="hidden" />
                        <textarea  id="CEObservaciones" class="md-textarea form-control" rows="4"></textarea>
                        <label for="CEObservaciones">Observaciones</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="ConcluirEscalaSeguimiento()">Concluir <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Concluir Solicitud Escala en Seguimiento de Solicitud ---------------->
<!-- Modal de Cancelar Solicitud Escala en Seguimiento de Solicitud ------------------------->
<div class="modal fade" id="ModalCancelarEscala" tabindex="-1" role="dialog" aria-labelledby="ModalCancelarEscala" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <input id="CCEIDE" readonly="true" hidden="hidden"/>
                        <input id="CCEIDS" readonly="true" hidden="hidden"/>
                        <textarea  id="CCEObservaciones" class="md-textarea form-control"rows="4"></textarea>
                        <label for="CCEObservaciones">Observaciones</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarEscalaSeguimiento()">Cancelar<i class="fa fa-window-close-o ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Solicitud Escala en Seguimiento de Solicitud ---------------->
<!------ Modal de Concluir/Cancelar Solicitud/Escala Con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="SeguimientoExito" tabindex="-1" role="dialog" aria-labelledby="SeguimientoExito" aria-hidden="true">
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
                  <div id="MensajeSeguimientoExito">

                  </div>
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Concluir/Cancelar Solicitud/Escala Con Éxito------------------------------------------------------------------------->
<!-- Modal de Error Concluir/Cancelar Solicitud/Escala --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorSeguimiento" tabindex="-1" role="dialog" aria-labelledby="ErrorSeguimiento" aria-hidden="true">
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
                  <div id="MensajeErrorSeguimiento">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Concluir/Cancelar Solicitud/Escala ------------------------------------------------------------------------------------------->
<div class="text-center">
    <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="CrearSolicitud()" data-target="#ModalCrearSolicitud">Nueva<i class="fa fa-pencil ml-2 color-fuente-strong" aria-hidden="true"></i></button>         
    <button id="btnAjustesPendientes" type="button" class="btn btn-unique btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalSolicitudAjustes()" data-target="#ModalSolicitudAjustes">Pendiente de Ajustes<i class="fa fa-warning ml-2 color-fuente-strong" aria-hidden="true"></i></button>
    <button id="btnSeguimiento" type="button" class="btn btn-purple btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalSeguimientoSolicitudes()" data-target="#ModalSeguimientoSolicitudes">Seguimiento<i class="fa fa-bullhorn ml-2 color-fuente-strong" aria-hidden="true"></i></button>        
</div>
</div>
<!--Finaliza Contenido de Crear Solicitud ----------------------------------------->
<!--- Contenido de Autorización ----------------------------------------------->      
    <div id="Autorizacion" class="tab-pane fade">      
<!-- Modal de Solicitudes pendientes de aprobación ---------------------------->
      <div class="modal fade" id="ModalSolicitudesPendienteAprobacion" tabindex="-1" role="dialog" aria-labelledby="ModalSolicitudesPendienteAprobacion" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MSPALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Autorizaciones</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
<%--                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>                           
                                <label for="ApEstatus">Estatus</label>
                           </div>--%>
                           <div class="md-form">
                                <input type="text" id="InputextraEstatus" class="form-control validate" readonly="true" hidden="hidden"/>
                                <select class="form-control" id="ApEstatus" onchange="" hidden="hidden">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="TablaSolicitudesPendientesAprobacion()">Buscar</button>
                           </div>                           
                        </div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="APSSolicitante" class="form-control validate"/>
                                <label for="APSSolicitante">Solicitante</label>
                           </div>
                            <div class="md-form">                                
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="ApSFechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="ApSFechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="ApSFechaRegreso" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="ApSFechaRegreso">Fecha Regreso</label>
                           </div>
                        </div>                       
                    </div>                    
                    <div id="TablaSolicitudesPendientesAprobacion" class="col-12" style="overflow:auto">
                                                                                                                                                                  
                    </div>                    
                    <div id="TablaSolicitudesEscalasPendientesAprobacion" class="col-12" style="overflow:auto">
                                                                                                                                                                  
                    </div>                      
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitudes pendientes de aprobación ---------------------------->
<!-- Modal de Solicitar Ajustes en Solicitudes pendientes de aprobación ---------------->
<div class="modal fade" id="ModalAjustesSolicitudesPendientes" tabindex="-1" role="dialog" aria-labelledby="ModalAjustesSolicitudesPendientes" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Solicitar Ajustes en Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <input id="AjustesSolicitudID" hidden="hidden" />
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="SAPAAjuestesRequeridos" class="md-textarea form-control" rows="4"></textarea>
                        <label for="SAPAAjuestesRequeridos">Ajustes Requeridos</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="AjustesSolicitudDirector()">Solicitar<i class="fa fa-comment ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitar Ajustes en Solicitudes pendientes de aprobación ------->
<!-- Modal de Cancelar Solicitud en Solicitudes pendientes de aprobación ---------------->
<div class="modal fade" id="ModalCancelarSolicitudPendiente" tabindex="-1" role="dialog" aria-labelledby="ModalCancelarSolicitudPendiente" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <input id="CancelarSolicitudID" hidden="hidden"/>
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="CSPMotivoCancelación" class="md-textarea form-control" rows="4"></textarea>
                        <label for="CSPMotivoCancelación">Motivo Cancelación</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarSolicitudDirector()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Solicitud en Solicitudes pendientes de aprobación ------->
<!-- Modal de Solicitar Ajustes en Escala en Solicitudes pendientes de aprobación ---------------->
<div class="modal fade" id="ModalAjustesSolicitudesEscalasPendientes" tabindex="-1" role="dialog" aria-labelledby="ModalAjustesSolicitudesEscalasPendientes" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Solicitar Ajustes en Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <input id="EscalaAjustesIDSolicitud" hidden="hidden" />
                    <input id="EscalaAjustesIDEscala" hidden="hidden" />
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="EscalaAjustesRequeridos" class="md-textarea form-control" rows="4"></textarea>
                        <label for="EscalaAjustesRequeridos">Ajustes Requeridos</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="SolicitarAjustesEscalaDirector()">Solicitar<i class="fa fa-comment ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitar Ajustes en Escala en Solicitudes pendientes de aprobación ------->
<!-- Modal de Cancelar Solicitud Escala en Solicitudes pendientes de aprobación ---------------->
<div class="modal fade" id="ModalCancelarSolicitudEscalaPendiente" tabindex="-1" role="dialog" aria-labelledby="ModalCancelarSolicitudEscalaPendiente" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <input id="CancelarSolicitudIDEscala" hidden="hidden"/>
                    <input id="CancelarSolicitudIDSolicitud" hidden="hidden"/>
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="MotivoCancelacionEscala" class="md-textarea form-control" rows="4"></textarea>
                        <label for="MotivoCancelacionEscala">Motivo Cancelación</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarSolicitudEscalaDirector()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Solicitud Escala en Solicitudes pendientes de aprobación ------->
<!------ Modal de Solicitud Aprobada/Cancelada/Ajustes con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="Aprobada" tabindex="-1" role="dialog" aria-labelledby="Aprobada" aria-hidden="true">
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
                  <div id="MensajeExitoSolicitudAprobada">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitud Aprobada/Cancelada/Ajustes con Éxito------------------------------------------------------------------------->
<!-- Modal de Error Solicitud Aprobada/Cancelada/Ajustes--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorAprobada" tabindex="-1" role="dialog" aria-labelledby="ErrorAprobada" aria-hidden="true">
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
                  <div id="MensajeErrorSolicitudAprobada">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Solicitud Aprobada/Cancelada/Ajustes-------------------------------------------------------------------------------------------->
<!------ Modal de Solicitud Escala Aprobada/Cancelada/Ajustes con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EAprobada" tabindex="-1" role="dialog" aria-labelledby="EAprobada" aria-hidden="true">
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
                  <div id="MensajeExitoSolicitudEscalaAprobada">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitud Escala Aprobada/Cancelada/Ajustes con Éxito------------------------------------------------------------------------->
<!-- Modal de Error Solicitud Escala Aprobada/Cancelada/Ajustes--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="EErrorAprobada" tabindex="-1" role="dialog" aria-labelledby="EErrorAprobada" aria-hidden="true">
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
                  <div id="MensajeErrorSolicitudEscalaAprobada">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Solicitud Escala Aprobada/Cancelada/Ajustes-------------------------------------------------------------------------------------------->
      <div class="text-center">
          <button id="btnPendientesAprobar" type="button" class="btn btn-dark-green btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalSolicitudesPendienteAprobacion()" data-target="#ModalSolicitudesPendienteAprobacion">Ver Solicitudes<i class="fa fa-retweet ml-2 color-fuente-strong" aria-hidden="true"></i></button>
      </div>      
    </div>
<!-- Finaliza Contenido de Autorización---------------------------------------------------------------------------------------------------------->
<!-- Contenido de Asignación --------------------------------------------------->
    <div id="Asignacion" class="tab-pane fade">      
<!-- Modal de Asignación de Vehículos ---------------------------->
      <div class="modal fade" id="ModalAsignacionVehículosAprobados" tabindex="-1" role="dialog" aria-labelledby="ModalAsignacionVehículosAprobados" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MAVALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Solicitudes Pendientes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                            <div class="md-form">                                
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="AVFechaSalida" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                <label for="AVFechaSalida">Fecha Salida</label>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaSolicitudesPendientesAsignacion()">Buscar</button>
                           </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>                                
                                <label for="AVArea">Área</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="AreaInputextra" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="AVArea" onchange="">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="AVSolicitante" class="form-control validate"/>
                                <label for="AVSolicitante">Solicitante</label>
                           </div>
                        </div>                       
                    </div>
                    <div id="TablaSolicitudesPendientesAsignacion" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Asignación de Vehículos ---------------------------->
<!-- Modal de Asignar Vehículo a Solicitud ---------------->
<div class="modal fade" id="ModalAsignarVehículo" tabindex="-1" role="dialog" aria-labelledby="ModalAsignarVehículo" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MAVAAVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Asignar Vehículo</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                                                                              
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVNoSolicitud" class="form-control validate" readonly="true" value="0"/>
                                <label for="AVNoSolicitud">No. Solicitud</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-car prefix grey-text"></i>                                
                                <label for="AVVehiculo">Vehículo</label>
                           </div>
                           <div class="md-form">       
                               <input type="text" id="VehiculoInputextra" class="form-control validate" readonly="true"/>                        
                                <select class="form-control" id="AVVehiculo" onchange="OnChangeInfoVehiculo()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-tag prefix grey-text"></i>
                                <input type="text" id="AVMarca" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVMarca">Marca</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-tag prefix grey-text"></i>
                                <input type="text" id="AVModelo" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVModelo">Modelo</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVPolizaSeguro" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVPolizaSeguro">Poliza de Seguro</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-tachometer prefix grey-text"></i>
                                <input type="text" id="AVColor" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVColor">Color</label>
                           </div>
                        </div>
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVPlaca" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVPlaca">Placa</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-users prefix grey-text"></i>
                                <input type="text" id="AVCapacidad" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVCapacidad">Capacidad</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>                                
                                <label for="AVVIDUChofer">Chofer</label>
                           </div>
                           <div class="md-form">       
                               <input type="text" id="VehiculoChoferInputextra" class="form-control validate" readonly="true"/>                        
                                <select class="form-control" id="AVVIDUChofer">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVNoSerie" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVNoSerie">No. Serie</label>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#ImagenPS">Poliza Seguro<i class="fa fa-certificate ml-1"></i></button>
                           </div>
                           <div class="md-form">
                                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#ImagenTC">Tarjeta de Circulación<i class="fa fa-address-card-o ml-1"></i></button>                               
                           </div>
                        </div>
                    </div>
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="AsignarVehiculo()">Asignar<i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Asignar Vehículo a Solicitud ------->
<!------ Modal de Solicitud Asignada con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AsignadaExito" tabindex="-1" role="dialog" aria-labelledby="AsignadaExito" aria-hidden="true">
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
                  <div id="MensajeAsignadaExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitud Asignada con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al asignar solicitud --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorAsignada" tabindex="-1" role="dialog" aria-labelledby="ErrorAsignada" aria-hidden="true">
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
                  <div id="MensajeErrorAsignada">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al asignar solicitud-------------------------------------------------------------------------------------------->
<!--Modal Imagen Poliza de Seguro en Asignación de Vehículo ------------------------------------------->
<div class="modal fade" id="ImagenPS" tabindex="-1" role="dialog" aria-labelledby="ImagenPS" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerPolizaAsignar" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen Poliza de Seguro en Asignación de Vehículo ---------------------------------->
<!--Modal Imagen Tarjeta Circulación en Asignación de Vehículo ------------------------------------------->
<div class="modal fade" id="ImagenTC" tabindex="-1" role="dialog" aria-labelledby="ImagenTC" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerTarjetaCirculacionAsignacion" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--Finaliza Modal Imagen Tarjeta Circulación en Asignación de Vehículo ---------------------------------->
<!-- Modal de Cancelar Solicitud en Asignación de Vheículos ---------------->
<div class="modal fade" id="AVModalCancelarSolicitud" tabindex="-1" role="dialog" aria-labelledby="AVModalCancelarSolicitud" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="AVMotivoCancelacion" class="md-textarea form-control" rows="4"></textarea>
                        <input id="AdCancelacionIDSolicitud" hidden="hidden" readonly="true"/>
                        <label for="AVMotivoCancelacion">Motivo Cancenlación</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarSolicitudAdministrador()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Solicitud en Asignación de Vehículo ------->
<!------ Modal de Solicitud Cancelada con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AdCanceladaExito" tabindex="-1" role="dialog" aria-labelledby="AdCanceladaExito" aria-hidden="true">
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
                  <div id="MensajeAdCanceladaExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitud Cancelada con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al cancelar solicitud --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="AdErrorCancelada" tabindex="-1" role="dialog" aria-labelledby="AdErrorCancelada" aria-hidden="true">
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
                  <div id="MensajeAdErrorCancelada">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al cancelar solicitud-------------------------------------------------------------------------------------------->
<!-- Modal de Solicitar Ajustes en Asignación de Vheículos ---------------->
<div class="modal fade" id="AVModalSolicitarAjustes" tabindex="-1" role="dialog" aria-labelledby="AVModalSolicitarAjustes" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Solictar Ajustes en Solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="AVAjustesRequeridos" class="md-textarea form-control" rows="4"></textarea>
                        <input id="SolAjustesIDSolicitud" hidden="hidden" readonly="true"/>
                        <label for="AVAjustesRequeridos">Ajustes Requeridos</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="SolictarAjustesAdministrador()">Solicitar<i class="fa fa-comment ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitar Ajustes en Asignación de Vehículo ------->
<!------ Modal de Solicitar ajustes con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AdSolAjuestesExito" tabindex="-1" role="dialog" aria-labelledby="AdSolAjuestesExito" aria-hidden="true">
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
                  <div id="MensajeAdSolAjustesExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Solicitar Ajustes con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al solicitar ajuestes en solicitud --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="AdErrorAjustes" tabindex="-1" role="dialog" aria-labelledby="AdErrorAjustes" aria-hidden="true">
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
                  <div id="MensajeAdErrorAjustes">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al solicitar ajustes en solicitud-------------------------------------------------------------------------------------------->
<!-- Modal de Aprobar/Rechazar Escalas en Asignación de Vheículos ---------------->
<div class="modal fade" id="ModalAVAprobarEscalas" tabindex="-1" role="dialog" aria-labelledby="ModalAVAprobarEscalas" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MAELogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Escalas Solicitadas</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                   <div class="form-row">
                       <div class="col-6">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVESNoSolicitud" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVESNoSolicitud">No. Solicitud</label>
                           </div>
                    </div>
                    <div class="col-6">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="AVESLugaresDisponibles" class="form-control validate" readonly="true" value=" "/>
                                <label for="AVESLugaresDisponibles">Lugares Disponibles</label>
                           </div>
                    </div>
                   </div>                    
                    <div id="TablaEscalasSolicitadas" class="col-12">
                                                                                                                                                                  
                    </div>                                                                                  
                </div>
            <div class="modal-footer d-flex justify-content-center">                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Aprobar/Rechazar Escalas en Asignación de Vehículo ------->
<!-- Modal de Cancelar Escala en Asignación de Vheículos ---------------->
<div class="modal fade" id="AVModalCancelarEscala" tabindex="-1" role="dialog" aria-labelledby="AVModalCancelarEscala" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Cancelar Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="AVCEMotivoCancelacion" class="md-textarea form-control" rows="4"></textarea>
                        <input id="AVCEIDEscala" readonly="true" hidden="hidden" />
                        <input id="AVCEIDSolicitud" readonly="true" hidden="hidden" />
                        <label for="AVCEMotivoCancelacion">Motivo Cancelación</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-danger" onclick="CancelarEscalaAdministrador()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Cancelar Escala en Asignación de Vehículo ------->
<!-- Modal de Solicitar Ajustes en Escala en Asignación de Vheículos ---------------->
<div class="modal fade" id="AVModalSolicitarAjustesEscala" tabindex="-1" role="dialog" aria-labelledby="AVModalSolicitarAjustesEscala" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Solictar Ajustes en Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <textarea  id="AVAjustesRequeridosEscala" class="md-textarea form-control" rows="4"></textarea>
                        <input id="AVAjustesIDEscala" readonly="true" hidden="hidden" />
                        <input id="AVAjustesIDSolicitud" readonly="true" hidden="hidden" />
                        <label for="AVAjustesRequeridosEscala">Ajustes Requeridos</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="SolicitarAjustesEscalaAdministrador()">Solicitar<i class="fa fa-comment ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Solicitar Ajustes en Escala en Asignación de Vehículo ------->
<!------ Modal de Escala Asignada con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EscalaAsignadaExito" tabindex="-1" role="dialog" aria-labelledby="EscalaAsignadaExito" aria-hidden="true">
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
                  <div id="MensajeEscalaAsignadaExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Escala Asignada con Éxito------------------------------------------------------------------------->
<!-- Modal de Error en Escala Asignada--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEscalaAsignada" tabindex="-1" role="dialog" aria-labelledby="ErrorEscalaAsignada" aria-hidden="true">
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
                  <div id="MensajeErrorEscalaAsignada">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error en Escala Asignada-------------------------------------------------------------------------------------------->
      <div class="text-center">
          <button id="btnasignarvehiculos" type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalAsignacionVehículosAprobados()" data-target="#ModalAsignacionVehículosAprobados">Solicitudes Pendientes<i class="fa fa-automobile ml-2 color-fuente-strong" aria-hidden="true"></i></button>
      </div> 
</div>
<!-- Finaliza Contenido de Asignación -------------------------------------------->
<!-- Contenido de Vehículos Asignados -------------------------------------------->
    <div id="VehiculosAsignados" class="tab-pane fade">      
<!-- Modal de Consulta Vehículos Asignados --------------------------------------->
      <div class="modal fade" id="ModalConsultaVehiculosAsignados" tabindex="-1" role="dialog" aria-labelledby="ModalConsultaVehiculosAsignados" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCVALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Vehículos Asignados</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="CVAChofer" class="form-control validate"/>
                                <label for="CVAChofer">Chofer</label>
                           </div>
                        </div>
                        <div class="col-lg-3 col-sm-12">
                           <div class="md-form">                                
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CVAFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CVAFechaSalidaIni">Fecha Inicial</label>
                           </div>
                        </div> 
                        <div class="col-lg-3 col-sm-12">
                           <div class="md-form">                                
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CVAFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CVAFechaSalidaFin">Fecha Final</label>
                           </div>
                        </div>
                        <div class="col-lg-2 col-sm-12">
                           <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaConsultaVehiculosAsignados()">Buscar</button>
                           </div>
                        </div>                      
                    </div>
                    <div id="TablaConsultaVehículosAsginados" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Consulta Vehículos Asignados ------------------------------>
<!-- Modal de Condiciones Iniciales Vehículo en Vehículos Asignados ------------------------->
<div class="modal fade" id="ModalObservacionesVehiculoVA" tabindex="-1" role="dialog" aria-labelledby="ModalObservacionesVehiculoVA" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                  <img id="MAVACILogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Condiciones Vehículo</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <h4>Datos Principales</h4>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                            <i class="fa fa-tachometer prefix red-text"></i>                        
                            <input type="text" id="CSOKilometrajeVA" class="form-control validate"/>
                            <label for="CSOKilometrajeVA">Kilometraje</label>
                        </div>
                    </div>      
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">
                            <i class="fa fa-pencil prefix red-text"></i>
                            <input id="ObserveIDSVA" readonly="true" hidden="hidden" />
                            <input id="ObserveIDSVVA" readonly="true" hidden="hidden" />
                            <textarea  id="OVObservacionesVA" class="md-textarea form-control" rows="4"></textarea>
                            <label for="OVObservacionesVA">Observaciones</label>
                        </div>
                        <div class="row" style="margin-left:20px;">
                            <label class="switchpersonalizado">
                                <input type="checkbox" id="TarjetaCirculacionCHVA" name="TarjetaCirculacionCHVA"/>
                                <span class="slider round"></span>
                            </label>                       
                            <span>Tarjeta de Circulación</span>                       
                        </div>    
                    </div>    
                    <div class="col-lg-7 col-sm-12">
                       <div class="row" style="margin-left:25px; margin-top:25px;">  
                            <div class="col-2">
                                <p>Nivel de Combustible</p>                                                
                            </div>                                                  
                            <p class="red-text">Bajo (0 a 7 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustibleVA" id="BajoVA" value="0"/>
                            <span class="marcado"></span>
                         </label>
                            <p class="orange-text">Medio (8 a 14 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustibleVA" id="MedioVA" value="1"/>
                            <span class="marcado"></span>
                         </label>                            
                            <p class="green-text">Alto (Lleno 15 a 20 cuadros)</p>
                         <label class="contenedor">
                            <input type="radio" name="NivelCombustibleVA" id="LlenoVA" value="2"/>
                            <span class="marcado"></span>
                         </label>                        
                      </div>  
                    </div>                                                                                                                                                                     
                    <p class="black-text">Subir imagenes</p>
                    <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>                                                          
                    <div id="filenameReporteVehVA"></div>
                    <div id="progressReporteVehVA"></div>
                    <div id="progressBarReporteVehVA"></div>   
                    <input class="btn-cyan" type="file" name="SubirReporteVehiculoVA" multiple="true"/>                                                      
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="AgregarObservacionesVehiculoVA()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
                <button type="button" class="btn btn-danger" onclick="CancelarObservacionesVehículoVA()">Cancelar<i class="fa fa-thumbs-o-down ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Condiciones Iniciales de Vehículo en Vehículos Asignados ---------------->
<!-- Modal de Detalle Acompañante --------------------------------------->
      <div class="modal fade" id="ModalDetalleAcompanante" tabindex="-1" role="dialog" aria-labelledby="ModalDetalleAcompanante" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">                    
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Detalle de Escala</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12"> 
                    <input id="TCAIDS" readonly="true" hidden="hidden" />  
                    <div id="TablaConsultaAcompanante" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Detalle Acompañante ------------------------------>
<!-- Modal de Error en Consulta Vehículos Asignados--------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorConsultaVehiculosAsignados" tabindex="-1" role="dialog" aria-labelledby="ErrorConsultaVehiculosAsignados" aria-hidden="true">
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
                  <div id="MensajeErrorVehiculosAsignados">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error en Consulta Vehículos Asignados-------------------------------------------------------------------------------------------->
      <div class="text-center">
          <button type="button" class="btn btn-mdb-color btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalConsultaVehiculosAsignados()" data-target="#ModalConsultaVehiculosAsignados">Vehículos Asignados<i class="fa fa-automobile ml-2 color-fuente-strong" aria-hidden="true"></i></button>
      </div> 
    </div>
<!-- Finaliza Contenido de Vehículos Asignados ----------------------------------->
<!-- Contenido Administración ---------------------------------------------------->
    <div id="Administracion" class="tab-pane fade">      
<!-- Modal Usuarios -------------------------------------------------------------->
      <div class="modal fade" id="ModalConcentradoUsuarios" tabindex="-1" role="dialog" aria-labelledby="ModalConcentradoUsuarios" aria-hidden="true" style="overflow:auto;">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCULogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Administración de Usuarios</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                                                                                            
                   <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="LimpiarModalAltaUsuario()" data-toggle="modal" data-target="#ModalAltaUsuario">Agregar Usuario <i class="fa fa-user-plus ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                    </div>
                    <div class="form-row">
                        <div class="col-lg-3 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="CUUsuario" class="form-control validate"/>
                                <label for="CUUsuario">Nombre</label>
                           </div>
                        </div>
                        <div class="col-lg-3 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>                           
                                <label for="CUArea">Área</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraCU" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="CUArea" onchange="">                                    
                                </select>
                           </div> 
                        </div>
                        <div class="col-lg-2 col-sm-12">
                            <div class="md-form">
                                <button type="button" class="btn btn-info" onclick="CrearTablaConcentradoUsuarios()">Buscar</button>
                            </div>
                        </div>
                    </div>                                                                  
                    <div id="TablaConcentradoUsuarios" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Usuarios -------------------------------------------------->
<!-- Modal Alta de Usuario ------------------------------------------------------->
<div class="modal fade right" id="ModalAltaUsuario" tabindex="-1" role="dialog" aria-labelledby="ModalAltaUsuario" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-top" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <img id="MAVAAULogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title font-weight-bold color-fuente">Alta de Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body mx-12">                
                <div class="form-row">
                  <div class="col-lg-6 col-sm-12">
                    <div class="md-form">
                         <i class="fa fa-user prefix grey-text"></i>
                         <input type="text" id="AUNombre" class="form-control validate" onblur="GenerarNombreUsuario()"/>
                         <label for="AUNombre">Nombre</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-star prefix grey-text"></i>
                         <input type="text" id="AUPuesto" class="form-control validate"/>
                         <label for="AUPuesto">Puesto</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-sitemap prefix grey-text"></i>                           
                         <label for="AUArea">Área</label>
                    </div>
                    <div class="md-form">
                         <input type="text" id="InputextraArea" class="form-control validate" readonly="true"/>
                         <select class="form-control" id="AUArea">
                         </select>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-phone prefix grey-text"></i>
                         <input type="text" id="AUTelefono" class="form-control validate"/>
                         <label for="AUTelefono">Teléfono</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-address-card-o prefix grey-text"></i>
                         <input type="text" id="AUCURP" class="form-control validate"/>
                         <label for="AUCURP">CURP</label>
                    </div>
                </div>
                <div class="col-lg-6 col-sm-12">   
                    <div class="md-form">
                         <i class="fa fa-user prefix grey-text"></i>
                         <input type="text" id="AUNombreUsuario" class="form-control validate" readonly="true" value=" "/>
                         <label for="AUNombreUsuario">Nombre de Usuario</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-unlock-alt prefix grey-text"></i>
                         <input type="password" id="AUContrasena" class="form-control validate" readonly="true" value=" "/>
                         <label for="AUContrasena">Contraseña</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-envelope prefix grey-text"></i>
                         <input type="text" id="AUCorreo" class="form-control validate"/>
                         <label for="AUCorreo">Correo electrónico</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-stethoscope  prefix grey-text"></i>
                         <input type="text" id="AUNSS" class="form-control validate"/>
                         <label for="AUNSS">NSS</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-gears prefix grey-text"></i>                           
                         <label for="AURol">Rol</label>
                    </div>
                    <div class="md-form">
                         <input type="text" id="InputextraRol" class="form-control validate" readonly="true"/>
                         <select class="form-control" id="AURol">                                    
                         </select>
                    </div>
                </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarUsuario()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Alta de Usuario ------------------------------------------->
<!-- Modal Subir INE en Alta de Usuario ------------------------------------------>
<div class="modal fade" id="AUModalINE" tabindex="-1" role="dialog" aria-labelledby="AUModalINE" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">INE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="AUSubirINE" name="AUSubirINE" type="file" class="file" data-show-preview="false"/>                
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Subir INE en Alta de Usuario ------------------------------>
<!-- Modal Subir Licencia Conducir en Alta de Usuario ------------------------------------------>
<div class="modal fade" id="AUModalLicencia" tabindex="-1" role="dialog" aria-labelledby="AUModalLicencia" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Licencia de Conducir</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="AUSubirLicencia" name="AUSubirLicencia" type="file" class="file" data-show-preview="false"/>                
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Subir Licencia Conducir en Alta de Usuario ------------------------------>
<!-- Modal de Modificar Usuario ---------------------------------------------------------------->
<div class="modal fade right" id="ModalModificarUsuario" tabindex="-1" role="dialog" aria-labelledby="ModalModificarUsuario" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-top" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <img id="MAVAMULogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title font-weight-bold color-fuente">Modificar Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <div class="col-12 mx-12">
                    <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="MUIDU" readonly="true" hidden="hidden"/>
                                <input type="text" id="MUNombre" class="form-control validate" value=" "/>
                                <label for="MUNombre">Nombre</label>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="MUPuesto" class="form-control validate" value=" "/>
                                <label for="MUPuesto">Puesto</label>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-sitemap prefix grey-text"></i>                           
                                <label for="MUArea">Área</label>
                            </div>
                            <div class="md-form">
                                <input type="text" id="InputextraMUArea" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="MUArea">
                                </select>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-phone prefix grey-text"></i>
                                <input type="text" id="MUTelefono" class="form-control validate" value=" "/>
                                <label for="MUTelefono">Teléfono</label>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-address-card-o prefix grey-text"></i>
                                <input type="text" id="MUCURP" class="form-control validate" value=" "/>
                                <label for="MUCURP">CURP</label>
                            </div>
                            <div class="md-form">
                              <button type="button" class="btn btn-info btn-rounded btn-lg" data-toggle="modal" data-target="#MUModalINE">INE<i class="fa fa-address-card-o ml-2" aria-hidden="true"></i></button>
                              <button type="button" class="btn btn-info btn-rounded btn-lg" data-toggle="modal" data-target="#MUModalLicencia">Licencia de Conducir<i class="fa fa-address-card-o ml-2" aria-hidden="true"></i></button>
                           </div>
                        </div>
                        <div class="col-lg-6 col-sm-12">
                            <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="MUNombreUsuario" class="form-control validate" readonly="true" value=" "/>
                                <label for="MUNombreUsuario">Nombre de Usuario</label>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-unlock-alt prefix grey-text"></i>
                                <input type="password" id="MUContrasena" class="form-control validate" value=" "/>
                                <label for="MUContrasena">Contraseña</label>
                            </div>
                            <div class="md-form">
                                <i class="fa fa-stethoscope  prefix grey-text"></i>
                                <input type="text" id="MUNSS" class="form-control validate" value=" "/>
                                <label for="MUNSS">NSS</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-gears prefix grey-text"></i>                           
                                <label for="MURol">Rol</label>
                           </div>
                           <div class="md-form">
                                <input type="text" id="InputextraMURol" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="MURol">                                    
                                </select>
                           </div>
                           <div class="md-form">                                
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#ModalConfirmacionBaja">Baja<i class="fa fa-user-times ml-1"></i></button>
                          </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarCambiosUsuario()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Modificar Usuario ------------------------------------------------------->
<!-- Modal Confirmación de Baja de Usuario ----------------------------------------------------->
  <div class="modal fade" id="ModalConfirmacionBaja" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionBaja" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar baja de usuario</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere dar de abaja al usuario?</p>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="BajaUsuario()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>
<!-- Finaliza Modal Confirmación de Baja de Usuario -------------------------------------------->
<!-- Modal Confirmación de Activar Usuario ----------------------------------------------------->
  <div class="modal fade" id="ModalConfirmacionActivar" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionActivar" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar activación de usuario</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere activar a el usuario?</p>
                  <input id="MCAIDU" readonly="true" hidden="hidden" />
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="ActivaUsuario()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>
<!-- Finaliza Modal Confirmación de Activar Usuario -------------------------------------------->                             
<!-- Modal Modificar INE en Modificar Usuario -------------------------------------------------->                                             
<div class="modal fade" id="MUModalINE" tabindex="-1" role="dialog" aria-labelledby="MUModalINE" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">INE</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="MUSubirINE" name="SubirINE" type="file" class="file" data-show-preview="false" hidden="hidden"/>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#MUImagenINE">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Modificar INE en Modificar Usuario ----------------------------------------->
<!-- Modal Modificar Licencia Conducir en Modificar Usuario ------------------------------------>
<div class="modal fade" id="MUModalLicencia" tabindex="-1" role="dialog" aria-labelledby="MUModalLicencia" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Licencia de Conducir</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input id="MUSubirLicencia" name="SubirINE" type="file" class="file" data-show-preview="false" hidden="hidden"/>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#MUImagenLC">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Modificar Licencia Conducir en Modificar Usuario --------------------------->
<!-- Modal de Ver INE en Modifcar Usuario ------------------------------------------------------>
<div class="modal fade" id="MUImagenINE" tabindex="-1" role="dialog" aria-labelledby="MUImagenINE" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerMUImagenINE" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Ver INE en Modificar usuario -------------------------------------------->
<!-- Modal de Ver Licencia Conducir en Modificar Usuario --------------------------------------->
<div class="modal fade" id="MUImagenLC" tabindex="-1" role="dialog" aria-labelledby="MUImagenLC" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerMUImagenLC" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Ver Licencia Conducir en Modificar Usuario ------------------------------>
<!------ Modal de Usuario Registrado/Modificado con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="UsuarioExito" tabindex="-1" role="dialog" aria-labelledby="UsuarioExito" aria-hidden="true">
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
                  <div id="MensajeUsuarioExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Usuario Registrado/Modificado con Éxito------------------------------------------------------------------------->
<!-- Modal de Error Al Registrar/Modificar Usuario --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorUsuario" tabindex="-1" role="dialog" aria-labelledby="ErrorUsuario" aria-hidden="true">
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
                  <div id="MensajeErrorUsuario">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Al Registrar/Modificar Usuario -------------------------------------------------------------------------------------------->
<!-- Modal Concentrado de Roles ---------------------------------------------------------------->
      <div class="modal fade" id="ModalConcentradoRoles" tabindex="-1" role="dialog" aria-labelledby="ModalConcentradoRoles" aria-hidden="true" style="overflow:auto;">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCRLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Administración de Roles</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                                                                                                                                                           
                    <div id="TablaConcentradoRoles" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Concentrado de Roles ---------------------------------------------------->
<!-- Modal de Confirmar Baja de Rol ------------------------------------------------------------>
  <div class="modal fade" id="ModalConfirmacionBajaRol" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionBajaRol" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar baja de Rol</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere dar el rol seleccionado?</p>
                  <p>Tenga en cuenta que muchas de las funciones del portal podrian dejar de funcionar.</p>
                  <input id="CBRIDR" readonly="true" hidden="hidden"/>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="BajaRol()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>  
<!-- Finaliza Modal de Confirmar Baja de Rol --------------------------------------------------->
<!------ Modal de Rol Baja Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="RolBajaExito" tabindex="-1" role="dialog" aria-labelledby="RolBajaExito" aria-hidden="true">
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
                  <div id="MensajeRolBajaExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Rol Baja Éxito------------------------------------------------------------------------->
<!-- Modal de Error Rol Baja --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorRolBaja" tabindex="-1" role="dialog" aria-labelledby="ErrorRolBaja" aria-hidden="true">
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
                  <div id="MensajeErrorRolBaja">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Rol Baja -------------------------------------------------------------------------------------------->
<!-- Modal de Concentrado de Unidades de Negocio ----------------------------------------------->
      <div class="modal fade" id="ModalConcentradoUnidades" tabindex="-1" role="dialog" aria-labelledby="ModalConcentradoUnidades" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCUNLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Administración de Unidades de Negocio</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="LimpiarModalAltaUnidad()" data-toggle="modal" data-target="#ModalAltaUnidad">Agregar Unidad de Negocio <i class="fa fa-building-o ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                    </div>                                                                                                                                                           
                    <div id="TablaUnidadesNegocio" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Concentrado de Unidades de Negocio -------------------------------------->
<!-- Modal de Alta Unidad de Negocio ------------------------------------------------------>
<div class="modal fade right" id="ModalAltaUnidad" tabindex="-1" role="dialog" aria-labelledby="ModalAltaUnidad" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Alta de Unidad</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <div class="col-12">
                    <div class="md-form">
                         <i class="fa fa-building-o prefix grey-text"></i>
                         <input type="text" id="AUNNombre" class="form-control validate"/>
                         <label for="AUNNombre">Nombre</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-star prefix grey-text"></i>
                         <input type="text" id="AUNDireccion" class="form-control validate"/>
                         <label for="AUNDireccion">Dirección</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarAltaUnidad()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Alta Unidad de Negocio --------------------------------------------->
<!-- Modal de Modificar Unidad de Negocio ------------------------------------------------------>
<div class="modal fade right" id="ModalModificarUnidad" tabindex="-1" role="dialog" aria-labelledby="ModalModificarUnidad" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Modificar Unidad</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <div class="col-12">
                    <div class="md-form">
                         <i class="fa fa-building-o prefix grey-text"></i>
                         <input id="MUNIDUN" readonly="true" hidden="hidden"/>
                         <input type="text" id="MUNNombre" class="form-control validate" value=" "/>
                         <label for="MUNNombre">Nombre</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-star prefix grey-text"></i>
                         <input type="text" id="MUNDireccion" class="form-control validate" value=" "/>
                         <label for="MUNDireccion">Dirección</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarCambiosUnidadNegocio()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Modificar Unidad de Negocio --------------------------------------------->
<!-- Modal de Confirmar Baja de Unidad Negocio ------------------------------------------------------------>
  <div class="modal fade" id="ModalConfirmacionBajaUnidadNegocio" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionBajaUnidadNegocio" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar baja de Unidad</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere dar de baja la Unidad de Negocio seleccionada?</p>
                  <p>Tenga en cuenta que esta unidad ya no estará disponible para ningun usuario.</p>
                  <input id="CBUNIDUN" readonly="true" hidden="hidden"/>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="BajaUnidadNegocio()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>  
<!-- Finaliza Modal de Confirmar Baja de Unidad Negocio --------------------------------------------------->
<!-- Modal de Confirmar Baja de Unidad Negocio ------------------------------------------------------------>
  <div class="modal fade" id="ModalConfirmacionActivarUnidad" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionActivarUnidad" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar Activar Unidad</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere activar la Unidad de Negocio seleccionada?</p>                  
                  <input id="CAUNIDUN" readonly="true" hidden="hidden"/>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="ActivarUnidadNegocio()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>  
<!-- Finaliza Modal de Confirmar Baja de Unidad Negocio --------------------------------------------------->
<!------ Modal de Unidad Negocio Alta/Modificar/Baja Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="UnidadNegocioExito" tabindex="-1" role="dialog" aria-labelledby="UnidadNegocioExito" aria-hidden="true">
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
                  <div id="MensajeUnidadNegocioExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Unidad Negocio Alta/Modificar/Baja Éxito ------------------------------------------------------------------------->
<!-- Modal de Error Unidad Negocio Alta/Modificar/Baja --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorUnidadNegocio" tabindex="-1" role="dialog" aria-labelledby="ErrorUnidadNegocio" aria-hidden="true">
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
                  <div id="MensajeErrorUnidadNegocio">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Unidad Negocio Alta/Modificar/Baja -------------------------------------------------------------------------------------------->
<!-- Modal Concentrado de Vehículos ------------------------------------------------------------>
      <div class="modal fade" id="ModalConcentradoVehiculos" tabindex="-1" role="dialog" aria-labelledby="ModalConcentradoVehiculos" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="MCVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Administración de Vehículos</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="LimpiarModalAltaVehículo()" data-toggle="modal" data-target="#ModalAltaVehículo">Agregar Vehículo <i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                    </div>                                                                                                                                                           
                    <div id="TablaConcentradoVehiculo" class="col-12">
                                                                                                                                                                  
                    </div>                    
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Concentrado de Vehículos --------------------------------------------------->         
<!-- Modal de Alta de Vehículo ----------------------------------------------------------------->
<div class="modal fade right" id="ModalAltaVehículo" tabindex="-1" role="dialog" aria-labelledby="ModalAltaVehículo" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Alta de Vehículo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <div class="col-12">
                    <div class="md-form">
                         <i class="fa fa-registered  prefix grey-text"></i>
                         <input type="text" id="AVEMarca" class="form-control validate"/>
                         <label for="AVEMarca">Marca</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-shopping-bag prefix grey-text"></i>
                         <input type="text" id="AVEModelo" class="form-control validate"/>
                         <label for="AVEModelo">Modelo</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-tag  prefix grey-text"></i>
                         <input type="text" id="AVEPolizaSeguro" class="form-control validate"/>
                         <label for="AVEPolizaSeguro">Poliza de Seguro</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-tachometer  prefix grey-text"></i>
                         <input type="text" id="AVEColor" class="form-control validate"/>
                         <label for="AVEColor">Color</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-cc-diners-club prefix grey-text"></i>
                         <input type="text" id="AVEPlaca" class="form-control validate"/>
                         <label for="AVEPlaca">Placa</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-hashtag prefix grey-text"></i>
                         <input type="text" id="AVECapacidad" class="form-control validate"/>
                         <label for="AVECapacidad">Capacidad</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-ticket  prefix grey-text"></i>
                         <input type="text" id="AVENoSerie" class="form-control validate"/>
                         <label for="AVENoSerie">No. Serie</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarVehiculoNuevo()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Alta de Vehículo -------------------------------------------------------->
<!-- Modal de Modificar Vehículo ----------->
<div class="modal fade right" id="ModalModificarVehiculo" tabindex="-1" role="dialog" aria-labelledby="ModalModificarVehiculo" aria-hidden="true">
    <div class="modal-dialog modal-full-height modal-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Modificar Vehículo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <div class="col-12">
                    <div class="md-form">
                         <i class="fa fa-registered  prefix grey-text"></i>
                         <input id="MVIDV" readonly="true" hidden="hidden" />
                         <input type="text" id="MVEMarca" class="form-control validate" value=" "/>
                         <label for="MVEMarca">Marca</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-shopping-bag prefix grey-text"></i>
                         <input type="text" id="MVEModelo" class="form-control validate" value=" "/>
                         <label for="MVEModelo">Modelo</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-tag  prefix grey-text"></i>
                         <input type="text" id="MVEPolizaSeguro" class="form-control validate" value=" "/>
                         <label for="MVEPolizaSeguro">Poliza de Seguro</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-tachometer  prefix grey-text"></i>
                         <input type="text" id="MVEColor" class="form-control validate" value=" "/>
                         <label for="MVEColor">Color</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-cc-diners-club prefix grey-text"></i>
                         <input type="text" id="MVEPlaca" class="form-control validate" value=" "/>
                         <label for="MVEPlaca">Placa</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-hashtag prefix grey-text"></i>
                         <input type="text" id="MVECapacidad" class="form-control validate" value=" "/>
                         <label for="MVECapacidad">Capacidad</label>
                    </div>
                    <div class="md-form">
                         <i class="fa fa-ticket  prefix grey-text"></i>
                         <input type="text" id="MVENoSerie" class="form-control validate" value=" "/>
                         <label for="MVENoSerie">No. Serie</label>
                    </div>
                    <div class="md-form">
                         <button type="button" class="btn btn-info" data-toggle="modal" data-target="#MVModalPolizaSeguro">Poliza Seguro<i class="fa fa-certificate ml-1"></i></button>
                    </div>
                    <div class="md-form">
                         <button type="button" class="btn btn-info" data-toggle="modal" data-target="#MVModalTarjetaCirculacion">Tarjeta de Circulación<i class="fa fa-address-card-o ml-1"></i></button>                               
                    </div>
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn btn-default" onclick="GuardarCambiosVehiculo()">Guardar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Modificar Vehículo -->
<!-- Modal de Modificar/Ver Poliza de Seguro en Modificar Vehículo ----------->
<div class="modal fade" id="MVModalPolizaSeguro" tabindex="-1" role="dialog" aria-labelledby="MVModalPolizaSeguro" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Poliza de Seguro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>
                <div id="filenamePS"></div>
                <div id="progressPS"></div>
                <div id="progressBarPS"></div>   
                <input class="btn-cyan" type="file" name="SubirPolizaSeguro"/>
                <input id="IDDPS" readonly="true" hidden="hidden" /> 
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#MVImagenPoliza">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Modificar/Ver Poliza de Seguro en Modificar Vehículo -->
<!-- Modal Ver Poliza de Seguro en Modificar Vehículo --------------------------------->
  <div class="modal fade" id="MVImagenPoliza" tabindex="-1" role="dialog" aria-labelledby="MVImagenPoliza" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerPS" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Ver Poliza de Seguro en Modificar Vehículo ------------------------>
<!-- Modal de Modificar/Ver Tarjeta de Circulación en Modificar Vehículo ----------->
<div class="modal fade" id="MVModalTarjetaCirculacion" tabindex="-1" role="dialog" aria-labelledby="MVModalTarjetaCirculacion" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title font-weight-bold color-fuente">Tarjeta de Circulación</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p class="red-text">*Recuerde subir archivos JPEG o PNG</p>
                <div id="filenameTC"></div>
                <div id="progressTC"></div>
                <div id="progressBarTC"></div>   
                <input class="btn-cyan" type="file" name="SubirTarjetaCirculacion"/>
                <input id="IDDTC" readonly="true" hidden="hidden" /> 
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#MVImagenTarjeta">Ver documento</button>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Modificar/Ver Tarjeta Circulación en Modificar Vehículo -->
<!-- Modal Ver Tarjeta de Circulación en Modificar Vehículo --------------------------------->
  <div class="modal fade" id="MVImagenTarjeta" tabindex="-1" role="dialog" aria-labelledby="MVImagenTarjeta" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="VerTC" src="" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal Ver Tarjeta de Circulación en Modificar Vehículo ------------------------>
<!-- Modal de Confirmar Activar Vehiculo ------------------------------------------------------------>
  <div class="modal fade" id="ModalConfirmarActivarVehiculo" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmarActivarVehiculo" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar Activar Vehículo</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere activar el vehículo seleccionado?</p>                  
                  <input id="CAVehiculo" readonly="true" hidden="hidden"/>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="Activarvehiculo()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>  
<!-- Finaliza Modal de Confirmar Activar Vehiculo --------------------------------------------------->
<!-- Modal de Confirmar Baja de Vehiculo ------------------------------------------------------------>
  <div class="modal fade" id="ModalConfirmacionBajaVehiculo" tabindex="-1" role="dialog" aria-labelledby="ModalConfirmacionBajaVehiculo" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Confirmar baja de Vehículo</p>
  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p>¿Esta seguro de que quiere dar de baja el vehículo seleccionado?</p>
                  <p>Tenga en cuenta que este vehículo ya no estara disponible para ningun usuario.</p>
                  <input id="CBVehiculoIDV" readonly="true" hidden="hidden"/>
              </div>
          </div>
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" onclick="BajaVehiculo()">Si<i class="fa fa-thumbs-o-up ml-1"></i></a>
              <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal">No<i class="fa fa-thumbs-o-down ml-1"></i></a>
          </div>
      </div>
  </div>
  </div>  
<!-- Finaliza Modal de Confirmar Baja de Vehiculo --------------------------------------------------->
<!------ Modal de Vehículo Alta/Modificar/Baja Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="VehiculoExito" tabindex="-1" role="dialog" aria-labelledby="VehiculoExito" aria-hidden="true">
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
                  <div id="MensajeVehiculoExito">

                  </div>                    
              </div>
          </div>            
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Vehículo Alta/Modificar/Baja Éxito ------------------------------------------------------------------------->
<!-- Modal de Error Vehículo Alta/Modificar/Baja --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorVehiculo" tabindex="-1" role="dialog" aria-labelledby="ErrorVehiculo" aria-hidden="true">
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
                  <div id="MensajeErrorVehiculo">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Vehículo Alta/Modificar/Baja -------------------------------------------------------------------------------------------->

      <div class="text-center">
          <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalConcentradoUsuarios()" data-target="#ModalConcentradoUsuarios">Usuarios<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-indigo btn-rounded mb-lg" data-toggle="modal" onclick="CrearTablaConcentradoRoles()" data-target="#ModalConcentradoRoles">Roles<i class="fa fa-retweet ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-unique btn-rounded mb-lg" data-toggle="modal" onclick="CrearTablaUnidadesNegocio()" data-target="#ModalConcentradoUnidades">Unidades de Negocio<i class="fa fa-building-o ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-purple btn-rounded mb-lg" data-toggle="modal" onclick="CrearTablaConcentradoVehiculo()" data-target="#ModalConcentradoVehiculos">Vehículos<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
      </div>       
    </div>
<!-- Finaliza Contenido de Administración ---------------------------------------->
<!-- Contenido de Reportes ------------------------------------------------------->
    <div id="Reportes" class="tab-pane fade">      
      <div class="text-center">
<!-- Modal Reporte Usuario Solicitante ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteSolicitante" tabindex="-1" role="dialog" aria-labelledby="ModalReporteSolicitante" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Solicitante</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">  
                  <div class="row">                 
                    <div class="col-lg-3 col-sm-12">
                        <h4>Por Unidad de Negocio</h4> 
                    </div>                    
                    <div class="col-lg-3 col-sm-12">                        
                        <div class="md-form">                                                      
                            <label for="ReporteSolicitanteDestinos">Unidad de Negocio</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteD" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteSolicitanteDestinos">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteSolicitante(0)">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteSolicitante','ReporteSolicitante')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteSolicitante" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>                    
                    <div id="GBReporteSolicitante" class="col-lg-12 col-sm-12">                        
                        
                    </div>
                   </div>
                   <div class="row">                
                    <div class="col-lg-3 col-sm-12">
                        <h4>Por Otros Destinos</h4>
                    </div>                                       
                    <div class="col-lg-3 col-sm-12">   
                        <div class="md-form">                                                      
                            <label for="ReporteSolicitanteOtrosDestinos">Otro Destino</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteDOD" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteSolicitanteOtrosDestinos">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RFechaSalidaIniOD" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RFechaSalidaIniOD">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RFechaSalidaFinOD" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RFechaSalidaFinOD">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteSolicitante(1)">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteSolicitanteOD','ReporteSolicitanteOD')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteSolicitanteOD" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>              
                  </div>
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Solicitante -------------------------------->
<!-- Modal Reporte Usuario Director ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteDirector" tabindex="-1" role="dialog" aria-labelledby="ModalReporteDirector" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVDLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Director</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteDirectorDestinos">Unidad de Negocio</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteDD" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteDirectorDestinos" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteDirectorSolicitante">Solicitante</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteDS" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteDirectorSolicitante" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RDFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RDFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RDFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RDFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteDirector()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteDirector','ReporteDirector')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteDirector" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>                    
                    <div id="GBReporteDirector" class="col-lg-12 col-sm-12">                        
                        
                    </div>                    
                    <div id="GBReporteDirectorSolicitante" class="col-lg-12 col-sm-12">                        
                        
                    </div>   
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Director -------------------------------->
<!-- Modal Reporte Usuario Administrador ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteAdministrador" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAdministrador" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVADLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Administrador</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorSolicitante">Solicitante</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteADS" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorSolicitante" onchange="">                                    
                            </select>
                        </div>
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorDestinos">Unidad de Negocio</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteAD" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorDestinos" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorArea">Área</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteAAD" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorArea" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RADFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RADFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RADFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RADFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteAdministrador()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteAdministrador','ReporteAdministrador')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteAdministrador" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>                    
                    <div id="GPReporteAdministradorUnidades" class="col-lg-12 col-sm-12">                        
                        
                    </div>                      
                    <div id="GPReporteAdministradorAreas" class="col-lg-12 col-sm-12">                        
                        
                    </div>                      
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Administrador -------------------------------->
<!-- Modal Reporte Usuario Administrador Incidencias ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteAdministradorIncidencias" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAdministradorIncidencias" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVADILogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Administrador Incidencias</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-4 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorIncidenciasVehiculos">Vehículos</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteADI" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorIncidenciasVehiculos" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RADIFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RADIFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RADIFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RADIFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteAdministradorIncidencias()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteAdministradorIncidencias','ReporteAdministradorIncidencias')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteAdministradorIncidencias" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>                    
                    <div id="GPReporteAdministradorVehiculos" class="col-lg-12 col-sm-12">                        
                        
                    </div>                                          
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Administrador Incidencias -------------------------------->
<!-- Modal Carrusel Imagenes Incidencias ---------------------------------------------------------->
<div class="modal fade" id="ModalImagenesIncidencias" tabindex="-1" role="dialog" aria-labelledby="ModalImagenesIncidencias" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Imagenes</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="CarruselIncidencias" class="carousel slide carousel-fade" data-ride="carousel">
  
                </div>
            </div>
            <div class="modal-footer">                
            </div>
        </div>
    </div>
</div>
<!-- Modal Carrusel Imagenes Incidencias ---------------------------------------------------------->
<!-- Modal Reporte Usuario Administrador Top Vehículos ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteAdministradorTopVehiculos" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAdministradorTopVehiculos" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVATVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Administrador Top Vehículos</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RATVFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RATVFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RATVFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RATVFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-4 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteTopVehiculo()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteTopVehiculo','ReporteTopVehiculo')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteTopVehiculo" class="col-lg-12 col-sm-12" style="align-content:center">
                                                                                                                                                           
                    </div>
                    <div id="GPReporteAdministradorTopVehiculo" class="col-lg-12 col-sm-12">                        
                        
                    </div>                                                                
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Administrador Top Vehículos -------------------------------->
<!-- Modal Reporte Usuario Administrador Vehículos Utilizados Por Área ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteAdministradorVehiculoArea" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAdministradorVehiculoArea" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVAVALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Administrador Vehículos por Área</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RAVAFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RAVAFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RAVAFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RAVAFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-4 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteVehiculoArea()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteVehiculoArea','ReporteVehiculoArea')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteVehiculoArea" class="col-lg-12 col-sm-12" style="align-content:center">
                                                                                                                                                           
                    </div>                                                             
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Administrador Vehículos Utilizados Por Área -------------------------------->
<!-- Modal Reporte Usuario Administrador Escalas ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteAdministradorEscala" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAdministradorEscala" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVRELogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Escalas</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorEscalaSolicitante">Solicitante</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteADE" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorEscalaSolicitante" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                                                      
                            <label for="ReporteAdministradorEscalaArea">Área</label>
                        </div>
                        <div class="md-form">
                            <input type="text" id="ReporteAADE" class="form-control validate" readonly="true"/>
                            <select class="form-control" id="ReporteAdministradorEscalaArea" onchange="">                                    
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-2 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RADEFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RADEFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RADEFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RADEFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-2 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteEscala()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteAdministradorEscala','ReporteAdministradorEscala')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteAdministradorEscala" class="col-lg-12 col-sm-12">
                                                                                                                                                           
                    </div>                                       
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Reporte de Usuario Administrador Escalas -------------------------------->
<!-- Modal Reporte De Archivo Cancelado ------------------------------------------------------------>
      <div class="modal fade" id="ModalReporteArchivoCancelada" tabindex="-1" role="dialog" aria-labelledby="ModalReporteArchivoCancelada" aria-hidden="true">
        <div class="modal-dialog modal-fluid" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <img id="PEVARACLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Reporte Solicitudes Canceladas</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">                    
                    <div class="col-lg-3 col-sm-12">                                                
                        <div class="md-form">                                                             
                             <input type="text" id="RAACFechaSalidaIni" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                             <label for="RAACFechaSalidaIni">Inicio</label>
                        </div>                                                                        
                    </div>
                    <div class="col-lg-3 col-sm-12">
                        <div class="md-form">                           
                            <input type="text" id="RAACFechaSalidaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                            <label for="RAACFechaSalidaFin">Fin</label>
                        </div>
                    </div>                               
                    <div class="col-lg-4 col-sm-12">
                        <div class="md-form">
                          <button type="button" class="btn btn-info" onclick="CrearTablaReporteArchivoCancelada()">Buscar<i class="fa fa-car ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                          <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteArchivoCancelado','ReporteArchivoCancelado')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                        </div>  
                    </div>                                                                                                                                                                             
                    <div id="TablaReporteArchivoCancelado" class="col-lg-12 col-sm-12" style="align-content:center">
                                                                                                                                                           
                    </div>                                                              
                </div>
            <div class="modal-footer d-flex justify-content-center">
                
            </div>
        </div>
    </div>
</div>  
<!-- Finaliza Modal de Achivo Cancelado -------------------------------->
<!-- Modal de Error Reporte Solicitante --------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorReporteSolicitante" tabindex="-1" role="dialog" aria-labelledby="ErrorReporteSolicitante" aria-hidden="true">
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
                  <div id="MensajeErrorReporteSolicitante">

                  </div>                  
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger"  data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Reporte Solicitante -------------------------------------------------------------------------------------------->
          <button id="BotonRS" type="button" class="btn btn-amber btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteSolicitante()" data-target="#ModalReporteSolicitante">Mis Solicitudes<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRACS" type="button" class="btn btn-deep-purple btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteArchivoCancelada()" data-target="#ModalReporteArchivoCancelada">Archivo Cancelado<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRD" type="button" class="btn btn-light-blue btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteDirector()" data-target="#ModalReporteDirector">Mi Área<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRA" type="button" class="btn btn-light-green btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteAdministrador()" data-target="#ModalReporteAdministrador">Administrador<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRI" type="button" class="btn btn-pink btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteAdministradorIncidencias()" data-target="#ModalReporteAdministradorIncidencias">Incidencias<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRTV" type="button" class="btn btn-primary btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteTopVehiculo()" data-target="#ModalReporteAdministradorTopVehiculos">Top Vehículos<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRVA" type="button" class="btn btn-secondary btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteVehiculoArea()" data-target="#ModalReporteAdministradorVehiculoArea">Vehículos por área.<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
          <button id="BotonRRE" type="button" class="btn btn-danger btn-rounded mb-lg" data-toggle="modal" onclick="AbrirModalReporteAdministradorEscala()" data-target="#ModalReporteAdministradorEscala">Escalas<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>
      </div>  
    </div>
<!-- Finaliza Contenido de Reportes ---------------------------------------------->         
  </div>
  <!----Finaliza Panel por Contenido------------------------------------------------------------------------------------------------------------------------>
</div>
 <!---Finaliza Pill/Tab-------------------------------------------------------------------------------------------------------------------->
<!-- Modal de Ayuda del Portal -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalInfo" tabindex="-1" role="dialog" aria-labelledby="ModalInfo" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-info modal-large" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Políticas</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>  
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>                  
                  <h3>VEHÍCULO UTILITARIO DE COMISIÓN.</h3>
                  <p>Los vehículos utilitarios son exclusivos para uso del personal de Corporativo.</p>
                  <p>La capacidad máxima establecida por vehículo utilitario está limitado a 4 plazas.</p>
                  <p>Todo el personal que utilice vehículos utilitarios, deben de salir y llegar a las instalaciones de Corporativo.</p>                                   
                  <a id="Pol1" type="button" class="btn btn-primary" href="http://mrc.sytes.net/GestionVehicular/AF-01-P09Gestiondevehiculosutilitarios.pdf" target="_blank">Gestión de Vehículos<i class="fa fa-question-circle-o ml-1"></i></a>                                                                          
                  <a id="Pol2" type="button" class="btn btn-unique" href="http://mrc.sytes.net/GestionVehicular/AF-01-P09-L01Usodevehiculosutilitarios.pdf" target="_blank">Uso de Vehículos<i class="fa fa-question-circle-o ml-1"></i></a>                                                                          
              </div>
          </div>                                              
      </div>      
  </div>
  </div>
<!-- Finaliza Modal de Ayuda del Portal ----------------------------------------------------------------------------------------->
<!-- Modal de Números de Ayuda -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalNumeros" tabindex="-1" role="dialog" aria-labelledby="ModalNumeros" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-warning" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <p class="heading lead">Número de Emergencia</p>  
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>  
          <div class="modal-body">
              <div class="text-center">
                  <i class="fa fa-check fa-4x mb-3 animated rotateIn"></i>
                  <p style="font-size:22px;">Ante cualquier eventualidad recuerde comunicarse al</p>
                  <p style="font-size:28px; font-weight:bold"><strong>911</strong></p>
              </div>
          </div>            
      </div>      
  </div>
  </div>
<!-- Finaliza Modal de Números de Ayuda ----------------------------------------------------------------------------------------->
<!-- Modal de Tips -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalTips" tabindex="-1" role="dialog" aria-labelledby="ModalTips" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">      
      <div class="modal-content">          
          <div class="modal-header">
              <h4 class="modal-title w-100 font-weight-bold color-fuente">Cuando viajes recuerda...</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true" class="white-text">&times;</span>
              </button>
          </div>  
          <div class="modal-body">
<!--Carousel Wrapper-->
<div id="CarTips" class="carousel slide carousel-fade" data-ride="carousel">
    <!--Indicators-->
    <ol class="carousel-indicators">
        <li data-target="#CarTips" data-slide-to="0" class="active"></li>
        <li data-target="#CarTips" data-slide-to="1"></li>
        <li data-target="#CarTips" data-slide-to="2"></li>
        <li data-target="#CarTips" data-slide-to="3"></li>
        <li data-target="#CarTips" data-slide-to="4"></li>
    </ol>
    <!--/.Indicators-->
    <!--Slides-->
    <div class="carousel-inner" role="listbox">        
        <div class="carousel-item active">
            <img class="d-block w-100" src="img/Antes de conducir.png" alt="Antes de Conducir"/>
        </div>       
        <div class="carousel-item">
            <img class="d-block w-100" src="img/Conduciendo bajo la lluvia.png" alt="Conduciendo Bajo Lluvia"/>
        </div>        
        <div class="carousel-item">
            <img class="d-block w-100" src="img/Ojo con la niebla.png" alt="Ojo con la Niebla"/>
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="img/Puntos importantes en el reglamento de tránsito.png" alt="Puntos Importantes"/>
        </div>        
        <div class="carousel-item">
            <img class="d-block w-100" src="img/Si viajas por carretera.png" alt="Viaje en Carretera"/>
        </div>
    </div>
    <!--/.Slides-->
    <!--Controls-->
    <a class="carousel-control-prev" href="#CarTips" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#CarTips" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
    <!--/.Controls-->
</div>
<!--/.Carousel Wrapper-->
          </div>            
      </div>      
  </div>
  </div>
<!-- Finaliza Modal de Tips ----------------------------------------------------------------------------------------->
<!-- Modal de Costos -------------------------------------------------------------------------------------------->
<div class="modal fade" id="ModalCostos" tabindex="-1" role="dialog" aria-labelledby="ImagenINE" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">                
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">                
                <img src="img/Costo de traslados en vehículo utilitario sep18.jpg" class="img-fluid" alt="Responsive image"/>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de Costos ----------------------------------------------------------------------------------------->
</body>
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.13.0/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/js/mdb.min.js"></script>
<script src="Js/dropzone.js"></script>
<script src="DatePicker/js/bootstrap-datetimepicker.js"></script>
<script src="DatePicker/js/locales/bootstrap-datetimepicker.es.js"></script>
<script src="http://momentjs.com/downloads/moment.min.js"></script>
<script src="Js/TEST.js"></script>
<script src="Js/SimpleAjaxUploader.js"></script>
<script src="Js/jquery.table2excel.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        

        /*Solo para subir INE en creación de solicitud.*/
        $('input[name=SubirINEEEEE]').change(function () {
            
            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/Guardar", {
                name: $("#IdUsuario").val() + "-0",

                start: function (file) {
                    //upload started
                    $('#filename').html(file.name);
                    $('#progress').html("");
                    $('#progressBar').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progress').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBar').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progress').html("¡Éxito al subir archivo!<br>");
                    $("#VerINEIDD").val(data.IDD);
                    $("#ModalINE").modal('hide');
                    $('#filename').empty();
                    $('#progress').empty();
                    $('#progressBar').empty();
                },

                error: function (error) {
                    //upload failed
                    $('#progress').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir INE en creación de solicitud.*/

        /*Solo para subir LC en creación de solicitud.*/
        $('input[name=SubirLC]').change(function () {

            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/Guardar", {
                name: $("#IdUsuario").val() + "-1",

                start: function (file) {
                    //upload started
                    $('#filenameLC').html(file.name);
                    $('#progressLC').html("");
                    $('#progressBarLC').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progressLC').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBarLC').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progressLC').html("¡Éxito al subir archivo!<br>");
                    $("#VerLCIDD").val(data.IDD);
                    $("#ModalLicenciaConducir").modal('hide');
                    $('#filenameLC').empty();
                    $('#progressLC').empty();
                    $('#progressBarLC').empty();
                },

                error: function (error) {
                    //upload failed
                    $('#progressLC').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir LC en creación de solicitud.*/


        /*Solo para subir Poliza Seguro en modificar vehiculos*/
        $('input[name=SubirPolizaSeguro]').change(function () {

            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/GuardarDocumentoVehiculo", {
                name: $("#MVIDV").val() + "-2",
                start: function (file) {
                    //upload started
                    $('#filenamePS').html(file.name);
                    $('#progressPS').html("");
                    $('#progressBarPS').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progressPS').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBarPS').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progressPS').html("¡Éxito al subir archivo!<br>");
                    $("#IDDPS").val(data.IDD);
                    $("#MVModalPolizaSeguro").modal('hide');
                    $('#filenamePS').empty();
                    $('#progressPS').empty();
                    $('#progressBarPS').empty();
                },

                error: function (error) {
                    //upload failed
                    $('#progressPS').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir Poliza Seguro en modificar vehiculos.*/

        /*Solo para subir Tarjeta de Circulación en modificar vehiculos*/
        $('input[name=SubirTarjetaCirculacion]').change(function () {

            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/GuardarDocumentoVehiculo", {
                name: $("#MVIDV").val() + "-3",
                start: function (file) {
                    //upload started
                    $('#filenameTC').html(file.name);
                    $('#progressTC').html("");
                    $('#progressBarTC').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progressTC').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBarTC').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progressTC').html("¡Éxito al subir archivo!<br>");
                    $("#IDDTC").val(data.IDD);
                    $("#MVModalTarjetaCirculacion").modal('hide');
                    $('#filenameTC').empty();
                    $('#progressTC').empty();
                    $('#progressBarTC').empty();
                    
                },

                error: function (error) {
                    //upload failed
                    $('#progressTC').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir Tarjeta de Circulación en modificar vehiculo*/

        /*Solo para subir Fotos de reporte de daño en el vehículo*/
        $('input[name=SubirReporteVehiculo]').change(function () {

            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/GuardarFotoReporteVehiculo", {
                name: $("#ObserveIDS").val(),
                start: function (file) {
                    //upload started
                    $('#filenameReporteVeh').html(file.name);
                    $('#progressReporteVeh').html("");
                    $('#progressBarReporteVeh').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progressReporteVeh').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBarReporteVeh').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progressReporteVeh').html("¡Éxito al subir archivos!<br>");                                        
                    $('#filenameReporteVeh').empty();

                },

                error: function (error) {
                    //upload failed
                    $('#progressReporteVeh').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir Fotos de reporte de daño en el vehículo*/

        /*Solo para subir Fotos de reporte de daño en el vehículo chofer*/
        $('input[name=SubirReporteVehiculoVA]').change(function () {

            $(this).simpleUpload("http://mrc.sytes.net/GestionVehicular/CargarArchivo.asmx/GuardarFotoReporteVehiculo", {
                name: $("#ObserveIDSVA").val(),
                start: function (file) {
                    //upload started
                    $('#filenameReporteVehVA').html(file.name);
                    $('#progressReporteVehVA').html("");
                    $('#progressBarReporteVehVA').width(0);
                },

                progress: function (progress) {
                    //received progress
                    $('#progressReporteVehVA').html("Progress: " + Math.round(progress) + "%");
                    $('#progressBarReporteVehVA').width(progress + "%");
                },

                success: function (data) {
                    //upload successful
                    $('#progressReporteVehVA').html("¡Éxito al subir archivos!<br>");
                    $('#filenameReporteVehVA').empty();

                },

                error: function (error) {
                    //upload failed
                    $('#progressReporteVehVA').html("Failure!<br>" + error.name + ": " + error.message);
                }

            });

        });
        /*Solo para subir Fotos de reporte de daño en el vehículo chofer*/


        /*Función para obtener parametros de la URL con Jquery
        Mario Gress
        2018
        */

        (function ($) {
            $.OURL = function (key) {
                key = key.replace(/[\[]/, '\\[');
                key = key.replace(/[\]]/, '\\]');
                var pattern = "[\\?&]" + key + "=([^&#]*)";
                var regex = new RegExp(pattern);
                var url = unescape(window.location.href);
                var results = regex.exec(url);
                if (results === null) {
                    return null;
                } else {
                    return results[1];
                }
            }
        })(jQuery);
        /*----------------------------------------------*/

        var NombreUsuario = "";
        var nombre = $.OURL("Name");
        /*Verificar el rol del usuario logueado para determinar que es lo que puede visualizar del menú.*/
        $("#0").hide();
        $("#1").hide();
        $("#2").hide();
        $("#3").hide();
        $("#4").hide();
        $("#5").hide();
        $("#6").hide();

        $("#BotonRS").hide();
        $("#BotonRD").hide();
        $("#BotonRA").hide();
        $("#BotonRI").hide();
        $("#BotonRTV").hide();
        $("#BotonRVA").hide();
        $("#BotonRRE").hide();
        $("#Manual1").hide();
        $("#Manual2").hide();
        $("#Manual3").hide();
        $("#Manual4").hide();
        $("#Manual5").hide();
        $("#Manual6").hide();
        $("#Manual7").hide();
        $("#Manual8").hide();


        /*Notificaciones --------------------*/


        $.ajax({
            type: "POST",
            url: "Home.aspx/NotificarSolicitudes",
            data: '{ul:"' + nombre + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch(result.d)
                {
                    case 0:
                        $("#1").removeClass("animated tada infinite");
                        break;
                    case 1:
                        $("#1").addClass("animated tada infinite");                         
                        break;
                    case -1:
                        break;
                    default:
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        $.ajax({
            type: "POST",
            url: "Home.aspx/NotificarSolicitudesAjustes",
            data: '{ul:"' + nombre + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d) {
                    case 0:
                        $("#btnAjustesPendientes").removeClass("animated pulse infinite");
                        break;
                    case 1:
                        $("#btnAjustesPendientes").addClass("animated pulse infinite");
                        break;
                    case -1:
                        break;
                    default:
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        $.ajax({
            type: "POST",
            url: "Home.aspx/NotificarSolicitudesSeguimiento",
            data: '{ul:"' + nombre + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d) {
                    case 0:
                        $("#btnSeguimiento").removeClass("animated pulse infinite");
                        break;
                    case 1:
                        $("#btnSeguimiento").addClass("animated pulse infinite");
                        break;
                    case -1:
                        break;
                    default:
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        $.ajax({
            type: "POST",
            url: "Home.aspx/NotificarSolicitudesPendienteAprobar",
            data: '{ul:"' + nombre + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d) {
                    case 0:
                        $("#2").removeClass("animated tada infinite");
                        $("#btnPendientesAprobar").removeClass("animated pulse infinite");
                        break;
                    case 1:
                        $("#2").addClass("animated tada infinite");
                        $("#btnPendientesAprobar").addClass("animated pulse infinite");
                        break;
                    case -1:
                        break;
                    default:
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        $.ajax({
            type: "POST",
            url: "Home.aspx/NotificarSolicitudesPendientesAsignacion",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d) {
                    case 0:
                        $("#3").removeClass("animated tada infinite");
                        $("#btnasignarvehiculos").removeClass("animated pulse infinite");
                        break;
                    case 1:
                        $("#3").addClass("animated tada infinite");
                        $("#btnasignarvehiculos").addClass("animated pulse infinite");
                        break;
                    case -1:
                        break;
                    default:
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        /*----------------------------------*/


        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerRol",
            data: '{nombre:"' + nombre + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result)
            {
                NombreUsuario = result.d;
                switch (NombreUsuario) {
                    case "Administrador":
                        $("#0").show();
                        $("#1").show();
                        $("#3").show();
                        $("#4").show();
                        $("#5").show();
                        $("#6").show();
                        $("#BotonRS").show();
                        $("#BotonRA").show();
                        $("#BotonRI").show();
                        $("#BotonRTV").show();
                        $("#BotonRVA").show();
                        $("#BotonRRE").show();
                        $("#Manual1").show();
                        $("#Manual2").show();
                        $("#Manual3").show();
                        $("#Manual4").show();
                        $("#Manual5").show();
                        $("#Manual7").show();
                        $("#Manual8").show();
                        $("#ModalInfo").modal('show');
                        break;
                    case "Director":
                        $("#0").show();
                        $("#1").show();
                        $("#2").show();
                        $("#6").show();
                        $("#BotonRS").show();
                        $("#BotonRD").show();
                        $("#Manual1").show();
                        $("#Manual2").show();
                        $("#Manual3").show();
                        $("#Manual4").show();
                        $("#Manual5").show();
                        $("#Manual6").show();
                        $("#ModalInfo").modal('show');
                        break;
                    case "Solicitante":
                        $("#0").show();
                        $("#1").show();                        
                        $("#6").show();
                        $("#BotonRS").show();
                        $("#Manual1").show();
                        $("#Manual2").show();
                        $("#Manual3").show();
                        $("#Manual4").show();
                        $("#Manual5").show();
                        $("#ModalInfo").modal('show');
                        break;
                    case "Supervisor":
                        $("#0").show();
                        $("#1").show();
                        $("#3").show();
                        $("#6").show();
                        $("#BotonRS").show();                        
                        $("#BotonRA").show();
                        $("#BotonRI").show();
                        $("#BotonRTV").show();
                        $("#BotonRVA").show();
                        $("#BotonRRE").show();
                        $("#Manual1").show();
                        $("#Manual2").show();
                        $("#Manual3").show();
                        $("#Manual4").show();
                        $("#Manual5").show();
                        $("#ModalInfo").modal('show');
                        break;
                    case "Chofer":
                        $("#4").show();
                        break;
                    default:
                        $("#0").hide();
                        $("#1").hide();
                        $("#2").hide();
                        $("#3").hide();
                        $("#4").hide();
                        $("#5").hide();
                        $("#6").hide();
                        $("#BotonRS").hide();
                        $("#BotonRD").hide();
                        $("#BotonRA").hide();
                        $("#BotonRI").hide();
                        $("#BotonRTV").hide();
                        $("#BotonRVA").hide();
                        $("#BotonRRE").hide();
                        $("#Manual1").hide();
                        $("#Manual2").hide();
                        $("#Manual3").hide();
                        $("#Manual4").hide();
                        $("#Manual5").hide();
                        $("#Manual6").hide();
                        $("#Manual7").hide();
                        $("#Manual8").hide();
                        $("#ModalInfo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });



        /*Función para capturar el evento de cambio en chofer y calcular el número de asientos disponibles*/
        $('input[type=radio][name=choferCS]').change(function () {
            if (this.value == 'True') {
                $("#Disponible").val("2")
            }
            else if (this.value == 'False') {
                $("#Disponible").val("3")
            }
        });

        /*Función para capturar el evento de cambio en chofer y calcular el número de asientos disponibles en ajuste de solicitud.*/
        $('input[type=radio][name=choferA]').change(function () {
            if (this.value == 'True') {
                $("#ASDisponible").val("2")
            }
            else if (this.value == 'False') {
                $("#ASDisponible").val("3")
            }
        });
    });

     $(function () {
       $('[data-toggle="tooltip"]').tooltip()
     })
    
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
    $('.form_time').datetimepicker({
        language: 'es',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 1,
        minView: 0,
        maxView: 5,
        forceParse: 0
    });
/*Función para agregar los campos de manera dinamica*/    
    var nextinput = $("#nextinput").val();
    var ASnextinput = $("#ASnextinput").val();
function AgregaCampo() {
        nextinput = $("#nextinput").val();
        nextinput++;
        $("#nextinput").val(nextinput);
        Escala = '<div class="md-form"><i class="fa fa-road prefix grey-text"></i><input type="text" id="Escala' + nextinput + '" class="form-control validate" data-toggle="tooltip" data-placement="top" title="Ingrese una ruta cada escala separada por un -"/><label for="Escala' + nextinput + '">Escala</label></div>';
        HAE = '<div class="md-form"><i class="fa fa-clock-o prefix grey-text"></i><input type="text" id="HAEscala' + nextinput + '" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii"/><label for="HAEscala' + nextinput + '">Hora Arribo Aprox.</label></div>';
        $("#CampoDinamico").append(Escala);
        $("#CampoDinamico").append(HAE);
}

function ASAgregaCampo() {
    ASnextinput = $("#ASnextinput").val();
    ASnextinput++;
    $("#ASnextinput").val(ASnextinput);
    Escala = '<div class="md-form"><i class="fa fa-road prefix grey-text"></i><input type="text" id="Escala' + ASnextinput + '" class="form-control validate" data-toggle="tooltip" data-placement="top" title="Ingrese una ruta cada escala separada por un -"/><label for="Escala' + ASnextinput + '">Escala</label></div>';
    HAE = '<div class="md-form"><i class="fa fa-clock-o prefix grey-text"></i><input type="text" id="HAEscala' + ASnextinput + '" class="date form_time form-control validate" data-date-format="hh:ii" data-link-format="hh:ii"/><label for="HAEscala' + ASnextinput + '">Hora Arribo Aprox.</label></div>';
    $("#ASCampoDinamico").append(Escala);
    $("#ASCampoDinamico").append(HAE);
}



/*Termina función para agregar los campos de manera dinamica*/
    </script>
</html>
