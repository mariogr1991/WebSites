<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="ESC" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!-- Hoja de estilos del framework y estilos personalizados  -->
<link href="CSS/style.css" rel="stylesheet" type="text/css"/>
<link  rel="shortcut icon" href="IMG/ICONO_satisfaccion.ico"/>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/css/mdb.min.css" rel="stylesheet"/>

  
    <title>Portal de satisfacción de capacitación</title>
</head>
<body>
   <nav class="navbar navbar-light" style="background-color:;">
       <img id="Logo" src="img/Logo.png" class="rounded float-left" alt="Responsive image" style="width:7.50%"/>
   </nav>
   
<!-- Contenedor para el formulario de logueo.-->    
<div class="container" style="margin-top:15px;">
<form runat="server">
  <div class="form-group">      
    <h2 class="color-fuente text-center mb-4">Encuesta de Satisfacción</h2>
    <h2 class="color-fuente text-center mb-4">Entrenamiento y Capacitación</h2>
    <img src="IMG/login2.png" class="rounded mx-auto d-block" alt="Responsive image" style="width:15%;" />
    <h4 class="color-fuente text-center mb-4" style="margin-top:10px;">Ingresar</h4>
    <i class="fa fa-user-circle prefix white-text fa-2x"></i>
    <label for="numeroempleado" class="color-fuente">Número de Empleado</label>
    <input type="text" class="form-control" id="numeroempleado" runat="server" aria-describedby="user" placeholder="Ingrese su número de empleado"/>
    <small id="userHelp" class="form-text text-muted">El número de empleado le debe de haber sido propocionado al ingresar</small>
  </div>
  <div class="form-group">
    <i class="fa fa-unlock-alt prefix white-text fa-2x"></i>
    <label for="PINempleado" class="color-fuente">PIN</label>
    <input type="password" class="form-control" id="PINempleado" placeholder="Ingrese su PIN" />
    <small id="userHelpPIN" class="form-text text-muted">Consta de cuatro digitos, unicamente si cuenta con el</small>
  </div>  
    <button type="button" class="btn color-boton-principal" data-toggle="modal" onclick="Ingresar()">Ingresar
    </button>
</form>
<!-------------------------------------------------------->

<!-- Modal Que se mostrara por error al logearse-->
<div class="modal fade" id="ErrorDatos" tabindex="-1" role="dialog" aria-labelledby="ErrorDatos" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Por favor verifique sus datos</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="mensajerror"></p>
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn color-boton-principal" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>
<!------------------------------------------------------------>
<!-- Modal Para Ingresar el PIN por primera vez-->
<div class="modal fade" id="ModalPIN" tabindex="-1" role="dialog" aria-labelledby="ModalPIN" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Por favor ingrese su PIN</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="md-form">
                     <i class="fa fa-unlock-alt prefix grey-text"></i>
                     <input type="password" id="PINNuevo" class="form-control validate" value=""/>
                     <label for="PINNuevo">PIN</label>
               </div>
               <div class="md-form">
                     <i class="fa fa-unlock-alt prefix grey-text"></i>
                     <input type="password" id="PINNuevoConfirma" class="form-control validate" value=""/>
                     <input type="text" id="NumEmpleadoNuevoPIN" class="form-control validate" value="" readonly="true" hidden="hidden"/>
                     <label for="PINNuevoConfirma">Confirmar PIN</label>
               </div>               
            </div>
            <div class="modal-footer">                
                <button type="button" class="btn color-boton-principal" data-dismiss="modal" onclick="GuardarNuevoPIN()">Guardar</button>
            </div>
        </div>
    </div>
</div>
<!------------------------------------------------------------>

</div>                          
</body>
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.13.0/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/js/mdb.min.js"></script>
<script type="text/javascript" src="Js/Funciones.js"></script>
</html>

