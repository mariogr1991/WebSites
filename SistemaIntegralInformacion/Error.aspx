<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

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
            <form runat="server">
                <img src="IMG/candado.png" class="rounded mx-auto d-block" alt="Responsive image" style="width:25%;" />                
                <label class="Titulo">Usted está intentando acceder a un sitio al cual no esta autorizado, evite inconvenientes y abandone la página inmediatamente.</label>
                <label class="Titulo">Tenemos registro del equipo: </label>
                <label class="Titulo" id="Equipo" runat="server"></label>
                <label class="Titulo" id="Usuario" runat="server"></label>
            </form>
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
