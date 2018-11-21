/* MRC
Mario Gress 

2018

Documento JavaScript con funciones utilizadas para la aplicación de Satisfacción de Entrenamiento y Capacitación


*/


/*
Función para validar el ingreso al portal
Mario Gress
2018
*/

function Ingresar()
{
    var numempleado = $("#numeroempleado").val();
    var PIN = $("#PINempleado").val();
    $("#mensajerror").empty();

    if (numempleado == "" || numempleado == " ") {
        $("#mensajerror").append("Por favor ingrese un número de empleado");
        $("#ErrorDatos").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Login.aspx/VerificaUsuario",
            data: '{numempleado:"' + numempleado + '", PIN:"' + PIN + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                switch (result.d) {
                    case -1:
                        $("#mensajerror").append("Es requerido su clave PIN");
                        $("#ErrorDatos").modal('show');
                        break;
                    case 0:
                        $("#mensajerror").append("Lo sentimos, ha ocurrido un error intentelo más tarde.");
                        $("#ErrorDatos").modal('show');
                        break;
                    case 1:
                        location.href = "http://mrc.sytes.net/SatisfaccionEntrenamiento/Home.aspx?NE=" + numempleado + "";
                        break;
                    case 2:
                        location.href = "http://mrc.sytes.net/SatisfaccionEntrenamiento/Home.aspx?NE=" + numempleado + "";
                        break;
                    case 3:
                        $("#mensajerror").append("Verifique su número de empleado y su PIN por favor.");
                        $("#ErrorDatos").modal('show');
                        break;
                    case 4:
                        $("#NumEmpleadoNuevoPIN").val(numempleado);
                        $("#ModalPIN").modal('show');
                        break;
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }    
}

/*Función para cerrar la session del usuario logueado.
Mario Gress 
2018
*/

function CerrarSesion() {
    location.href = "http://mrc.sytes.net/SatisfaccionEntrenamiento/Login.aspx";
}


/*Función para guardar el nuevo PIN
Mario Gress
2018
*/

function GuardarNuevoPIN()
{
    var NumEmpleado = $("#NumEmpleadoNuevoPIN").val();
    var PIN = $("#PINNuevo").val();
    var PINC = $("#PINNuevoConfirma").val();

    if (PIN != PINC) {
        alert("El PIN ingresado no coincide.");
    } else {
        $.ajax({
            type: "POST",
            url: "Login.aspx/ActualizarPIN",
            data: '{NumEmpleado:"' + NumEmpleado + '", PIN:"' + PIN + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if(result.d == 1){
                    alert("Guardado con éxito");
                } else {
                    alert("Lo sentimos ocurrio un error intente más tarde.");
                }                
            },
            error: function (e)
            {
                console.log(e.statusText);
            }
        });
    }
}

/*Función que detecta el click en los iconos de estrella y determinar que valor se le está dando a cada pregunta cómo respuesta.
Mario Gress
2018*/

function ClickEstrella(id, numero, idvalor, numerorespuesta) {    
    switch (numero) {
        case 1:
            $("#" + id + "R" + numerorespuesta + "S1").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S1").addClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S2").removeClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S3").removeClass('fa-star');           
            $("#" + id + "R" + numerorespuesta + "S2").addClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S3").addClass('fa-star-o');
            $("#" + idvalor).val(1);            
            break;
        case 2:
            $("#" + id + "R" + numerorespuesta + "S1").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S1").addClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S2").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S2").addClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S3").removeClass('fa-star');                        
            $("#" + id + "R" + numerorespuesta + "S3").addClass('fa-star-o');
            $("#" + idvalor).val(2);            
            break;
        case 3:
            $("#" + id + "R" + numerorespuesta + "S1").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S1").addClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S2").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S2").addClass('fa-star');
            $("#" + id + "R" + numerorespuesta + "S3").removeClass('fa-star-o');
            $("#" + id + "R" + numerorespuesta + "S3").addClass('fa-star');            
            $("#" + idvalor).val(3);            
            break;
     
    }
}

/*Función para limpiar estrellas en cada encuesta
Mario Gress
2018
*/

function LimpiarEstrellas()
{
    $(".limpiar").removeClass('fa-star');
    $(".limpiar").addClass('fa-star-o');
    $("#ValorCapacitanto-EntrenadorR1").val('0');
    $("#ValorCapacitanto-EntrenadorR2").val('0');
    $("#ValorCapacitanto-EntrenadorR3").val('0');
    $("#ValorCapacitanto-EntrenadorR4").val('0');
    $("#ValorCapacitanto-EntrenadorR5").val('0');
}

/*Función para obtener la información del trabajador
Mario Gress
2018
*/

function ObtenerInfoUsuarioCapacitando()
{
    var numempleado = ObtenerNumeroEmpleado();
    LimpiarEstrellas();
    $("#CapacitandoNombreEntrenador").empty();
    $("#CapacitandoNombreCapacitador").empty();
    $("#EntrenadorNombreCapacitando").empty();
    $("#CapacitadorNombreCapacitando").empty();
    $("#CapacitadorNombreEntrenador").empty();
    $("#JefeDirectoNombreCapacitador").empty();
    $("#CapacitandoPuestoEntrenador").val('');
    $("#CapacitandoPuestoCapacitador").val('');
    $("#EntreandorPuestoCapacitando").val('');
    $("#CapacitadorPuestoCapacitando").val('');
    $("#CapacitadorPuestoEntrenador").val('');
    $("#JefeDirectoPuestoCapacitador").val('');
    $("#CapacitadorFechaIngreso").val('');
    $("#JefeDirectoFechaIngreso").val('');
    $("#EntrenadorFechaIngreso").val('');
    $("#CapacitadorFechaIngresoEntrenador").val('');
    

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerInformacioUsuario",
        data: '{numempleado:"' + numempleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var InfoEmpleado = JSON.parse(result.d);
            /*Información Capacitando-Entrenador*/            
            $("#CapacitandoNombre").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#CapacitandoPuesto").val(InfoEmpleado["PuestoDsc"]);            
            $("#CapacitandoFechaIngreso").val(moment(InfoEmpleado["EmpFechaIngreso"]).format('DD-MM-YYYY'));
            $("#CapacitandoFechaAplicacion").val(moment().format('DD-MM-YYYY'));
            /*------------------------------------*/
            /*Información Capactiando-Capacitador*/
            $("#CapacitandoNombreC").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#CapacitandoPuestoC").val(InfoEmpleado["PuestoDsc"]);
            $("#CapacitandoFechaIngresoC").val(moment(InfoEmpleado["EmpFechaIngreso"]).format('DD-MM-YYYY'));
            $("#CapacitandoFechaAplicacionC").val(moment().format('DD-MM-YYYY'));
            /*-----------------------------------*/
            /*Información Entrenador-Capacitando*/
            $("#EntrenadorNombreEntrenador").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#EntrenadorPuestoEntrenador").val(InfoEmpleado["PuestoDsc"]);            
            $("#EntrenadorFechaAplicacion").val(moment().format('DD-MM-YYYY'));
            /*----------------------------------*/
            /*Información Capacitador-Capacitando*/
            $("#CapacitadorNombreCapacitador").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#CapacitadorPuestoCapacitador").val(InfoEmpleado["PuestoDsc"]);            
            $("#CapacitadorFechaAplicacion").val(moment().format('DD-MM-YYYY'));
            /*-----------------------------------*/
            /*Información Capacitador-Entrenador*/
            $("#CapacitadorNombreCapacitadorE").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#CapacitadorPuestoCapacitadorE").val(InfoEmpleado["PuestoDsc"]);            
            $("#CapacitadorFechaAplicacionEntrenador").val(moment().format('DD-MM-YYYY'));
            /*---------------------------------*/
            /*Información de Capacitador-JefeDirecto*/
            $("#JefeDirectoNombreJefeDirecto").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);            
            $("#JefeDirectoPuestoJefeDirecto").val(InfoEmpleado["PuestoDsc"]);
            $("#JefeDirectoFechaAplicacionEntrenador").val(moment().format('DD-MM-YYYY'));
            /*-------------------------------------*/
            ObtenerEntrenadores();
            ObtenerCapacitadores();
            ObtenerCapacitandos();
            ObtenerCapacitandosCapacitador();
            ObtenerEntrenadorCapacitador();
            ObtenerCapacitadoresJefeDirecto();
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}


/*Función para obtener los capacitadores para el jefe directo
Mario Gress
2018
*/

function ObtenerCapacitadoresJefeDirecto()
{
    var NumEmpleado = ObtenerNumeroEmpleado();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerCapacitadoresJefeDirecto",
        data: '{NumEmpleado: "' + NumEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#JefeDirectoNombreCapacitador").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para obtener los entrenadores
Mario Gress
2018
*/

function ObtenerEntrenadores() {

    var NumeroEmpleado = ObtenerNumeroEmpleado();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerEntrenadores",
        data: '{NumEmpleado: "' + NumeroEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#CapacitandoNombreEntrenador").append(result.d);            
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para obtener las unidades asignadas del capacitador
Mario Gress
2018
*/

function ObtenerUnidadAsignadaCapacitador()
{
    var NumEmpleado = ObtenerNumeroEmpleado();
    $("#SelectUnidadCapacitador").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadesAsignadas",
        data: '{NumEmpleado: "' + NumEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#SelectUnidadCapacitador").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}



/*Función para obtener los entrandores para el capacitador
Mario Gress
2018
*/

function ObtenerEntrenadorCapacitador()
{
    var UnidadSeleccionada = $("#SelectUnidadCapacitador").val();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerEntrenadoresCapacitador",
        data: '{UnidadSeleccionada: "' + UnidadSeleccionada + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#CapacitadorNombreEntrenador").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}


/*Función para obtener a los capacitadores disponibles
Mario Gress 
2018
*/

function ObtenerCapacitadores()
{
    var NumEmpleado = ObtenerNumeroEmpleado();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerCapacitadores",
        data: '{NumEmpleado: "' + NumEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#CapacitandoNombreCapacitador").append(result.d);            
        },
        error: function (e) {
            console.log();
        }
    });
}

/*Función para obtener los capacitando disponibles
Mario Gress
2018
*/

function ObtenerCapacitandos()
{
    var NumEmpleado = ObtenerNumeroEmpleado();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerCapacitandos",
        data: '{NumEmpleado: "' + NumEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#EntrenadorNombreCapacitando").append(result.d);            
        },
        error: function (e) {            
            console.log(e);
        }
    });
}

/*Función para obtener los capacitandos para los capacitadores
Mario Gress
2018
*/
function ObtenerCapacitandosCapacitador()
{
    var UnidadSeleccionada = $("#SelectUnidadCapacitador").val();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerCapacitandosCapacitador",
        data: '{UnidadSeleccionada: "' + UnidadSeleccionada + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#CapacitadorNombreCapacitando").append(result.d);
        },
        error: function (e) {
            console.log(e);
        }
    });
}

/*Función para obtener el puesto del entrador
Mario Gress
2018
*/

function ObtenerPuesto() {

    var NumEmpleado = $("#CapacitandoNombreEntrenador").val();
    
    if (NumEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NumEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#CapacitandoPuestoEntrenador").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#CapacitandoPuestoEntrenador").val('');        
    }
    
}

/*Función para obtener el puesto del capacitador
Mario Gress
2018
*/

function ObtenerPuestoCapacitador() {

    
    var NoEmpleado = $("#CapacitandoNombreCapacitador").val();

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#CapacitandoPuestoCapacitador").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#CapacitandoPuestoCapacitador").val('');
    }
}

/*Función para obtener el puesto del capacitando
Mario Gress
2018
*/

function ObtenerPuestoCapacitando() {

    var NoEmpleado = $("#EntrenadorNombreCapacitando").val();

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#EntreandorPuestoCapacitando").val(result.d);
                $("#CapacitadorPuestoCapacitando").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#EntreandorPuestoCapacitando").val('');
    }

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerFechaIngreso",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {                
                $("#EntrenadorFechaIngreso").val(moment(result.d).format("DD-MM-YYYY"));
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#EntrenadorFechaIngreso").val('');
    }
}

/*Función para obtener el puesto del capacitador capacitando
Mario Gress
2018
*/

function ObtenerPuestoCapacitadorCapacitando() {

    var NoEmpleado = $("#CapacitadorNombreCapacitando").val();

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {               
                $("#CapacitadorPuestoCapacitando").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });

        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerFechaIngreso",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#CapacitadorFechaIngreso").val(moment(result.d).format('DD-MM-YYYY'));
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#CapacitadorPuestoCapacitando").val('');
        $("#CapacitadorFechaIngreso").val('');
    }
}

/*Función para obtener el puesto del capacitador entrenador
Mario Gress
2018
*/

function ObtenerPuestoCapacitadorEntrenador() {

    var NoEmpleado = $("#CapacitadorNombreEntrenador").val();

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#CapacitadorPuestoEntrenador").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#CapacitadorPuestoEntrenador").val('');
    }

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerFechaIngreso",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#CapacitadorFechaIngresoEntrenador").val(moment(result.d).format("DD-MM-YYYY"));
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    } else {
        $("#CapacitadorFechaIngresoEntrenador").val('');
    }
}

/*Función para obtener el puesto del capacitador entrenador
Mario Gress
2018
*/

function ObtenerPuestoCapacitadorJefeDirecto() {

    var NoEmpleado = $("#JefeDirectoNombreCapacitador").val();

    if (NoEmpleado > 0) {
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerPuesto",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#JefeDirectoPuestoCapacitador").val(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerFechaIngreso",
            data: '{NoEmpleado: ' + NoEmpleado + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#JefeDirectoFechaIngreso").val(moment(result.d).format('DD-MM-YYYY'));
            },
            error: function (e) {
                console.log(e.statusText);
            }
        })
    } else {
        $("#JefeDirectoPuestoCapacitador").val('');
        $("#JefeDirectoFechaIngreso").val('');
    }
}

/*Función para limpiar el modal de alta de unidad 
Mario Gress
2018
*/

function LimpiarModalAltaUnidad()
{
    $("#ZonaUnidadNegocio").empty();
    $("#NombreUnidadNegocio").val('');
    $("#DireccionUnidadNegocio").val('');
    ObtenerZonas();
}

/*Función para obtener las zonas disponibles.
Mario Gress
2018
*/

function ObtenerZonas()
{    

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerZonas",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#ZonaUnidadNegocio").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}




/*Función para registrar una nueva Encuesta del Tipo Capacitando Entreandor
Mario Gress
2018
*/

function EnviarCapacitandoEntrenador()
{
    $("#MensajeErrorEncuestaCapacitando").empty();
    $("#MensajeEncuestaCapacitandoExito").empty();
    var R1 = $("#ValorCapacitanto-EntrenadorR1").val();
    var R2 = $("#ValorCapacitanto-EntrenadorR2").val();
    var R3 = $("#ValorCapacitanto-EntrenadorR3").val();
    var R4 = $("#ValorCapacitanto-EntrenadorR4").val();
    var R5 = $("#ValorCapacitanto-EntrenadorR5").val();
    var error = 0;
    var NoEmpleadoEntrenador = $("#CapacitandoNombreEntrenador").val();
    var numempleado = ObtenerNumeroEmpleado();

    if(R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0){
        $("#MensajeErrorEncuestaCapacitando").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;        
    }
    if (NoEmpleadoEntrenador <= 0) {
        $("#MensajeErrorEncuestaCapacitando").append('<p>Por favor seleccione un entrenador a evaluar.</p>');
        error++;
    }
    if(error > 0){
        $("#ErrorEncuestaCapacitando").modal('show');
    }
    else {

        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoEntrenador + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ', tipo: ' + 1 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaCapacitandoExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaCapacitandoExito").modal('show');
                $("#ModalCapacitandoEvaluarEntrenador").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });         
    }

}

/*Función para registrar una nueva Encuesta del Tipo Capacitando Capacitador
Mario Gress
2018
*/

function EnviarCapacitandoCapacitador()
{
    $("#MensajeErrorEncuestaCapacitando").empty();
    $("#MensajeEncuestaCapacitandoExito").empty();
    var R1 = $("#ValorCapacitanto-CapacitadorR1").val();
    var R2 = $("#ValorCapacitanto-CapacitadorR2").val();
    var R3 = $("#ValorCapacitanto-CapacitadorR3").val();
    var R4 = $("#ValorCapacitanto-CapacitadorR4").val();
    var R5 = $("#ValorCapacitanto-CapacitadorR5").val();
    var error = 0;
    var NoEmpleadoCapacitador = $("#CapacitandoNombreCapacitador").val();
    var numempleado = ObtenerNumeroEmpleado();

    if (R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0) {
        $("#MensajeErrorEncuestaCapacitando").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;
    }
    if (NoEmpleadoCapacitador <= 0) {
        $("#MensajeErrorEncuestaCapacitando").append('<p>Por favor seleccione un capacitador a evaluar.</p>');
        error++;
    }
    if (error > 0) {
        $("#ErrorEncuestaCapacitando").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoCapacitador + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ',tipo: ' + 2 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaCapacitandoExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaCapacitandoExito").modal('show');
                $("#ModalCapacitandoEvaluarCapacitador").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}

/*Función para registrar una nueva Encuesta del Tipo Entrenador Capacitando
Mario Gress
2018
*/

function EnviarEntrenadorCapacitando() {
    $("#MensajeErrorEncuestaCapacitando").empty();
    $("#MensajeEncuestaCapacitandoExito").empty();
    var R1 = $("#ValorEntrenador-CapacitandoR1").val();
    var R2 = $("#ValorEntrenador-CapacitandoR2").val();
    var R3 = $("#ValorEntrenador-CapacitandoR3").val();
    var R4 = $("#ValorEntrenador-CapacitandoR4").val();
    var R5 = $("#ValorEntrenador-CapacitandoR5").val();
    var error = 0;
    var NoEmpleadoCapacitando = $("#EntrenadorNombreCapacitando").val();
    var numempleado = ObtenerNumeroEmpleado();

    if (R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0) {
        $("#MensajeErrorEncuestaEntrenador").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;
    }
    if (NoEmpleadoCapacitando <= 0) {
        $("#MensajeErrorEncuestaEntrenador").append('<p>Por favor seleccione un capacitando a evaluar.</p>');
        error++;
    }
    if (error > 0) {
        $("#ErrorEncuestaEntrenador").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoCapacitando + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ',tipo: ' + 3 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaEntrenadorExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaEntrenadorExito").modal('show');
                $("#ModalEntrenadorEvaluarCapacitando").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}

/*Función para registrar una nueva Encuesta del Tipo Capacitador - Capacitando
Mario Gress
2018
*/

function EnviarCapacitadorCapacitando() {

    $("#MensajeErrorEncuestaCapacitadorEvalua").empty();
    $("#MensajeEncuestaCapacitadoEvaluarExito").empty();
    var R1 = $("#ValorCapacitador-CapacitandoR1").val();
    var R2 = $("#ValorCapacitador-CapacitandoR2").val();
    var R3 = $("#ValorCapacitador-CapacitandoR3").val();
    var R4 = $("#ValorCapacitador-CapacitandoR4").val();
    var R5 = $("#ValorCapacitador-CapacitandoR5").val();
    var error = 0;
    var NoEmpleadoCapacitando = $("#CapacitadorNombreCapacitando").val();
    var numempleado = ObtenerNumeroEmpleado();

    if (R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0) {
        $("#MensajeErrorEncuestaCapacitadorEvalua").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;
    }
    if (NoEmpleadoCapacitando <= 0) {
        $("#MensajeErrorEncuestaCapacitadorEvalua").append('<p>Por favor seleccione un capacitando a evaluar.</p>');
        error++;
    }
    if (error > 0) {
        $("#ErrorEncuestaCapacitadorEvalua").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoCapacitando + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ',tipo: ' + 4 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaCapacitadoEvaluarExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaCapacitadorEvaluaExito").modal('show');
                $("#ModalCapacitadorEvaluarCapacitando").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}

/*Función para registrar una nueva Encuesta del Tipo Capacitador - Entrenador
Mario Gress
2018
*/

function EnviarCapacitadorEntrenador() {

    $("#MensajeErrorEncuestaCapacitadorEvalua").empty();
    $("#MensajeEncuestaCapacitadoEvaluarExito").empty();
    var R1 = $("#ValorCapacitador-EntrenadorR1").val();
    var R2 = $("#ValorCapacitador-EntrenadorR2").val();
    var R3 = $("#ValorCapacitador-EntrenadorR3").val();
    var R4 = $("#ValorCapacitador-EntrenadorR4").val();
    var R5 = $("#ValorCapacitador-EntrenadorR5").val();
    var error = 0;
    var NoEmpleadoEntrenador = $("#CapacitadorNombreEntrenador").val();
    var numempleado = ObtenerNumeroEmpleado();

    if (R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0) {
        $("#MensajeErrorEncuestaCapacitadorEvalua").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;
    }
    if (NoEmpleadoEntrenador <= 0) {
        $("#MensajeErrorEncuestaCapacitadorEvalua").append('<p>Por favor seleccione un entrenador a evaluar.</p>');
        error++;
    }
    if (error > 0) {
        $("#ErrorEncuestaCapacitadorEvalua").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoEntrenador + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ',tipo: ' + 5 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaCapacitadoEvaluarExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaCapacitadorEvaluaExito").modal('show');
                $("#ModalCapacitadorEvaluarEntrenador").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}


/*Función para registrar una nueva Encuesta del Tipo Jefe Directo - Capacitador
Mario Gress
2018
*/

function EnviarJefeDirectoCapacitador() {

    $("#MensajeErrorEncuestaJefeDirecto").empty();
    $("#MensajeEncuestaJefeDirectoExito").empty();
    var R1 = $("#ValorJefeDirecto-CapacitadorR1").val();
    var R2 = $("#ValorJefeDirecto-CapacitadorR2").val();
    var R3 = $("#ValorJefeDirecto-CapacitadorR3").val();
    var R4 = $("#ValorJefeDirecto-CapacitadorR4").val();
    var R5 = $("#ValorJefeDirecto-CapacitadorR5").val();
    var error = 0;
    var NoEmpleadoCapacitador = $("#JefeDirectoNombreCapacitador").val();
    var numempleado = ObtenerNumeroEmpleado();

    if (R1 <= 0 || R2 <= 0 || R3 <= 0 || R4 <= 0 || R5 <= 0) {
        $("#MensajeErrorEncuestaJefeDirecto").append('<p>Por favor verifique sus respuesta, ninguna pregunta se puede quedar sin respuesta.</p>');
        error++;
    }
    if (NoEmpleadoCapacitador <= 0) {
        $("#MensajeErrorEncuestaJefeDirecto").append('<p>Por favor seleccione un capacitador a evaluar.</p>');
        error++;
    }
    if (error > 0) {
        $("#ErrorEncuestaJefeDirecto").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/InsertarEncuesta",
            data: '{numempleado: ' + numempleado + ', IDEvaluando: ' + NoEmpleadoCapacitador + ',R1: ' + R1 + ',R2: ' + R2 + ',R3: ' + R3 + ',R4: ' + R4 + ',R5: ' + R5 + ',tipo: ' + 6 + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#MensajeEncuestaJefeDirectoExito").append('<p>Encuesta realizada con éxito muchas gracias.</p>');
                $("#EncuestaJefeDirectoExito").modal('show');
                $("#ModalJefeDirectoEvaluarCapacitador").modal('hide');
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}

/*Función para obtener los datos iniciales del modal de agregar nuevo usuario.
Mario Gress
2018
*/

function ObtenerDatosAltaUsuario()
{
    $("#PuestoEmpleado").empty();
    $("#RolEmpleado").empty();
    $("#UnidadNegocioEmpleado").empty();
    $("#JefeDirecto").empty();
    $("#NombreEmpleado").val('');
    $("#NumeroEmpleado").val('');
    $("#FechaIngresoEmpleado").val('');

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerPuestos",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#JefeDirecto").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerRoles",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#RolEmpleado").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para crear la tabla de Adminsitración de Usuarios
Mario Gress
2018
*/

function CrearTablaAdminUsuarios() {

    var numempleado = $("#AdminNumEmpleado").val();
    $("#TablaUsuarios").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/CrearTablaAdminUsuarios",
        data: '{numempleado:"' + numempleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#TablaUsuarios").append(result.d);            
        },
        error: function (e) {
            console.log();
        }
    });
}

/*Función para crear la tabla de unidades de negocio
Mario Gress
2018
*/

function CrearTablaUnidadesNegocio()
{
    $("#TablaUnidadesNegocio").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/CrearTablaUnidadesNegocio",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#TablaUnidadesNegocio").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}



function ObtenerInfoEmpleado()
{
    var NoEmpleado = $("#NumeroEmpleado").val();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerInfoEmpleado",
        data: '{NoEmpleado:"' + NoEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {            
            var InfoEmpleado = JSON.parse(result.d);
            $("#PuestoEmpleado").val(InfoEmpleado["PuestoDsc"]);
            $("#NombreEmpleado").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);
            $("#FechaIngresoEmpleado").val(InfoEmpleado["EmpFechaAntiguedad"]);            
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });

}


/*Función para agregar un nuevo usuario
Mario Gress
2018
*/

function AgregarUsuario()
{
    var NombreEmpleado = $("#NombreEmpleado").val();    
    var RolEmpleado = $("#RolEmpleado").val();
    var NumeroEmpleado = $("#NumeroEmpleado").val();
    var DiasCapacitacion = $("#DiasCapacitacion").val();
    var error = 0;
    
    $("#MensajeErrorAdministrativo").empty();
    $("#MensajeAdministrativoExito").empty();

    if (NombreEmpleado == "" || NombreEmpleado == "  ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor verifique el número de empleado ingresado</p>");
        error++;
    }

    if (NumeroEmpleado == "" || NumeroEmpleado == " ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor ingrese un número de empleado valido.</p>");
        error++;
    }
    if (RolEmpleado <= '0') {
        $("#MensajeErrorAdministrativo").append("<p>Por favor seleccione un rol.</p>");
        error++;
    }

    if (DiasCapacitacion == "" || DiasCapacitacion <= 0 || DiasCapacitacion == " ")
    {
        $("#MensajeErrorAdministrativo").append("<p>Por favor ingrese el número de días de capacitación.</p>");
        error++;
    }

    if(error > 0){
        $("#ErrorAdministrativo").modal('show');
    } else {
        AbrirDivCargando();
        $.ajax({
            type: "POST",
            url: "Home.aspx/AgregarUsuario",
            data: '{RolEmpleado: "' + RolEmpleado + '", NumeroEmpleado: "' + NumeroEmpleado + '", DiasCapacitacion: "' + DiasCapacitacion + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if(result.d == 1){
                    $("#MensajeAdministrativoExito").append("<p>Usuario registrado con éxito.</p>");
                    CerrarDivCargando();
                    $("#AdministrativoExito").modal('show');
                    $("#ModalAgregarUsuario").modal('hide');
                    CrearTablaAdminUsuarios();                    
                }
                else if (result.d == 2) {
                    $("#MensajeErrorAdministrativo").append("<p>El número de empleado que ingreso ya se encuentra asociado a un empleado, por favor verifiquelo.</p>");
                    CerrarDivCargando();
                    $("#ErrorAdministrativo").modal('show');
                }
                else if (result.d == 3)
                {
                    $("#MensajeErrorAdministrativo").append("<p>El Usuario se encuentra dado de baja en Human Site</p>");
                    CerrarDivCargando();
                    $("#ErrorAdministrativo").modal('show');
                }
                else {
                    $("#MensajeErrorAdministrativo").append("<p>Lo sentimos ocurrio un error intentelo más tarde.</p>");
                    CerrarDivCargando();
                    $("#ErrorAdministrativo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }
   

}

/*Función para desactivar un Usuario
Mario Gress
2018
*/

function DesactivarActivarUsuario(IDU,instruccion)
{
    $("#MensajeAdministrativoExito").empty();
    $("#MensajeErrorAdministrativo").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/DesactivarActivarUsuario",
        data: '{IDU:"' + IDU + '", instruccion:"' + instruccion + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.d == 1) {
                if(instruccion == 1){
                    $("#MensajeAdministrativoExito").append("<p>Usuario desactivado correctamente.</p>");
                    $("#AdministrativoExito").modal('show');
                    CrearTablaAdminUsuarios();
                }else{
                    $("#MensajeAdministrativoExito").append("<p>Usuario activado correctamente.</p>");
                    $("#AdministrativoExito").modal('show');
                    CrearTablaAdminUsuarios();
                }               
            } else {
                $("#MensajeErrorAdministrativo").append("<p>Lo sentimos ocurrio un error intentelo más tarde.</p>");
                $("#ErrorAdministrativo").modal('show');
            }
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}


/*Función para abrir el modal de modificar usuario
Mario Gress
2018
*/

function AbrirModalModificarUsuario(IDU,IDR,NumEmpleado,DiasCapacitacion) {
    
    $("#PuestoEmpleadoM").empty();
    $("#RolEmpleadoM").empty();    
    $("#UnidadesAsignadas").empty();
    $("#Especialidad").hide();
    $("input:checkbox").prop('checked', false);

    if(IDR == 3)
    {
        $("#Especialidad").show();
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerUnidadesAsignadasSelect",
            data: '{NumeroEmpleado:"' + NumEmpleado + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#UnidadesAsignadas").append(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerEspecialidadesCapacitador",
            data: '{NumEmpleado:"' + NumEmpleado + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d[0] == true)
                {
                    $("#Cocina").prop('checked', true)                    
                } else {
                    $("#Cocina").prop('checked', false);                    
                }
                if(result.d[1] == true)
                {
                    $("#Piso").prop('checked', true)                    
                } else {
                    $("#Piso").prop('checked', false);                    
                }
                if (result.d[2] == true) {
                    $("#Panaderia").prop('checked', true)                    
                } else {
                    $("#Panaderia").prop('checked', false);                    
                }
                if (result.d[3] == true) {
                    $("#Almacen").prop('checked', true)                    
                } else {
                    $("#Almacen").prop('checked', false);                    
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerRoles",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#RolEmpleadoM").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });


    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerInfoUsuario",
        data: '{NoEmpleado:"' + NumEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var InfoEmpleado = JSON.parse(result.d);
            $("#NombreEmpleadoM").val(InfoEmpleado["Emp_patern"] + " " + InfoEmpleado["Emp_matern"] + " " + InfoEmpleado["Emp_nombres"]);
            $("#NumeroEmpleadoM").val(InfoEmpleado["Emp_nie"]);
            $("#FechaIngresoEmpleadoM").val(moment(InfoEmpleado["EmpFechaIngreso"]).format('DD-MM-YYYY'));
            $("#PuestoEmpleadoM").val(InfoEmpleado["PuestoDsc"]);
            $("#RolEmpleadoM").val(IDR);
            $("#DiasCapacitacionModificar").val(DiasCapacitacion);
        },
        error: function (e){
            console.log(e.statusText);
    }
    });

    $("#ModalModificarUsuario").modal('show');
}

/*Función para verificar cuando cambia el rol en el select de */

function VerificarRol()
{
    var IDR = $("#RolEmpleadoM").val();
    var NoEmpleado = ObtenerNumeroEmpleado();

    if (IDR == 3) {        
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerUnidadesAsignadasSelect",
            data: '{NumeroEmpleado:"' + NoEmpleado + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#UnidadesAsignadas").append(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
        $("#Especialidad").show();
    } else {
        $("#Especialidad").hide();
    }
}

/*Función para guardar cambios en un usuario
Mario Gress
2018
*/

function GuardarModificacionesuUsuario() {

    var NumeroEmpleadoM = $('#NumeroEmpleadoM').val();
    var EspCocina = $('#Cocina').prop('checked');
    var EspPiso = $('#Piso').prop('checked');
    var EspPanaderia = $('#Panaderia').prop('checked');
    var EspAlmacen = $('#Almacen').prop('checked');
    var UnidadesAsignadas = $("#UnidadesAsignadas").val();
    var RolEmpleadoM = $("#RolEmpleadoM").val();
    var DiasCapacitacion = $("#DiasCapacitacionModificar").val();
    var error = 0;

    $("#MensajeErrorAdministrativo").empty();
    $("#MensajeAdministrativoExito").empty();

    if (NumeroEmpleadoM == "" || NumeroEmpleadoM == " ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor verifique el usuario ingesado.</p>");
        error++;
    }
    if (RolEmpleadoM <= '0') {
        $("#MensajeErrorAdministrativo").append("<p>Por favor seleccione un rol.</p>");
        error++;
    }
    if(DiasCapacitacion == "" || DiasCapacitacion <= 0 || DiasCapacitacion == " ")
    {
        $("#MensajeErrorAdministrativo").append("<p>Ingrese el número de días de capacitación.</p>");
        error++;
    }

    if (error > 0) {
        $("#ErrorAdministrativo").modal('show');
    } else {        
        $.ajax({
            type: "POST",
            url: "Home.aspx/ModificarUsuario",
            data: '{RolEmpleado: "' + RolEmpleadoM + '", NumeroEmpleado: "' + NumeroEmpleadoM + '", UnidadesAsignadas: "' + UnidadesAsignadas + '", EspCocina: "' + EspCocina + '", EspPiso: "' + EspPiso + '", EspPanaderia: "' + EspPanaderia + '", EspAlmacen: "' + EspAlmacen + '", DiasCapacitacion: "' + DiasCapacitacion + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == 1) {
                    $("#MensajeAdministrativoExito").append("<p>Usuario modificado con éxito.</p>");
                    $("#AdministrativoExito").modal('show');
                    $("#ModalModificarUsuario").modal('hide');
                    CrearTablaAdminUsuarios();

                }
                else if (result.d == 2) {
                    $("#MensajeErrorAdministrativo").append("<p>El número de empleado que ingreso ya se encuentra asociado a un empleado, por favor verifiquelo.</p>");
                    $("#ErrorAdministrativo").modal('show');
                }
                else {
                    $("#MensajeErrorAdministrativo").append("<p>Lo sentimos ocurrio un error intentelo más tarde.</p>");
                    $("#ErrorAdministrativo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }
}


/*Función para agregar una nueva unidad de negocio.
Mario Gress
2018
*/

function AgregarUnidadNegocio()
{    
    var NombreUnidadNegocio = $("#NombreUnidadNegocio").val();
    var DireccionUnidadNegocio = $("#DireccionUnidadNegocio").val();
    var error = 0;

    $("#MensajeErrorAdministrativo").empty();
    $("#MensajeAdministrativoExito").empty();


    if (NombreUnidadNegocio == "" || NombreUnidadNegocio == " ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor introduzca el nombre de la unidad de negocio.</p>");
        error++;
    }
    if (DireccionUnidadNegocio == "" || DireccionUnidadNegocio == " ")
    {
        $("#MensajeErrorAdministrativo").append("<p>Por favor introduzca la dirección de la unidad de negocio.</p>");
        error++;
    }
    if (error > 0) {        
        $("#ErrorAdministrativo").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/AgregarUnidadNegocio",
            data: '{nombre:"' + NombreUnidadNegocio + '", direccion:"' + DireccionUnidadNegocio + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == 1) {
                    $("#MensajeAdministrativoExito").append("<p>Unidad de negocio agregda con éxito.</p>");
                    $("#AdministrativoExito").modal('show');
                    $("#ModalAgregarUnidadNegocio").modal('hide');
                    CrearTablaUnidadesNegocio();
                } else {
                    $("#MensajeErrorAdministrativo").append("<p>Lo sentimos, ocurrio un error intentelo más tarde.</p>");
                    $("#ErrorAdministrativo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }


}

/*Función para Activar y Desactivar una unidad de negocio.
Mario Gress
2018
*/

function DesactivarActivarUnidadNegocio(IDUN,tipo)
{
    $("#MensajeErrorAdministrativo").empty();
    $("#MensajeAdministrativoExito").empty();


    $.ajax({
        type: "POST",
        url: "Home.aspx/DesactivarActivarUnidadNegocio",
        data: '{IDUN:"' + IDUN + '", tipo:"' + tipo + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.d == 1) {
                if (tipo == 0) {
                    $("#MensajeAdministrativoExito").append("<p>Unidad de negocio desactivada con éxito.</p>");
                } else {
                    $("#MensajeAdministrativoExito").append("<p>Unidad de negocio activada con éxito.</p>");
                }
                $("#AdministrativoExito").modal('show');
                CrearTablaUnidadesNegocio();
            } else {
                $("#MensajeErrorAdministrativo").append("<p>Lo sentimos, ocurrio un error intentelo más tarde.</p>");
                $("#ErrorAdministrativo").modal('show');
            }
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}



/*Función para guardar los cambios en la unidad de negocio seleccionada.
Mario Gress
2018
*/

function GuardarModificacionesUnidadNegocio()
{    
    var NombreUnidadNegocioM = $("#NombreUnidadNegocioM").val();
    var DireccionUnidadNegocioM = $("#DireccionUnidadNegocioM").val();
    var IDUN = $("#IDUNM").val();
    var error = 0;

    $("#MensajeErrorAdministrativo").empty();
    $("#MensajeAdministrativoExito").empty();


    if (NombreUnidadNegocioM == "" || NombreUnidadNegocioM == " ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor introduzca el nombre de la unidad de negocio.</p>");
        error++;
    }
    if (DireccionUnidadNegocioM == "" || DireccionUnidadNegocioM == " ") {
        $("#MensajeErrorAdministrativo").append("<p>Por favor introduzca la dirección de la unidad de negocio.</p>");
        error++;
    }
    if (error > 0) {
        $("#ErrorAdministrativo").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/GuardarModificacionesUnidadNegocio",
            data: '{IDUN:"' + IDUN + '", nombre:"' + NombreUnidadNegocioM + '", direccion:"' + DireccionUnidadNegocioM + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == 1) {
                    $("#MensajeAdministrativoExito").append("<p>Unidad de negocio modificada con éxito.</p>");
                    $("#AdministrativoExito").modal('show');
                    $("#ModalModificarUnidadNegocio").modal('hide');
                    CrearTablaUnidadesNegocio();
                } else {
                    $("#MensajeErrorAdministrativo").append("<p>Lo sentimos, ocurrio un error intentelo más tarde.</p>");
                    $("#ErrorAdministrativo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}


/*Función para agregar una nueva zona.
Mario Gress
2018
*/

function AgregarZona()
{
    var zona = $("#NombreZona").val();

    if(zona == "" || zona == " ")
    {
        $("#MensajeErrorAdministrativo").append("<p>Por favor ingrese el nombre de la zona.</p>");
        $("#ErrorAdministrativo").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/AgregarZona",
            data: '{zona:"' + zona + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == 1) {
                    $("#MensajeAdministrativoExito").append("<p>Zona agregada con éxito.</p>");
                    $("#AdministrativoExito").modal('show');
                    $("#ModalAgregarZona").modal('hide');
                    CrearTablaZonas();
                } else {
                    $("#MensajeErrorAdministrativo").append("<p>Lo sentimos, ocurrio un error intentelo más tarde.</p>");
                    $("#ErrorAdministrativo").modal('show');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }
    
}

function AbrirModalSubirExcel()
{
    $('#progress').empty();
}



/*Función para limpiar el modal de Reporte Concentrado
Mario Gress
2018
*/

function LimpiarModalReporteConcentrado()
{
    $("#FechaIni").val('');
    $("#FechaFin").val('');
    $("#TablaReporteConcentrado").empty();
    $("#ReporteUnidadNegocio").empty();
    $("#ReporteTipoEncuesta").empty();
    ObtenerUnidadesNegocioReporte();
    ObtenerTiposEncuesta();
}


/*Función para crear la tabla de reporte concentrado
Mario Gress
2018
*/

function CrearTablaReporteConcentrado()
{
    var FechaIni = $("#FechaIni").val();
    var FechaFin = $("#FechaFin").val();
    var UnidadNegocio = $("#ReporteUnidadNegocio").val();
    var TipoEncuesta = $("#ReporteTipoEncuesta").val();
    $("#MensajeErrorReporte").empty();
    $("#TablaReporteConcentrado").empty();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    var error = 0;

    if (FechaIni == "" || SPFechaFin == "")
    {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true)
    {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if(error > 0)
    {
        $("#ErrorReporte").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/CrearTablaReporteConcentrado",
            data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '", UnidadNegocio:"' + UnidadNegocio + '", TipoEncuesta:"' + TipoEncuesta + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#TablaReporteConcentrado").append(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }
}

/*Función para abrir el modal del detalle del reporte. 
Mario Gress
2018
*/

function AbrirModalReporteDetalle(IDEvaluando, IDEvaluador, Tipo)
{
    $("#TablaDetalleReporte").empty();
    $("#ModalReporteDetalle").modal('show');
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerDetalleReporte",
        data: '{IDEvaluando:"' + IDEvaluando + '", IDEvaluador:"' + IDEvaluador + '", Tipo:"' + Tipo + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result)
        {
            $("#TablaDetalleReporte").append(result.d);
        },
        error: function (e)
        {
            console.log(e.statusText);
        }
    });
}

/*Función para limpiar el modal de las estadisticas
Mario Gress
2018
*/

function LimpiarModalReporteEstadisticas()
{
    $("#FechaIniGrafica").val('');
    $("#FechaFinGrafica").val('');
    $("#GEncuestaUnidad").empty();
    $("#GPromedioUnidad").empty();
}

/*Función para crear la gráfica del número de encuestas por unidad.
Mario Gress
2018
*/

function CrearGraficaEncuestaUnidad() {
    $("#GEncuestaUnidad").empty();
    $("#GPromedioUnidad").empty();
    $("#MensajeErrorReporte").empty();
    var FechaIni = $("#FechaIniGrafica").val();
    var FechaFin = $("#FechaFinGrafica").val();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];


    if (FechaIni == "" || FechaFin == "" || moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true)
    {
        $("#MensajeErrorReporte").append("<p>Por favor seleccione un rango de fechas valido.</p>");
        $("#ErrorReporte").modal('show');
    }else{
        $("#GEncuestaUnidad").append("<h5>Encuestas Registradas por Unidad</h5><canvas id='GRSBarras' style='max-width: 1000px;'></canvas>");
    var ctxP = document.getElementById("GRSBarras").getContext('2d');
    var Unidades, Valor;   
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadesEncuestas",
        data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            Unidades = result.d;
        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerValoresUnidadEncuestas",
            data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var Valores = result.d;
                var myPieChart = new Chart(ctxP, {
                    type: 'pie',
                    data: {
                        labels: Unidades,
                        datasets: [
                            {
                                data: Valores,
                                backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#949FB1", "#4D5360", "#26a69a", "#795548", "#ff5722"],
                                hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#A8B3C5", "#616774", "#80cbc4", "#8d6e63", "#ff7043"]
                            }
                        ]
                    },
                    options: {
                        responsive: true
                    }
                });
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
    CrearGraficaPromedioUnidad();
    }    
}

/*Función para crear la gráfica de promedio de unidades.
Mario Gress
2018
*/

function CrearGraficaPromedioUnidad() {
    $("#GPromedioUnidad").empty();
    $("#GPromedioUnidad").append("<h5>Desempeño Promedio por Unidad</h5><canvas id='GRPBarras' style='max-width: 1000px;'></canvas>");
    var FechaIni = $("#FechaIniGrafica").val();
    var FechaFin = $("#FechaFinGrafica").val();
    var ctx = document.getElementById("GRPBarras").getContext('2d');
    var Unidades, Valor;



    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadesPromedio",
        data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            Unidades = result.d;
            $.ajax({
                type: "POST",
                url: "Home.aspx/ObtenerValoresUnidadPromedio",
                data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    Valor = result.d;
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Unidades,
                            datasets: [{
                                label: 'Promedio Unidad',
                                data: Valor,
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)',
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)',
                                    'rgba(255,99,132,1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true
                                    }
                                }]
                            }
                        }
                    });
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

}

/*Función para descargar el Excel de la tabla que recibe cómo parametro.
Mario Gress
2018
*/

function DescargarExcel(IDTabla,name)
{
    $("#" + IDTabla + "").table2excel({
        // exclude CSS class            
        exclude: ".noExl",
        name: "Worksheet Name",
        filename: name + moment().format("DD-MM-YYYY") //do not include extension        
    });

}

/*Función para obtener las unidades de negocio
Mario Gress
2018
*/

function ObtenerUnidadesNegocioReporte()
{
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadesNegocio",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#ReporteUnidadNegocio").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para obtener las unidades de negocio para reporte de acreditación
Mario Gress
2018
*/

function ObtenerUnidadesNegocioReporteAcreditacion() {
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadesNegocio",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#ReporteUnidadNegocioAC").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para obtener la unidad de negocio
Mario Gress
2018
*/

function ObtenerTiposEncuesta() {
    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerTipoEncuesta",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#ReporteTipoEncuesta").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}


/*Función para limpiar el reporte de acreditación 
Mario Gress
2018
*/

function LimpiarModalReporteAcreditacion()
{
    $("#FechaIniAC").val('');
    $("#FechaFinAC").val('');
    $("#NumeroEmpleadoRAC").val('');
    $("#ReporteUnidadNegocioAC").empty();
    $("#TablaReporteAcreditacion").empty();
    ObtenerUnidadesNegocioReporteAcreditacion();
}


function CrearTablaReporteAcreditacion() {
    var FechaIni = $("#FechaIniAC").val();
    var FechaFin = $("#FechaFinAC").val();
    var UnidadNegocio = $("#ReporteUnidadNegocioAC").val();
    var NumEmpleado = $("#NumeroEmpleadoRAC").val();
    $("#MensajeErrorAdministrativo").empty();
    $("#TablaReporteAcreditacion").empty();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    var error = 0;

    if (FechaIni == "" || SPFechaFin == "") {
        $("#MensajeErrorAdministrativo").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true) {
        $("#MensajeErrorAdministrativo").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if (error > 0) {
        $("#ErrorAdministrativo").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/CrearTablaReporteAcreditacion",
            data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '", UnidadNegocio:"' + UnidadNegocio + '", NumEmpleado:"' + NumEmpleado + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                $("#TablaReporteAcreditacion").append(result.d);
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

}

/*Función para acreditar a un usuario
Mario Gress
2018
*/

function AcreditarUsuario(NoEmpleado) {

    $("#MensajeErrorReporte").empty();
    $.ajax({
        type: "POST",
        url: "Home.aspx/AcreditarUsuario",
        data: '{NoEmpleado:"' + NoEmpleado + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (result.d == 0) {
                $("#MensajeErrorReporte").append("<p>Lo sentimos ocurrio un error, por favor intentelo más tarde.</p>");
                $("#ErrorReporte").modal('show');
            } else {
                CrearTablaReporteAcreditacion();
            }
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para abrir el modal de agregar comentarios a usuario.
Mario Gress
2018
*/
    function AbrirModalComentarios(NoEmpleado)
    {
        $("#IDU").val(NoEmpleado);
        $("#AOUObservaciones").val('');
        $("#ModalObservacionesUsuario").modal('show');
    }

/*Función para guardar las observaciones en un usuario
Mario Gress
2018
*/

    function GuardarObservacionesUsuario()
    {
        var NoEmpleado = $("#IDU").val();
        var Observaciones = $("#AOUObservaciones").val();

        $.ajax({
            type: "POST",
            url: "Home.aspx/AgregarObservacionesUsuario",
            data: '{NoEmpleado:"' + NoEmpleado + '", Observaciones:"' + Observaciones + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d == 0) {
                    $("#MensajeErrorReporte").append("<p>Lo sentimos ocurrio un error, por favor intentelo más tarde.</p>");
                    $("#ErrorReporte").modal('show');
                } else {
                    CrearTablaReporteAcreditacion();
                    $("#ModalObservacionesUsuario").modal('hide');
                }
            },
            error: function (e) {
                console.log(e.statusText);
            }
        });
    }

    /*Función para obtener parametros de la URL con Jquery
    Mario Gress
    2018
    */
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

        var numeroempleado = $.OURL("NE");
        return numeroempleado;
    }

    function AbrirDivCargando() {        
        document.getElementById("myNav").style.width = "100%";
    }
    
    function CerrarDivCargando(){
        document.getElementById("myNav").style.width = "0%";
    }