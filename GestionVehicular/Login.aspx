<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!-- Hoja de estilos del framework y estilos personalizados  -->
<link href="CSS/style.css" rel="stylesheet" type="text/css"/>
<link  rel="shortcut icon" href="img/auto.png"/>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/css/mdb.min.css" rel="stylesheet"/>

  
    <title>Portal de Gestión Vehicular</title>
</head>
<body>
   <nav class="navbar navbar-light" style="background-color:;">
       <img id="Logo" src="img/Logo.png" class="rounded float-left" alt="Responsive image" style="width:7.50%"/>
   </nav>
   
<!-- Contenedor para el formulario de logueo.-->    
<div class="container col-sm-12 col-lg-6" style="margin-top:15px;">
<form runat="server">
  <div class="form-group">      
    <h2 class="color-fuente text-center mb-4">CONTROL DE VEHÍCULOS UTILITARIOS</h2>
    <img src="img/login2.png" class="rounded mx-auto d-block" alt="Responsive image" style="width:15%;" />
    <h4 class="color-fuente text-center mb-4" style="margin-top:10px;">Iniciar Sesión</h4>
    <i class="fa fa-user-circle prefix white-text fa-2x"></i>
    <label for="InputUsuario" class="color-fuente">Usuario</label>
    <input type="text" class="form-control" id="InputUsuario" runat="server" aria-describedby="user" placeholder="Ingrese su nombre de usuario"/>
    <small id="userHelp" class="form-text text-muted">Nunca comparta su nombre de usuario</small>
  </div>
  <div class="form-group">
    <i class="fa fa-unlock-alt prefix white-text fa-2x"></i>
    <label for="InputPassword" class="color-fuente">Contraseña</label>
    <input type="password" class="form-control" id="InputPassword" placeholder="Ingrese su Contraseña" />
  </div>  
    <button type="button" class="btn color-boton-principal" data-toggle="modal" onclick="Acceder()">Acceder
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
