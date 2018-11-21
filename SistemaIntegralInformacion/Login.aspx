<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link  rel="shortcut icon" href="IMG/Logo.png"/>
    <link href="https://fonts.googleapis.com/css?family=Asap|Raleway" rel="stylesheet"/>
    <link rel="stylesheet" media="screen" href="JS/particles.js-master/demo/css/style.css"/>
    <link href="CSS/Prueba.css" rel="stylesheet" type="text/css"/>
    <link href="CSS/bootstrap.css" rel="stylesheet" />
    <link href="CSS/mdb.css" rel="stylesheet" />
    <link href="CSS/Style.css" rel="stylesheet"/>    
    <script type="text/javascript" src="JS/Funciones.js"></script>
    <title>Sistema Integral de Información Madero Restaurante</title>
</head>
<body id="particles-js" style="z-index:-1; width:100%; height:100%;" >                
         <div class="container col-sm-12 col-lg-6 col-md-8" style="position:absolute; z-index:100; margin-left:25%; margin-right:25%; margin-top:10%;">
            <div class="form-group">
                <h2 class="Titulo text-center mb-4">Sistema Integral de Información</h2>
                <h2 class="Titulo text-center mb-4">Madero Restaurante</h2>
                <img src="IMG/Logo.png" class="rounded mx-auto d-block" alt="Responsive image" style="width:25%;" />                
                <i class="fa fa-user-circle prefix white-text fa-2x"></i>
                <label for="Usuario" class="CuerpoText">Usuario</label>
                <input type="text" class="form-control CuerpoText" id="Usuario" runat="server" aria-describedby="user" placeholder="Ingrese su nombre de usuario" />
                <small id="userHelp" class="form-text CuerpoTextSmall">Es el nombre de usuario que le fue proporcionado.</small>
            </div>
            <div class="form-group">
                <i class="fa fa-unlock-alt prefix white-text fa-2x"></i>
                <label for="Clave" class="CuerpoText">Contraseña</label>
                <input type="password" class="form-control" id="Clave" placeholder="Contraseña" />
                <small id="userHelpPIN" class="form-text CuerpoTextSmall">Nunca comparta su contraseña.</small>
            </div>
            <button type="button" class="btn color-boton-principal CuerpoTextMedium" data-toggle="modal" onclick="VerificarUsuario()">
                Ingresar
            </button>
        </div>
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

</body>
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.13.0/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/js/mdb.min.js"></script>
<script src="Js/TEST.js"></script>
<!-- scripts -->
<script src="JS/particles.js-master/particles.js"></script>
<script src="JS/particles.js-master/demo/js/app.js"></script>


</html>
