/*Archivo que contiene las funciones JavaScript que interactuan del lado del cliente para la aplicación de MRC
Mario Gress
2018
*/

function VerificarUsuario()
{
    var NUsuario = $("#Usuario").val();
    var Password = $("#Clave").val();
    $("#mensajerror").empty();

    if ((NUsuario == "" || NUsuario == " ") && (Password == "" || Password == ""))
    {
        $("#mensajerror").append("Por favor ingres un usuario y contraseña valido.");
        $("#ErrorDatos").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Login.aspx/VerificaUsuario",
            data: '{NUsuario:"' + NUsuario + '", Password:"' + Password + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d > 0) {                    
                    location.href = "http://mrc.sytes.net/MRC/Home.aspx?NE=" + result.d;
                } else {
                    $("#mensajerror").append("<p>Verifique su nombre de usuario y/o contraseña.</p>");
                    $("#ErrorDatos").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}


/*Función para cerrar session
Mario Gress
2018
*/

function CerrarSesion()
{
    location.href = "http://mrc.sytes.net/MRC/Login.aspx";
}

/*Función para limpiar el modal de perfil
Mario Gress
2018
*/

function LimpiarModalPerfil()
{

    $("#Puesto").val('-1');
    $("#Menus").val('-1');
    $("#Rol").val('-1');
    $("#Puesto").chosen("destroy");
    $("#Menus").chosen("destroy");
    $("#Rol").chosen("destroy");
    $("#Puesto").empty();
    $("#Menus").empty();
    $("#Rol").empty();
           
    ObtenerPuestos();    

}

/*Función para obtener el listado de puestos 
Mario Gress
2018
*/

function ObtenerPuestos()
{
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerPuestos",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#Puesto").append(result.d);
            ObtenerMenus();
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}


/*Función para obtener los Menus Disponibles
Mario Gress
2018
*/

function ObtenerMenus()
{
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerMenus",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#Menus").append(result.d);
            ObtenerRolesDeCanela();
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para obtener el listado de roles de canelita.
Mario Gress
2018
*/

function ObtenerRolesDeCanela()
{
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerRolesDeCanela",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#Rol").append(result.d);
            jQuery(".standardSelect").chosen({
                disable_search_threshold: 10,
                no_results_text: "¡Ops!, no se encontro resultado para:",
                width: "100%"
            });
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para guardar el perfil de usuario
Mario Gress
2018
*/

function GuardarPuestoMenu()
{
    var Puesto = $("#Puesto").val();
    var Menu = $("#Menus").val();    
    var Rol = $("#Rol").val(); 
    var error = 0;
    var mensaje = "";

    if(Puesto == "" || Puesto == " " || Puesto <= 0)
    {
        mensaje = "Por favor seleccione un puesto";
        error++;
    }

    if(Menu == "" || Menu == " " || Menu <= 0)
    {
        mensaje += " Seleccione una aplicación para asignar al puesto seleccionado";
        error++;
    }

    if (Rol == "" || Rol == " " || Rol <= 0)
    {
        mensaje += " Seleccione un rol para asignar a la aplicación seleccionada";
        error++;
    }

    if (error > 0)
    {
        swal("Lo sentimos, verifique los datos seleccionados", mensaje, "error");
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/GuardarPuestoMenu",
            data: '{Puesto:"' + Puesto + '", Menu:"' + Menu + '", Rol:"' + Rol + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d)
                {
                    case 0:
                        swal("¡Lo sentimos!", "Ha ocurrido un error intente más tarde :(", "error");
                        break;
                    case 1:
                        swal("¡Éxito!", "Registro creado", "success");
                        break;
                    case 2:
                        swal("¡Éxito!", "El registro ya existe, no es necesario ingresarlo nuevamente", "success");
                        break;
                }
                
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

        
}



/*Función para limpiar el modal de Menus
Mario Gress
2018
*/

function LimpiarModalMenus()
{
    
    $("#SubirIconoPadre").hide();
    $("#SelectIconoHijo").hide();
    $("#SelectMenuPadre").hide();

    $("#NombreMenu").val("");
    $("#URLMenu").val("");

    $("#TipoPadre").prop("checked", false);
    $("#TipoHijo").prop("checked", false);

    $("#MenuPadre").chosen("destroy");
    $("#MenuPadre").empty();

    ObtenerMenusPadres();

}

/*Función para obtener el listado de Menus Padre
Mario Gress
2018
*/

function ObtenerMenusPadres()
{
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerMenusPadres",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#MenuPadre").append(result.d);            
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

function GuardarMenu()
{
    swal("¡Cooming soon!");
}


function GenerarUsuario()
{
    swal("¡Cooming soon!");
}


