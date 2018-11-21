<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

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
    <title>Portal de satisfacción de capacitación</title>

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
                <li class="nav-item dropdown item-inactivo">
                    <a class="nav-link color-fuente-strong" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Manuales<span class="sr-only"></span></a>                    
                    <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                        <a id="M1" class="dropdown-item" target="_blank" href="http://mrc.sytes.net/SatisfaccionEntrenamiento/Manuales/MOENCUESTAJEFEDIRECTO.pdf">Jefe Directo</a>
                        <a id="M2" class="dropdown-item" target="_blank" href="http://mrc.sytes.net/SatisfaccionEntrenamiento/Manuales/MOENCUESTAENTRENADOR.pdf">Entrenador</a>
                        <a id="M3" class="dropdown-item" target="_blank" href="http://mrc.sytes.net/SatisfaccionEntrenamiento/Manuales/MOENCUESTACAPACITANDO.pdf">Capacitando</a>
                        <a id="M4" class="dropdown-item" target="_blank" href="http://mrc.sytes.net/SatisfaccionEntrenamiento/Manuales/MOENCUESTACAPACITADOR.pdf">Capacitador</a>
                        <a id="M5" class="dropdown-item" target="_blank" href="http://mrc.sytes.net/SatisfaccionEntrenamiento/Manuales/MAADMONBD.pdf">Administrador</a>
                    </div>
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
  <h3 class="color-fuente text-center">AL PORTAL DE SATIFACCIÓN DE ENTRENAMIENTO Y CAPACITACIÓN</h3>
  <!--Panel de selección------------------------------------------------------------------------------------------------------->     
  <ul class="nav nav-pills" style="margin-left:auto; margin-bottom:150px; margin-top:80px;">
    <li id="0"><a data-toggle="pill" href="#EncuestaCapacitando"><i class="fa fa-thumbs-o-up fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ENCUESTA CAPACITANDO</a></li>
    <li id="1"><a data-toggle="pill" href="#EncuestaEntrenador"><i class="fa fa-thumbs-o-up fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ENCUESTA ENTRENADOR</a></li>
    <li id="2"><a data-toggle="pill" href="#EncuestaCapacitador" onclick="ObtenerUnidadAsignadaCapacitador()"><i class="fa fa-thumbs-o-up fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ENCUESTA CAPACITADOR</a></li>
    <li id="3"><a data-toggle="pill" href="#EncuestaJefeInmediato"><i class="fa fa-thumbs-o-up fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ENCUESTA JEFE INMEDIATO</a></li>  
    <li id="4"><a data-toggle="pill" href="#Administracion"><i class="fa fa-users fa-3x nav-link color-fuente-strong" style="text-align:center"></i>ADMINISTRACIÓN</a></li>    
    <li id="5"><a data-toggle="pill" href="#Reportes"><i class="fa fa-list-alt fa-3x nav-link color-fuente-strong" style="text-align:center"></i>REPORTES</a></li> 
  </ul>      
  <!----------------------------------------------------------------------------------------------------------------------------->
  <!--Paneles por contenido------------------------------------------------------------------------------------------------------>
 <div class="tab-content">
<!-- Contenido de Encuesta Capacitando------------------------------------------------------------>
     <div id="EncuestaCapacitando" class="tab-pane fade">
<!-- Modal de Capacitando Evaluando a Entrenador ------------------------------------------------->
<div class="modal fade" id="ModalCapacitandoEvaluarEntrenador" tabindex="-1" role="dialog" aria-labelledby="ModalCapacitandoEvaluarEntrenador" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente" id="exampleModalLabel">Evaluación de Entrenador</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">                            
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="CapacitandoNombre" class="form-control validate" readonly="true" value=" "/>
                                <label for="CapacitandoNombre">Capacitando</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="CapacitandoNombreEntrenador">Entrenador</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="Inputextra" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="CapacitandoNombreEntrenador" onchange="ObtenerPuesto()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CapacitandoFechaAplicacion" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitandoFechaAplicacion">Fecha Aplicación</label>
                           </div>    
                        </div>
                        <div class="col-lg-4 col-sm-12">                          
                          <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="CapacitandoPuesto" class="form-control validate" value=" " readonly="true"/>
                                <label for="CapacitandoPuesto">Puesto Capacitando</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="CapacitandoPuestoEntrenador" class="form-control validate" value=" " readonly="true"/>                                
                                <label for="CapacitandoPuestoEntrenador">Puesto Entrenador</label>
                          </div>                       
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix green-text"></i>
                                <input type="text" id="CapacitandoFechaIngreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitandoFechaIngreso">Fecha Ingreso</label>
                           </div>
                        </div>                        
                         <div class="col-sm-12 col-lg-10">
                             <div class="col-lg-12 col-sm-12 text-center">                                
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Te dieron a conocer el tema a trabajar del día de hoy.</p>
                                <i id="Capacitando-EntrenadorR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',1,'ValorCapacitanto-EntrenadorR1',1)"></i>
                                <i id="Capacitando-EntrenadorR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',2,'ValorCapacitanto-EntrenadorR1',1)"></i>
                                <i id="Capacitando-EntrenadorR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',3,'ValorCapacitanto-EntrenadorR1',1)"></i> 
                                <input id="ValorCapacitanto-EntrenadorR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Consideras que el tema fue explicado correctamente.</p>
                                <i id="Capacitando-EntrenadorR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',1,'ValorCapacitanto-EntrenadorR2',2)"></i>
                                <i id="Capacitando-EntrenadorR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',2,'ValorCapacitanto-EntrenadorR2',2)"></i>
                                <i id="Capacitando-EntrenadorR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',3,'ValorCapacitanto-EntrenadorR2',2)"></i> 
                                <input id="ValorCapacitanto-EntrenadorR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entreador trasmite de forma clara sus conocimientos y habilidades.</p>
                                <i id="Capacitando-EntrenadorR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',1,'ValorCapacitanto-EntrenadorR3',3)"></i>
                                <i id="Capacitando-EntrenadorR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',2,'ValorCapacitanto-EntrenadorR3',3)"></i>
                                <i id="Capacitando-EntrenadorR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',3,'ValorCapacitanto-EntrenadorR3',3)"></i> 
                                <input id="ValorCapacitanto-EntrenadorR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entrenador resolvio mis dudas.</p>
                                <i id="Capacitando-EntrenadorR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',1,'ValorCapacitanto-EntrenadorR4',4)"></i>
                                <i id="Capacitando-EntrenadorR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',2,'ValorCapacitanto-EntrenadorR4',4)"></i>
                                <i id="Capacitando-EntrenadorR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',3,'ValorCapacitanto-EntrenadorR4',4)"></i> 
                                <input id="ValorCapacitanto-EntrenadorR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entrenador mostro buena actitud y disposición.</p>
                                <i id="Capacitando-EntrenadorR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',1,'ValorCapacitanto-EntrenadorR5',5)"></i>
                                <i id="Capacitando-EntrenadorR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',2,'ValorCapacitanto-EntrenadorR5',5)"></i>
                                <i id="Capacitando-EntrenadorR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Entrenador',3,'ValorCapacitanto-EntrenadorR5',5)"></i> 
                                <input id="ValorCapacitanto-EntrenadorR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarCapacitandoEntrenador()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Capacitando Evaluando a Entrenador ------------------------------------->
<!-- Modal de Capacitando Evaluando a Capacitador ------------------------------------------------->
<div class="modal fade" id="ModalCapacitandoEvaluarCapacitador" tabindex="-1" role="dialog" aria-labelledby="ModalCapacitandoEvaluarCapacitador" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVECLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente" >Evaluación de Capacitador</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">                            
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="CapacitandoNombreC" class="form-control validate" readonly="true" value=" "/>
                                <label for="CapacitandoNombreC">Capacitando</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="CapacitandoNombreCapacitador">Capacitador</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraC" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="CapacitandoNombreCapacitador" onchange="ObtenerPuestoCapacitador()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CapacitandoFechaAplicacionC" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitandoFechaAplicacionC">Fecha Aplicación</label>
                           </div> 
                        </div>
                        <div class="col-lg-4 col-sm-12">                          
                          <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="CapacitandoPuestoC" class="form-control validate" value=" "/>
                                <label for="CapacitandoPuestoC">Puesto Capacitando</label>
                          </div>
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="CapacitandoPuestoCapacitador" class="form-control validate" value=" "/>
                                <label for="CapacitandoPuestoCapacitador">Puesto Capacitador</label>
                          </div>                       
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix green-text"></i>
                                <input type="text" id="CapacitandoFechaIngresoC" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitandoFechaIngresoC">Fecha Ingreso</label>
                           </div>   
                        </div>
                         <div class="col-sm-12 col-lg-10 text-center">
                             <div class="col-lg-12 col-sm-12">
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El día de hoy te visito el capacitador.</p>
                                <i id="Capacitando-CapacitadorR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',1,'ValorCapacitanto-CapacitadorR1',1)"></i>
                                <i id="Capacitando-CapacitadorR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',2,'ValorCapacitanto-CapacitadorR1',1)"></i>
                                <i id="Capacitando-CapacitadorR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',3,'ValorCapacitanto-CapacitadorR1',1)"></i> 
                                <input id="ValorCapacitanto-CapacitadorR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Revisaron el avance de tu programa de capacitación.</p>
                                <i id="Capacitando-CapacitadorR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',1,'ValorCapacitanto-CapacitadorR2',2)"></i>
                                <i id="Capacitando-CapacitadorR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',2,'ValorCapacitanto-CapacitadorR2',2)"></i>
                                <i id="Capacitando-CapacitadorR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',3,'ValorCapacitanto-CapacitadorR2',2)"></i> 
                                <input id="ValorCapacitanto-CapacitadorR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Resolvio tus dudas.</p>
                                <i id="Capacitando-CapacitadorR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',1,'ValorCapacitanto-CapacitadorR3',3)"></i>
                                <i id="Capacitando-CapacitadorR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',2,'ValorCapacitanto-CapacitadorR3',3)"></i>
                                <i id="Capacitando-CapacitadorR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',3,'ValorCapacitanto-CapacitadorR3',3)"></i> 
                                <input id="ValorCapacitanto-CapacitadorR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Trabajaron en la práctica (Te enseño haciendo)</p>
                                <i id="Capacitando-CapacitadorR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',1,'ValorCapacitanto-CapacitadorR4',4)"></i>
                                <i id="Capacitando-CapacitadorR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',2,'ValorCapacitanto-CapacitadorR4',4)"></i>
                                <i id="Capacitando-CapacitadorR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',3,'ValorCapacitanto-CapacitadorR4',4)"></i> 
                                <input id="ValorCapacitanto-CapacitadorR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Te aplico examén de acreditación</p>
                                <i id="Capacitando-CapacitadorR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',1,'ValorCapacitanto-CapacitadorR5',5)"></i>
                                <i id="Capacitando-CapacitadorR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',2,'ValorCapacitanto-CapacitadorR5',5)"></i>
                                <i id="Capacitando-CapacitadorR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitando-Capacitador',3,'ValorCapacitanto-CapacitadorR5',5)"></i> 
                                <input id="ValorCapacitanto-CapacitadorR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarCapacitandoCapacitador()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Capacitando Evaluando a Capacitador ------------------------------------->
<!------ Modal de Enviar Encuesta Capacitando con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EncuestaCapacitandoExito" tabindex="-1" role="dialog" aria-labelledby="EncuestaCapacitandoExito" aria-hidden="true">
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
                  <div id="MensajeEncuestaCapacitandoExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Enviar Encuesta Capacitando con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al Enviar Encuesta Capacitando -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEncuestaCapacitando" tabindex="-1" role="dialog" aria-labelledby="ErrorEncuestaCapacitando" aria-hidden="true">
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
                  <div id="MensajeErrorEncuestaCapacitando">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al Enviar Encuesta Capacitando -------------------------------------------------------------------------------------------->
         <div class="text-center">
            <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalCapacitandoEvaluarEntrenador">Evaluar Entrenador<i class="fa fa-binoculars ml-2 color-fuente-strong" aria-hidden="true"></i></button>         
            <button type="button" class="btn btn-unique btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalCapacitandoEvaluarCapacitador">Evaluar Capacitador<i class="fa  fa-bullhorn ml-2 color-fuente-strong" aria-hidden="true"></i></button>            
        </div>
     </div> 
<!-- Termina contenido de Encuesta Capacitando ------------------------------------------------->
<!-- Inicia contenido de Encuesta Entrenador --------------------------------------------------->
     <div id="EncuestaEntrenador" class="tab-pane fade">
<!-- Modal de Entrenador Evaluando a Capacitando ------------------------------------------------->
<div class="modal fade" id="ModalEntrenadorEvaluarCapacitando" tabindex="-1" role="dialog" aria-labelledby="ModalEntrenadorEvaluarCapacitando" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVEECLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente" >Evaluación de Capacitando</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">                            
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="EntrenadorNombreEntrenador" class="form-control validate" readonly="true" value=" "/>
                                <label for="EntrenadorNombreEntrenador">Entrenador</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="EntrenadorNombreCapacitando">Capacitando</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraCE" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="EntrenadorNombreCapacitando" onchange="ObtenerPuestoCapacitando()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="EntrenadorFechaAplicacion" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="EntrenadorFechaAplicacion">Fecha Aplicación</label>
                           </div>    
                        </div>
                        <div class="col-lg-4 col-sm-12">
                          <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="EntrenadorPuestoEntrenador" class="form-control validate" value=" "/>
                                <label for="EntrenadorPuestoEntrenador">Puesto Entrenador</label>
                          </div>                            
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="EntreandorPuestoCapacitando" class="form-control validate" value=" "/>
                                <label for="EntreandorPuestoCapacitando">Puesto Capacitando</label>
                          </div>                     
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="EntrenadorFechaIngreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="EntrenadorFechaIngreso">Fecha Ingreso</label>
                           </div>
                        </div>
                         <div class="col-sm-12 col-lg-10">
                             <div class="col-lg-12 col-sm-12 text-center">
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El Capacitando muestra el uso de uniforme e higiene.</p>
                                <i id="Entrenador-CapacitandoR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',1,'ValorEntrenador-CapacitandoR1',1)"></i>
                                <i id="Entrenador-CapacitandoR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',2,'ValorEntrenador-CapacitandoR1',1)"></i>
                                <i id="Entrenador-CapacitandoR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',3,'ValorEntrenador-CapacitandoR1',1)"></i> 
                                <input id="ValorEntrenador-CapacitandoR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Participa activamente en el entrenamiento.</p>
                                <i id="Entrenador-CapacitandoR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',1,'ValorEntrenador-CapacitandoR2',2)"></i>
                                <i id="Entrenador-CapacitandoR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',2,'ValorEntrenador-CapacitandoR2',2)"></i>
                                <i id="Entrenador-CapacitandoR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',3,'ValorEntrenador-CapacitandoR2',2)"></i> 
                                <input id="ValorEntrenador-CapacitandoR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Tiene predisposición por aprender.</p>
                                <i id="Entrenador-CapacitandoR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',1,'ValorEntrenador-CapacitandoR3',3)"></i>
                                <i id="Entrenador-CapacitandoR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',2,'ValorEntrenador-CapacitandoR3',3)"></i>
                                <i id="Entrenador-CapacitandoR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',3,'ValorEntrenador-CapacitandoR3',3)"></i> 
                                <input id="ValorEntrenador-CapacitandoR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Pone en práctica los conocimientos enseñados.</p>
                                <i id="Entrenador-CapacitandoR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',1,'ValorEntrenador-CapacitandoR4',4)"></i>
                                <i id="Entrenador-CapacitandoR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',2,'ValorEntrenador-CapacitandoR4',4)"></i>
                                <i id="Entrenador-CapacitandoR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',3,'ValorEntrenador-CapacitandoR4',4)"></i> 
                                <input id="ValorEntrenador-CapacitandoR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Trabaja en equipo y muestra colaboración en las actividades.</p>
                                <i id="Entrenador-CapacitandoR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',1,'ValorEntrenador-CapacitandoR5',5)"></i>
                                <i id="Entrenador-CapacitandoR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',2,'ValorEntrenador-CapacitandoR5',5)"></i>
                                <i id="Entrenador-CapacitandoR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Entrenador-Capacitando',3,'ValorEntrenador-CapacitandoR5',5)"></i> 
                                <input id="ValorEntrenador-CapacitandoR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarEntrenadorCapacitando()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Entrenador Evaluando a Capacitando ------------------------------------->
<!------ Modal de Enviar Encuesta Entrenador con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EncuestaEntrenadorExito" tabindex="-1" role="dialog" aria-labelledby="EncuestaEntrenadorExito" aria-hidden="true">
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
                  <div id="MensajeEncuestaEntrenadorExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Enviar Encuesta Entrenador con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al Enviar Encuesta Entrenador -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEncuestaEntrenador" tabindex="-1" role="dialog" aria-labelledby="ErrorEncuestaEntrenador" aria-hidden="true">
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
                  <div id="MensajeErrorEncuestaEntrenador">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al Enviar Encuesta Entrenador -------------------------------------------------------------------------------------------->
              
         <div class="text-center">
            <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalEntrenadorEvaluarCapacitando">Evaluar Capacitando<i class="fa fa-binoculars ml-2 color-fuente-strong" aria-hidden="true"></i></button>                     
        </div>
     </div>   
<!-- Termina contenido de Encuesta Entrenador --------------------------------------------------->
<!-- Inicia contenido de Encuesta Capacitador --------------------------------------------------->      
     <div id="EncuestaCapacitador" class="tab-pane fade">
<!-- Modal de Capacitador Evaluando a Capacitando ------------------------------------------------->
<div class="modal fade" id="ModalCapacitadorEvaluarCapacitando" tabindex="-1" role="dialog" aria-labelledby="ModalCapacitadorEvaluarCapacitando" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVCCLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Evaluación de Capacitando</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="CapacitadorNombreCapacitador" class="form-control validate" readonly="true" value=" "/>
                                <label for="CapacitadorNombreCapacitador">Capacitador</label>
                           </div>                            
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="CapacitadorNombreCapacitando">Capacitando</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraCC" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="CapacitadorNombreCapacitando" onchange="ObtenerPuestoCapacitadorCapacitando()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CapacitadorFechaAplicacion" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitadorFechaAplicacion">Fecha Aplicación</label>
                           </div>
                        </div>
                        <div class="col-lg-4 col-sm-12">                          
                          <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="CapacitadorPuestoCapacitador" class="form-control validate" value=" "/>
                                <label for="CapacitadorPuestoCapacitador">Puesto Capacitador</label>
                          </div>   
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="CapacitadorPuestoCapacitando" class="form-control validate" value=" "/>
                                <label for="CapacitadorPuestoCapacitando">Puesto Capacitando</label>
                          </div>                     
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="CapacitadorFechaIngreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitadorFechaIngreso">Fecha Ingreso</label>
                           </div>    
                        </div>
                         <div class="col-sm-12 col-lg-10">
                             <div class="col-lg-12 col-sm-12 text-center">
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El capacitando a mostrado asistencia y puntualidad.</p>
                                <i id="Capacitador-CapacitandoR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',1,'ValorCapacitador-CapacitandoR1',1)"></i>
                                <i id="Capacitador-CapacitandoR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',2,'ValorCapacitador-CapacitandoR1',1)"></i>
                                <i id="Capacitador-CapacitandoR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',3,'ValorCapacitador-CapacitandoR1',1)"></i> 
                                <input id="ValorCapacitador-CapacitandoR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El Capacitando muestra el uso de uniforme e higiene.</p>
                                <i id="Capacitador-CapacitandoR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',1,'ValorCapacitador-CapacitandoR2',2)"></i>
                                <i id="Capacitador-CapacitandoR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',2,'ValorCapacitador-CapacitandoR2',2)"></i>
                                <i id="Capacitador-CapacitandoR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',3,'ValorCapacitador-CapacitandoR2',2)"></i> 
                                <input id="ValorCapacitador-CapacitandoR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Revisaron el avance de tu programa de capacitación.</p>
                                <i id="Capacitador-CapacitandoR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',1,'ValorCapacitador-CapacitandoR3',3)"></i>
                                <i id="Capacitador-CapacitandoR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',2,'ValorCapacitador-CapacitandoR3',3)"></i>
                                <i id="Capacitador-CapacitandoR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',3,'ValorCapacitador-CapacitandoR3',3)"></i> 
                                <input id="ValorCapacitador-CapacitandoR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Es una persona proactiva y tiene una actitud positiva.</p>
                                <i id="Capacitador-CapacitandoR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',1,'ValorCapacitador-CapacitandoR4',4)"></i>
                                <i id="Capacitador-CapacitandoR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',2,'ValorCapacitador-CapacitandoR4',4)"></i>
                                <i id="Capacitador-CapacitandoR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',3,'ValorCapacitador-CapacitandoR4',4)"></i> 
                                <input id="ValorCapacitador-CapacitandoR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Domina los conocimientos enseñados en la práctica.</p>
                                <i id="Capacitador-CapacitandoR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',1,'ValorCapacitador-CapacitandoR5',5)"></i>
                                <i id="Capacitador-CapacitandoR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',2,'ValorCapacitador-CapacitandoR5',5)"></i>
                                <i id="Capacitador-CapacitandoR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Capacitando',3,'ValorCapacitador-CapacitandoR5',5)"></i> 
                                <input id="ValorCapacitador-CapacitandoR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarCapacitadorCapacitando()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Capacitador Evaluando a Capacitando ------------------------------------->
<!-- Modal de Capacitador Evaluando a Entrenador ------------------------------------------------->
<div class="modal fade" id="ModalCapacitadorEvaluarEntrenador" tabindex="-1" role="dialog" aria-labelledby="ModalCapacitadorEvaluarEntrenador" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVCELogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Evaluación de Entrenador</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">                            
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="CapacitadorNombreCapacitadorE" class="form-control validate" readonly="true" value=" "/>
                                <label for="CapacitadorNombreCapacitadorE">Capacitador</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="CapacitadorNombreEntrenador">Entrenador</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraCEE" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="CapacitadorNombreEntrenador" onchange="ObtenerPuestoCapacitadorEntrenador()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="CapacitadorFechaAplicacionEntrenador" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitadorFechaAplicacionEntrenador">Fecha Aplicación</label>
                           </div>  
                        </div>
                        <div class="col-lg-4 col-sm-12">                          
                           <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="CapacitadorPuestoCapacitadorE" class="form-control validate" value=" "/>
                                <label for="CapacitadorPuestoCapacitadorE">Puesto Capacitador</label>
                          </div>  
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="CapacitadorPuestoEntrenador" class="form-control validate" value=" "/>
                                <label for="CapacitadorPuestoEntrenador">Puesto Entrenador</label>
                          </div>                     
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="CapacitadorFechaIngresoEntrenador" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="CapacitadorFechaIngresoEntrenador">Fecha Ingreso</label>
                           </div>  
                        </div>
                         <div class="col-sm-12 col-lg-10">
                             <div class="col-lg-12 col-sm-12 text-center">
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Informa al capacitando el tema a trabajar ese día.</p>
                                <i id="Capacitador-EntrenadorR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',1,'ValorCapacitador-EntrenadorR1',1)"></i>
                                <i id="Capacitador-EntrenadorR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',2,'ValorCapacitador-EntrenadorR1',1)"></i>
                                <i id="Capacitador-EntrenadorR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',3,'ValorCapacitador-EntrenadorR1',1)"></i> 
                                <input id="ValorCapacitador-EntrenadorR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entreador trasmite de forma clara sus conocimientos y habilidades.</p>
                                <i id="Capacitador-EntrenadorR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',1,'ValorCapacitador-EntrenadorR2',2)"></i>
                                <i id="Capacitador-EntrenadorR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',2,'ValorCapacitador-EntrenadorR2',2)"></i>
                                <i id="Capacitador-EntrenadorR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',3,'ValorCapacitador-EntrenadorR2',2)"></i> 
                                <input id="ValorCapacitador-EntrenadorR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Enseña en la práctica, haciendo las funciones.</p>
                                <i id="Capacitador-EntrenadorR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',1,'ValorCapacitador-EntrenadorR3',3)"></i>
                                <i id="Capacitador-EntrenadorR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',2,'ValorCapacitador-EntrenadorR3',3)"></i>
                                <i id="Capacitador-EntrenadorR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',3,'ValorCapacitador-EntrenadorR3',3)"></i> 
                                <input id="ValorCapacitador-EntrenadorR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entrenador resolve de forma correscta las dudas.</p>
                                <i id="Capacitador-EntrenadorR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',1,'ValorCapacitador-EntrenadorR4',4)"></i>
                                <i id="Capacitador-EntrenadorR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',2,'ValorCapacitador-EntrenadorR4',4)"></i>
                                <i id="Capacitador-EntrenadorR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',3,'ValorCapacitador-EntrenadorR4',4)"></i> 
                                <input id="ValorCapacitador-EntrenadorR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El entrenador mostro buena actitud y disposición.</p>
                                <i id="Capacitador-EntrenadorR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',1,'ValorCapacitador-EntrenadorR5',5)"></i>
                                <i id="Capacitador-EntrenadorR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',2,'ValorCapacitador-EntrenadorR5',5)"></i>
                                <i id="Capacitador-EntrenadorR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('Capacitador-Entrenador',3,'ValorCapacitador-EntrenadorR5',5)"></i> 
                                <input id="ValorCapacitador-EntrenadorR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarCapacitadorEntrenador()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Capacitador Evaluando a Entrenador ------------------------------------->
<!------ Modal de Enviar Encuesta Capacitador con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EncuestaCapacitadorEvaluaExito" tabindex="-1" role="dialog" aria-labelledby="EncuestaCapacitadorEvaluaExito" aria-hidden="true">
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
                  <div id="MensajeEncuestaCapacitadoEvaluarExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Enviar Encuesta Capacitador con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al Enviar Encuesta Capacitador -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEncuestaCapacitadorEvalua" tabindex="-1" role="dialog" aria-labelledby="ErrorEncuestaCapacitadorEvalua" aria-hidden="true">
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
                  <div id="MensajeErrorEncuestaCapacitadorEvalua">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al Enviar Encuesta Capacitador -------------------------------------------------------------------------------------------->
        <div class="text-center">
            <div class="col-sm-12 col-lg-6">                
                <select class="form-control" id="SelectUnidadCapacitador"></select>
            </div>
            <div class="col-sm-12 col-lg-6">
                <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalCapacitadorEvaluarCapacitando">Evaluar Capacitando<i class="fa fa-binoculars ml-2 color-fuente-strong" aria-hidden="true"></i></button>                     
                <button type="button" class="btn btn-unique btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalCapacitadorEvaluarEntrenador">Evaluar Entrenador<i class="fa fa-binoculars ml-2 color-fuente-strong" aria-hidden="true"></i></button>
            </div>
        </div>
     </div>        
<!-- Termina contenido de Encuesta Capacitador -------------------------------------------------->
<!-- Inicia contenido de Encuesta Jefe Directo -------------------------------------------------->
     <div id="EncuestaJefeInmediato" class="tab-pane fade">
<!-- Modal de Jefe Directo Evaluando a Capacitador ------------------------------------------------->
<div class="modal fade" id="ModalJefeDirectoEvaluarCapacitador" tabindex="-1" role="dialog" aria-labelledby="ModalJefeDirectoEvaluarCapacitador" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVJDCLogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Evaluación de Capacitador</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix green-text"></i>
                                <input type="text" id="JefeDirectoNombreJefeDirecto" class="form-control validate" readonly="true" value=" "/>
                                <label for="JefeDirectoNombreJefeDirecto">Jefe Directo</label>
                           </div>                            
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>                           
                                <label for="JefeDirectoNombreCapacitador">Capacitador</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraJD" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="JefeDirectoNombreCapacitador" onchange="ObtenerPuestoCapacitadorJefeDirecto()">                                    
                                </select>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="JefeDirectoFechaAplicacionEntrenador" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="JefeDirectoFechaAplicacionEntrenador">Fecha Aplicación</label>
                           </div>   
                        </div>
                        <div class="col-lg-4 col-sm-12">                          
                          <div class="md-form">
                                <i class="fa fa-star prefix green-text"></i>
                                <input type="text" id="JefeDirectoPuestoJefeDirecto" class="form-control validate" value=" "/>
                                <label for="JefeDirectoPuestoJefeDirecto">Puesto Jefe Directo</label>
                          </div> 
                          <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                                <input type="text" id="JefeDirectoPuestoCapacitador" class="form-control validate" value=" "/>
                                <label for="JefeDirectoPuestoCapacitador">Puesto Capacitador</label>
                          </div>                      
                        </div>
                        <div class="col-lg-4 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="JefeDirectoFechaIngreso" class="form-control validate" readonly="true" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" "/>
                                <label for="JefeDirectoFechaIngreso">Fecha Ingreso</label>
                           </div> 
                        </div>
                         <div class="col-sm-12 col-lg-10">
                             <div class="col-lg-12 col-sm-12 text-center">
                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> El Capacitador visito tu unidad.</p>
                                <i id="JefeDirecto-CapacitadorR1S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',1,'ValorJefeDirecto-CapacitadorR1',1)"></i>
                                <i id="JefeDirecto-CapacitadorR1S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',2,'ValorJefeDirecto-CapacitadorR1',1)"></i>
                                <i id="JefeDirecto-CapacitadorR1S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',3,'ValorJefeDirecto-CapacitadorR1',1)"></i> 
                                <input id="ValorJefeDirecto-CapacitadorR1" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Muestra disposición por enseñar.</p>
                                <i id="JefeDirecto-CapacitadorR2S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',1,'ValorJefeDirecto-CapacitadorR2',2)"></i>
                                <i id="JefeDirecto-CapacitadorR2S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',2,'ValorJefeDirecto-CapacitadorR2',2)"></i>
                                <i id="JefeDirecto-CapacitadorR2S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',3,'ValorJefeDirecto-CapacitadorR2',2)"></i> 
                                <input id="ValorJefeDirecto-CapacitadorR2" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Si estuvo impratiendo la capacitación en el tiempo establecido.</p>
                                <i id="JefeDirecto-CapacitadorR3S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',1,'ValorJefeDirecto-CapacitadorR3',3)"></i>
                                <i id="JefeDirecto-CapacitadorR3S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',2,'ValorJefeDirecto-CapacitadorR3',3)"></i>
                                <i id="JefeDirecto-CapacitadorR3S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',3,'ValorJefeDirecto-CapacitadorR3',3)"></i> 
                                <input id="ValorJefeDirecto-CapacitadorR3" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Realizo retroalimentación al capacitando.</p>
                                <i id="JefeDirecto-CapacitadorR4S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',1,'ValorJefeDirecto-CapacitadorR4',4)"></i>
                                <i id="JefeDirecto-CapacitadorR4S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',2,'ValorJefeDirecto-CapacitadorR4',4)"></i>
                                <i id="JefeDirecto-CapacitadorR4S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',3,'ValorJefeDirecto-CapacitadorR4',4)"></i> 
                                <input id="ValorJefeDirecto-CapacitadorR4" hidden="hidden" readonly="true"/><br />

                                <p><i class="fa fa-chevron-right prefix fa-1x red-text"></i> Como evaluas la capacitación y seguimiento a la misma.</p>
                                <i id="JefeDirecto-CapacitadorR5S1" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',1,'ValorJefeDirecto-CapacitadorR5',5)"></i>
                                <i id="JefeDirecto-CapacitadorR5S2" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',2,'ValorJefeDirecto-CapacitadorR5',5)"></i>
                                <i id="JefeDirecto-CapacitadorR5S3" class="fa fa-star-o amber-text fa-3x limpiar" aria-hidden="true" onclick="ClickEstrella('JefeDirecto-Capacitador',3,'ValorJefeDirecto-CapacitadorR5',5)"></i> 
                                <input id="ValorJefeDirecto-CapacitadorR5" hidden="hidden" readonly="true"/><br />
                             </div>
                         </div>                         
                    </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-default" onclick="EnviarJefeDirectoCapacitador()">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Jefe Directo Evaluando a Capacitador ------------------------------------->
<!------ Modal de Enviar Encuesta Jefe Directo con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="EncuestaJefeDirectoExito" tabindex="-1" role="dialog" aria-labelledby="EncuestaJefeDirectoExito" aria-hidden="true">
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
                  <div id="MensajeEncuestaJefeDirectoExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Enviar Encuesta Jefe Directo con Éxito------------------------------------------------------------------------->
<!-- Modal de Error al Enviar Encuesta Jefe Directo -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorEncuestaJefeDirecto" tabindex="-1" role="dialog" aria-labelledby="ErrorEncuestaJefeDirecto" aria-hidden="true">
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
                  <div id="MensajeErrorEncuestaJefeDirecto">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error al Enviar Encuesta Jefe Directo -------------------------------------------------------------------------------------------->
        <div class="text-center">                        
            <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerInfoUsuarioCapacitando()" data-target="#ModalJefeDirectoEvaluarCapacitador">Evaluar Capacitador<i class="fa fa-binoculars ml-2 color-fuente-strong" aria-hidden="true"></i></button>                                                      
        </div>
     </div>
<!-- Termina contenido de Encuesta Jefe Directo ------------------------------------------------->     
<!-- Inicia contenido de Administración --------------------------------------------------------->
     <div id="Administracion" class="tab-pane fade">
<!-- Modal de Administrar Usuarios ------------------------------------------------->
<div class="modal fade" id="ModalAdminUsuarios" tabindex="-1" role="dialog" aria-labelledby="ModalAdminUsuarios" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVAULogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Administración de Usuarios</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-8 col-sm-12">
                            <button type="button" class="btn btn-info btn-rounded mb-lg" data-toggle="modal" onclick="ObtenerDatosAltaUsuario()" data-target="#ModalAgregarUsuario">Agregar Usuario<i class="fa fa-user-plus ml-2 color-fuente-strong" aria-hidden="true"></i></button>                            
                            <div class="col-lg-6 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-hashtag prefix grey-text"></i>
                                    <input type="text" id="AdminNumEmpleado" class="form-control validate"  value=""/>
                                    <label for="AdminNumEmpleado">Número de Empleado</label>                                    
                                </div>
                                <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearTablaAdminUsuarios()">Buscar<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                            </div>          
                            <div id="TablaUsuarios">
                                                                
                            </div>
                        </div>            
                     </div>  
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Administrar Usuarios ------------------------------------->
<!-- Modal de Agregar Usuario ------------------------------------------------->
<div class="modal fade" id="ModalAgregarUsuario" tabindex="-1" role="dialog" aria-labelledby="ModalAgregarUsuario" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title color-fuente-strong color-fuente">Agregar Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix blue-text"></i>
                                <input type="text" id="NumeroEmpleado" class="form-control validate" value="" onblur="ObtenerInfoEmpleado()"/>
                                <label for="NumeroEmpleado">Número de Empleado</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-star prefix blue-text"></i>
                               <input type="text" id="PuestoEmpleado" class="form-control validate" value=" " readonly="true"/>                           
                                <label for="PuestoEmpleado">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-gears prefix blue-text"></i>                           
                                <label for="RolEmpleado">Rol</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraADR" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="RolEmpleado" >                                    
                                </select>
                           </div>
                        </div>            
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix blue-text"></i>
                                <input type="text" id="NombreEmpleado" class="form-control validate" value=" " readonly="true"/>
                                <label for="NombreEmpleado">Nombre</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix blue-text"></i>
                                <input type="text" id="FechaIngresoEmpleado" class="form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" readonly="true" value=" "/>
                                <label for="FechaIngresoEmpleado">Fecha Ingreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-trophy prefix blue-text"></i>
                                <input type="text" id="DiasCapacitacion" class="form-control validate"/>
                                <label for="DiasCapacitacion">No de días de capacitación</label>
                           </div>
                        </div>            
                     </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-rounded mb-lg" onclick="AgregarUsuario()">Agregar<i class="fa fa-thumbs-o-up ml-2 color-fuente-strong" aria-hidden="true"></i></button>                
            </div>
        </div>
    </div>
</div>
<!-- Termina Modal de Agregar Usuario ------------------------------------->       
<!-- Modal de Modificar Usuario ------------------------------------------------->
<div class="modal fade" id="ModalModificarUsuario" tabindex="-1" role="dialog" aria-labelledby="ModalModificarUsuario" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title color-fuente-strong color-fuente">Modificar Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-user prefix grey-text"></i>
                                <input type="text" id="NombreEmpleadoM" class="form-control validate" readonly="true" value=" "/>
                                <label for="NombreEmpleadoM">Nombre</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-star prefix grey-text"></i>
                                <input type="text" id="PuestoEmpleadoM" class="form-control validate" readonly="true" value=" "/>                           
                                <label for="PuestoEmpleadoM">Puesto</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-gears prefix grey-text"></i>                           
                                <label for="RolEmpleadoM">Rol</label>
                           </div>
                           <div class="md-form">
                               <input type="text" id="InputextraADRM" class="form-control validate" readonly="true"/>
                                <select class="form-control" id="RolEmpleadoM" onchange="VerificarRol()">                                    
                                </select>
                                <p>Especialidad: </p>
                           </div>
                        </div>            
                        <div class="col-lg-6 col-sm-12">
                           <div class="md-form">
                                <i class="fa fa-hashtag prefix grey-text"></i>
                                <input type="text" id="NumeroEmpleadoM" class="form-control validate" value=" " readonly="true"/>
                                <label for="NumeroEmpleadoM">Número de Empleado</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-calendar prefix grey-text"></i>
                                <input type="text" id="FechaIngresoEmpleadoM" class="form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy" value=" " readonly="true"/>
                                <label for="FechaIngresoEmpleadoM">Fecha Ingreso</label>
                           </div>
                           <div class="md-form">
                                <i class="fa fa-trophy prefix blue-text"></i>
                                <input type="text" id="DiasCapacitacionModificar" class="form-control validate" value=" "/>
                                <label for="DiasCapacitacionModificar">No de días de capacitación</label>
                           </div>
                        </div>                        
                        <div id="Especialidad" class="row" style="margin-left:10px;">                                                                                                                                          
                                Cocina
                                <label class="contenedor">
                                    <input type="checkbox" name="EspecialidadCapacitador" id="Cocina" value="0"/>
                                    <span class="marcado"></span>
                                </label>
                                Piso
                                <label class="contenedor">
                                    <input type="checkbox" name="EspecialidadCapacitador" id="Piso" value="1"/>
                                    <span class="marcado"></span>
                                </label>                            
                                Panaderia
                                <label class="contenedor">
                                    <input type="checkbox" name="EspecialidadCapacitador" id="Panaderia" value="2"/>
                                    <span class="marcado"></span>
                                </label>
                                Almacen
                                <label class="contenedor">
                                    <input type="checkbox" name="EspecialidadCapacitador" id="Almacen" value="3"/>
                                    <span class="marcado"></span>
                                </label>
                                <select id="UnidadesAsignadas" class="selectpicker" multiple>
                                </select>                         
                            </div>                                                                                                            
                     </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-rounded mb-lg" onclick="GuardarModificacionesuUsuario()">Guardar Cambios<i class="fa fa-thumbs-o-up ml-2 color-fuente-strong" aria-hidden="true"></i></button>          
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Modificar Usuario ------------------------------------->
<!------ Modal de Administrativo con Éxito ------------------------------------------------------------------------------->        
  <div class="modal fade" id="AdministrativoExito" tabindex="-1" role="dialog" aria-labelledby="AdministrativoExito" aria-hidden="true">
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
                  <div id="MensajeAdministrativoExito">
                  </div>             
              </div>                                                    
          </div>            
          <div class="modal-footer justify-content-center">              
              <a type="button" class="btn btn-success" data-dismiss="modal">OK<i class="fa fa-thumbs-o-up ml-1"></i></a> 
          </div>
      </div>      
  </div>
  </div>
<!-----Finaliza Modal de Administrativo con Éxito------------------------------------------------------------------------->
<!-- Modal de Reporte Acreditación ------------------------------------------------->
<div class="modal fade" id="ModalReporteAcreditacion" tabindex="-1" role="dialog" aria-labelledby="ModalReporteAcreditacion" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <img id="MDVARALogo" src="img/Logo.png" class="rounded text-center" alt="Responsive image" style="width:7.50%; margin-right:10px;"/>
                <h5 class="modal-title w-100 font-weight-bold color-fuente">Acreditación</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">                                                    
                            <div class="col-lg-4 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaIniAC" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaIniAC">Fecha Inicio</label>
                                </div>
                                <div class="md-form">                                                      
                                    <label for="ReporteUnidadNegocioAC">Unidad de Negocio</label>
                                </div>
                                <div class="md-form">
                                    <input type="text" id="ReporteADAC" class="form-control validate" readonly="true"/>
                                    <select class="form-control" id="ReporteUnidadNegocioAC" onchange="">                                    
                                    </select>
                               </div>                                                                
                            </div>
                            <div class="col-lg-4 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaFinAC" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaFinAC">Fecha Fin</label>
                                </div>
                                <div class="md-form">
                                    <i class="fa fa-hashtag prefix grey-text"></i>
                                    <input type="text" id="NumeroEmpleadoRAC" class="form-control validate"  value=""/>
                                    <label for="NumeroEmpleadoRAC">Número de Empleado</label>                                    
                                </div>
                            </div>          
                            <div class="col-lg-4 col-sm-12">
                                <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearTablaReporteAcreditacion()">Buscar<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                                <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteAcreditacion','ReporteAcreditación')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                            </div>
                            <div id="TablaReporteAcreditacion">
                                                                
                            </div>                                    
                     </div>  
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Reporte Acreditación ------------------------------------->
<!-- Modal de agregar observaciones a usuario ------------------------->
<div class="modal fade" id="ModalObservacionesUsuario" tabindex="-1" role="dialog" aria-labelledby="ModalObservacionesUsuario" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold color-fuente">Observaciones</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-12">
                    <div class="md-form">
                        <i class="fa fa-pencil prefix grey-text"></i>
                        <input id="IDU" readonly="true" hidden="hidden" />
                        <textarea  id="AOUObservaciones" class="md-textarea form-control" rows="4"></textarea>
                        <label for="AOUObservaciones">Observaciones</label>
                    </div>                                                                                 
                </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-default" onclick="GuardarObservacionesUsuario()">Agregar <i class="fa fa-thumbs-o-up ml-1"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Finaliza Modal de agregar observaciones a usuario ---------------->
<!-- Modal de Error Administrativo -------------------------------------------------------------------------------------------------->
  <div class="modal fade" id="ErrorAdministrativo" tabindex="-1" role="dialog" aria-labelledby="ErrorAdministrativo" aria-hidden="true">
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
                  <div id="MensajeErrorAdministrativo">

                  </div>
              </div>
          </div>           
          <div class="modal-footer justify-content-center">
              <a type="button" class="btn btn-danger" data-dismiss="modal">Entendido<i class="fa fa-thumbs-o-up ml-1"></i></a>              
          </div>
      </div>      
  </div>
  </div>
<!--Finaliza Modal de Error Administrativo -------------------------------------------------------------------------------------------->
        <div class="text-center">
          <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="" data-target="#ModalAdminUsuarios">Usuarios<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>                    
          <button type="button" class="btn btn-dark-green btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalReporteAcreditacion()" data-target="#ModalReporteAcreditacion">Acreditación<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>                                
        </div>
     </div>
<!-- Termina contenido de Administración -------------------------------------------------------->
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
                            </div>
                            <div class="col-lg-4 col-sm-12">
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaFin" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaFin">Fecha Fin</label>
                                </div>
                                <div class="md-form">                                                      
                                    <label for="ReporteTipoEncuesta">Tipo de Encuesta</label>
                                </div>
                                <div class="md-form">
                                    <input type="text" id="ReporteADT" class="form-control validate" readonly="true"/>
                                    <select class="form-control" id="ReporteTipoEncuesta" onchange="">                                    
                                    </select>
                               </div>  
                            </div>          
                            <div class="col-lg-4 col-sm-12">
                                <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearTablaReporteConcentrado()">Buscar<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                                <button type="button" class="btn btn-dark-green" onclick="DescargarExcel('TablaReporteConcentrado','ReporteConcentrado')">Descargar<i class="fa fa-cloud-download ml-2 color-fuente-strong" aria-hidden="true"></i></button>
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
<!-- Modal de Reporte Detalle ------------------------------------------------->
<div class="modal fade" id="ModalReporteDetalle" tabindex="-1" role="dialog" aria-labelledby="ModalReporteDetalle" aria-hidden="true">
    <div class="modal-dialog modal-fluid" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title color-fuente-strong color-fuente">Detalle</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                     <div class="form-row">                          
                         <div id="TablaDetalleReporte">

                         </div>
                     </div>  
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- Terminda Modal de Reporte Detalle ------------------------------------->
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
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaIniGrafica" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaIniGrafica">Fecha Inicio</label>
                                <div class="md-form">
                                    <i class="fa fa-calendar prefix grey-text"></i>
                                    <input type="text" id="FechaFinGrafica" class="form_date form-control validate" data-date-format="dd-mm-yyyy" data-link-format="dd-mm-yyyy"/>
                                    <label for="FechaFinGrafica">Fecha Fin</label>
                                </div>
                                </div>  
                         </div>                                                 
                         <div class="col-sm-12 col-lg-6">
                             <button type="button" class="btn btn-info btn-rounded mb-lg" onclick="CrearGraficaEncuestaUnidad()">Buscar<i class="fa fa- ml-2 color-fuente-strong" aria-hidden="true"></i></button>
                         </div>                                                  
                        <div id="GEncuestaUnidad" class="col-lg-6 col-sm-12">                        
                        
                        </div>
                        <div id="GPromedioUnidad" class="col-lg-6 col-sm-12">                        
                        
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
          <button type="button" class="btn btn-default btn-rounded mb-lg" data-toggle="modal" onclick="LimpiarModalReporteConcentrado()" data-target="#ModalReporteConcentrado">Reportes<i class="fa fa-users ml-2 color-fuente-strong" aria-hidden="true"></i></button>                  
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
<!-- Inicia DIV de cargando-->
<div id="myNav" class="overlay">      
  <div class="overlay-content">
    <img src="IMG/gears.gif" />
    <p>Estamos trabajando en su petición espere por favor.</p>
  </div>
</div>
<!-- Termina DIV de cargando--> 
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
        
        var numeroempleado = $.OURL("NE");
        $("#0").hide();
        $("#1").hide();
        $("#2").hide();
        $("#3").hide();
        $("#4").hide();
        $("#5").hide();

        $("#M1").hide();
        $("#M2").hide();
        $("#M3").hide();
        $("#M4").hide();
        $("#M5").hide();

        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerIdRolUsuario",
            data: '{numempleado:"' + numeroempleado + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch(result.d)
                {
                    case 0:
                        console.log("Error al obtener el id del rol del usuario.");
                        break;
                    case 1:
                        $("#0").show();
                        $("#ModalInstrucciones").modal('show');
                        $("#M3").show();
                        break;
                    case 2:
                        $("#1").show();
                        $("#ModalInstrucciones").modal('show');
                        $("#M2").show();
                        break;
                    case 3:
                        $("#2").show();
                        $("#ModalInstrucciones").modal('show');
                        $("#M4").show();
                        break;
                    case 4:
                        $("#3").show();
                        $("#ModalInstrucciones").modal('show');
                        $("#M1").show();
                        break;
                    case 5:
                        $("#4").show();
                        $("#5").show();
                        $("#M5").show();
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });        
    }
    );
    </script>
</html>
