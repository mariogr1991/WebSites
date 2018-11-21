<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link  rel="shortcut icon" href="IMG/Logo.png"/>
    <link rel="stylesheet" href="DashBoard/css/normalize.css"/>
    <link rel="stylesheet" href="DashBoard/css/bootstrap.min.css" />
    <link rel="stylesheet" href="DashBoard/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="DashBoard/css/themify-icons.css"/>
    <link rel="stylesheet" href="DashBoard/css/flag-icon.min.css"/>
    <link rel="stylesheet" href="DashBoard/css/cs-skin-elastic.css"/>
    <link rel="stylesheet" href="DashBoard/scss/style.css"/>
    <link rel="stylesheet"  href="DashBoard/css/lib/chosen/chosen.min.css"/>
    <link rel="stylesheet"  href="CSS/Style.css"/>
    <script src="JS/Funciones.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Sistema Integral de Información</title>
</head>
<body>
  <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="./"><img src="IMG/Logo.png" alt="Logo"/></a>
                <a class="navbar-brand hidden" href="./"><img src="IMG/Logo.png" alt="Logo"/></a>                
            </div>

            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index.html" class="TituloDash">Sistema Integral de Información</a>
                    </li>
                    <h3 class="TituloDash" id="NombreUsuario"></h3><!-- /.menu-title -->
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside><!-- /#left-panel -->

    <!-- Left Panel -->

    <!-- Right Panel -->

<div id="right-panel" class="right-panel">

        <!-- Header-->
        <header id="header" class="header">

            <div class="header-menu">

                <div class="col-sm-7">
                    <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                    <div class="header-left">    

                    </div>
                </div>

                <div class="col-sm-5">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="IMG/Usuarios/admin.jpg" alt="User Avatar" style="width:40%;"/>
                        </a>

                        <div class="user-menu dropdown-menu">
                                <a class="nav-link" href="#" onclick="CerrarSesion()"><i class="ti-power-off"></i> Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </header><!-- /header -->
        <!-- Header-->
        <div class="content mt-3">
                <div class="col-sm-12 col-lg-12">    
                    <!--Contendor donde se localizaran los iconos de los menus de acuerdo al puesto del usuario logueado -->                
                    <div class="notificaciones" id="PanelMenuUsuario">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                        
                    </div>
                </div>
            <!--Inicia Modal de Perfiles ------------------------------------------------------------------------------------------------------->
                <div class="modal fade" id="ModalPerfiles" tabindex="-1" role="dialog" aria-labelledby="ModalPerfilesLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="ModalPerfilesLabel">Perfiles</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                               <div class="col-sm-12 col-lg-4 col-md-8">
                                  <div class="card">
                                    <div class="card-header">
                                        <strong class="card-title">Puestos</strong>
                                    </div>
                                   <div class="card-body">
                                        <select data-placeholder="Seleccione un puesto" class="standardSelect" id="Puesto" tabindex="1">             
                                        </select>
                                   </div>
                                  </div>
                                </div>
                                <div class="col-sm-12 col-lg-4 col-md-8">
                                    <div class="card">
                                        <div class="card-header">
                                            <strong class="card-title">Aplicación</strong>
                                        </div>
                                        <div class="card-body">
                                            <select data-placeholder="Seleccione Aplicación" class="standardSelect" id="Menus">
 
                                            </select>
                                       </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-lg-4 col-md-8">
                                    <div class="card">
                                        <div class="card-header">
                                            <strong class="card-title">Rol</strong>
                                        </div>
                                        <div class="card-body">
                                            <select data-placeholder="Seleccione Rol" class="standardSelect" id="Rol">
 
                                            </select>
                                       </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" onclick="GuardarPuestoMenu()">Guardar Cambios</button>
                            </div>
                        </div>
                    </div>
                </div>   
            <!--Termina Modal de Perfiles ------------------------------------------------------------------------------------------------------->
            <!--Inicia Modal de Menus/Aplicaciones ---------------------------------------------------------------------------------------------->
                <div class="modal fade" id="ModalMenus" tabindex="-1" role="dialog" aria-labelledby="ModalMenusLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="ModalMenusLabel">Menus</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="col-lg-12 col-sm-12 col-md-12">
                                    <div class="card">
                                        <div class="card-header"><strong>Agregar Menu/Aplicación</strong></div>
                                            <div class="card-body card-block">
                                                <div class="form-group"><label for="NombreMenu" class=" form-control-label">Nombre Menu/Aplicación</label><input type="text" id="NombreMenu" placeholder="Ingrese el nombre" class="form-control"/></div>
                                                <div class="form-group"><label for="URLMenu" class=" form-control-label">URL</label><input type="text" id="URLMenu" placeholder="Ingrese la URL" class="form-control"/></div>
                                                <div class="row form-group">
                                                    <div class="col col-md-3 col-lg-3"><label class="form-control-label">Tipo:</label></div>
                                                    <div class="col col-md-9 col-lg-9">
                                                        <div class="form-check-inline form-check">
                                                            <label for="inline-radio1" class="form-check-label ">
                                                                <input type="radio" id="TipoPadre" name="TipoMenu" value="0" class="form-check-input"/>Padre
                                                            </label>
                                                            <label for="inline-radio2" class="form-check-label ">
                                                                <input type="radio" id="TipoHijo" name="TipoMenu" value="1" class="form-check-input"/>Hijo
                                                            </label>
                                                       </div>
                                                  </div>
                                              </div>
                                              <div class="row form-group" id="SelectMenuPadre">
                                                    <div class="col col-md-3"><label for="select" class=" form-control-label">Menu Padre</label></div>
                                                    <div class="col-12 col-md-9">
                                                        <select name="select" id="MenuPadre" class="form-control">
                                                            
                                                        </select>
                                                    </div>
                                                </div>
                                              <div class="row form-group" id="SubirIconoPadre">
                                                    <div class="col col-md-3"><label for="file-input" class=" form-control-label">Subir Icono</label></div>                                                    
                                                    <div class="col-12 col-md-9"><input type="file" id="IconoPadre" name="file-input" class="form-control-file"/></div>
                                             </div>
                                             <div class="row form-group" id="SelectIconoHijo">                                                    
                                                    <div class="col-12 col-md-9">
                                                        <div class="form-group"><label for="IconoHijo" class=" form-control-label">Icono Hijo</label><input type="text" id="IconoHijo" placeholder="Ingrese la clase del icono" class="form-control"/></div>
                                                    </div>
                                                </div>                                                
                                           </div>
                                      </div>
                                 </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" onclick="GuardarMenu()">Confirmar</button>
                            </div>
                        </div>
                    </div>
                </div>
            <!--Termina Modal de Menus/Aplicaciones ---------------------------------------------------------------------------------------------->
            <!--Inicia Modal de Usuarios --------------------------------------------------------------------------------------------------------->
                <div class="modal fade" id="ModalUsuarios" tabindex="-1" role="dialog" aria-labelledby="ModalUsuariosLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="ModalUsuariosLabel">Perfiles</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="col-lg-12 col-sm-12 col-md-12">
                                    <div class="card">
                                        <div class="card-header"><strong>Agregar Menu/Aplicación</strong></div>
                                            <div class="card-body card-block">
                                                <div class="form-group"><label for="NumeroEmpleado" class=" form-control-label">Número de Empleado</label><input type="text" id="NumeroEmpleado" placeholder="Ingrese el número de empleado" class="form-control"/></div>                                               
                                           </div>
                                      </div>
                                 </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" onclick="GenerarUsuario()">Generar Usuario</button>
                            </div>
                        </div>
                    </div>
                </div>   
            <!--Termina Modal de Usuarios ----------------------------------------------------------------------------------------------------->                    
        </div> <!-- .content -->
    </div><!-- /#right-panel -->

    <!-- Right Panel -->


    <%--<script src="DashBoard/js/vendor/jquery-2.1.4.min.js"></script>--%>
    <script src="JS/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
    <script src="DashBoard/js/plugins.js"></script>
    <script src="DashBoard/js/main.js"></script>   
    <script src="DashBoard/js/lib/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript">
        var $ = jQuery;
        $(document).ready(function () {

            $("#SubirIconoPadre").hide();
            $("#SelectIconoHijo").hide();
            $("#SelectMenuPadre").hide();

            $.ajax({
                type: "POST",
                url: "Home.aspx/CrearMenu",
                data: '{NumeroEmpleado:"' + ObtenerNumeroEmpleado() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    $("#PanelMenuUsuario").append(result.d);
                    $.ajax({
                        type: "POST",
                        url: "Home.aspx/ObtenerDatosUsuario",
                        data: '{NumeroEmpleado:"' + ObtenerNumeroEmpleado() + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            $("#NombreUsuario").append(result.d);
                        },
                        error: function (e) {
                            console.log(e.statusText);
                        }
                    });
                },
                error: function (e) {
                    console.log(e.statusText);
                }
            });

            $('input[type=radio][name=TipoMenu]').change(function () {
                if (this.value == 0) {
                    $("#SubirIconoPadre").show();
                    $("#SelectIconoHijo").hide();
                    $("#SelectMenuPadre").hide();                    
                }
                else if (this.value == 1) {
                    $("#SubirIconoPadre").hide();
                    $("#SelectIconoHijo").show();
                    $("#SelectMenuPadre").show();                    
                }
            });



        });

        function ObtenerNumeroEmpleado() {
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
            var NumeroEmpleado = $.OURL("NE");

            return NumeroEmpleado;
        }
    </script>
</body>
</html>
