<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="es-mx">

<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta http-equiv="x-ua-compatible" content="ie=edge"/>
  <title>Parroquia de la Resurrección</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet"/>
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.min.css" rel="stylesheet"/>
  <!-- Your custom styles (optional) -->
  <link href="css/style.css" rel="stylesheet"/>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark blue">  
  <a class="navbar-brand" href="#">Parroquia de la Resureección</a>  
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav"
    aria-controls="basicExampleNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>  
  <div class="collapse navbar-collapse" id="basicExampleNav">    
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Principal
          <span class="sr-only">(current)</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Sacramentos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Catequesis</a>
      </li>     
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
          aria-expanded="false">Pastorales</a>
        <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="#">Pastoral Proferica</a>
          <a class="dropdown-item" href="#">Pastoral Familiar</a>
          <a class="dropdown-item" href="#">Pastoral Indigena</a>          
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Sectores</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Vocaciones</a>
      </li>
    </ul>    

    <form class="form-inline">
      <div class="md-form my-0">
        <input class="form-control mr-sm-2" type="text" placeholder="Buscar" aria-label="Search"/>
      </div>
    </form>
  </div>  
</nav>








<!-- Footer -->
<footer class="page-footer font-small blue pt-4">    
    <div class="container">      
      <div class="row">
          <h3>Contactanos</h3>
      </div>
      <div class="row">                    
        <div class="col-md-3 mb-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-default">Nombre</span>
                </div>
                <input type="text" id="Nombre" class="form-control" aria-label="Nombre" aria-describedby="inputGroup-sizing-default"/>
            </div>          
        </div>
        <div class="col-md-3 mb-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-default2">Correo</span>
                </div>
                <input type="text" id="Correo" class="form-control" aria-label="Correo" aria-describedby="inputGroup-sizing-default2"/>
            </div> 
        </div>          
        <div class="col-md-3 mb-4">
            <div class="input-group mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-default3">Mensaje</span>
                </div>
                <textarea class="form-control" id="Mensaje" rows="7"></textarea>                
            </div> 
        </div>
        <div class="col-md-3 mb-4">
            <div class="input-group-append">
              <button class="btn btn-sm btn-outline-white" type="button">Enviar</button>
            </div>
        </div>  
      </div>      
    </div>
    <div class="row">        
       <div class="col-md-12 py-5">
          <div class="mb-5 flex-center">            
            <a class="fb-ic" href="https://www.facebook.com/parroquiadelaresurreccionpachuca/" target="_blank">
              <i class="fa fa-facebook fa-lg white-text mr-md-5 mr-3 fa-2x"> </i>
            </a>            
            <a class="ins-ic" href="" target="_blank">
              <i class="fa fa-instagram fa-lg white-text mr-md-5 mr-3 fa-2x"> </i>
            </a>
            <a class="ins-ic" href="">
              <i class="fa fa-whatsapp fa-lg white-text mr-md-5 mr-3 fa-2x"> </i>
            </a>             
            <a class="pin-ic" href="" target="_blank">
              <i class="fa fa-youtube-play fa-lg white-text fa-2x"> </i>
            </a>             
          </div>
        </div>
    </div>        

    <!-- Copyright -->
    <div class="footer-copyright text-center py-3">© 2026 Copyright:
      <a href="https://www.instagram.com/mgressr">Mario Gress</a>
    </div>
    <!-- Copyright -->

  </footer>
  <!-- Footer -->


  <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
</body>
</html>
