/* MRC
Mario Gress 

2018

Documento JavaScript con funciones utilizadas para la aplicación de Reporte de Explosión de Insumos.


*/


function Ingresar()
{
    var Usuario = $("#NombreUsuario").val();
    var PIN = $("#PINUsuario").val();
    $("#mensajerror").empty();

    if (Usuario == "" || Usuario == " ")
    {
        $("#mensajerror").append("<p>Por favor ingrese su nombre de usuario</p>");
        $("#ErrorDatos").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Login.aspx/VerificaUsuario",
            data: '{Usuario:"' + Usuario + '", PIN:"' + PIN + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(result)
            {
                if(result.d > 0)
                {
                    location.href = "http://mrc.sytes.net/ReporteInsumos/Home.aspx";
                } else {
                    $("#mensajerror").append("<p>Verifique su nombre de usuario y/o contraseña.</p>");
                    $("#ErrorDatos").modal('show');
                }
            },
            error: function(e)
            {
                console.log(e.statusText);
            }
        });
    }

}

function CerrarSesion()
{
    location.href = "http://mrc.sytes.net/ReporteInsumos/Login.aspx";
}


/*Función para mostrar y/o ocultar campos dependiendo el tipo de documento que se va a subir
Mario Gress
2018
*/

function CambioTipoDocumento()
{
    var tipo = $("#TipoArchivo").val();

    if(tipo == 2)
    {
        $("#SelectDetalleInsumo").show();
    } else {
        $("#SelectDetalleInsumo").hide();
    }
}

/*Función para obtener los insumos por periodo y unidad de negocio
Mario Gress
2018
*/

function ObtenerInsumos()
{
    var FechaIni = $("#FechaIniI").val();
    var FechaFin = $("#FechaFinI").val();
    var IDUN = $("#UnidadNegocio").val();
    var AreaOperativa = $("#SubTipoArchivo").val();


    $("#Insumo").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerInsumosPeriodo",
        data: '{FechaIni: "' + FechaIni + '", FechaFin: "' + FechaFin + '", IDUN: "' + IDUN + '", AreaOperativa:"' + AreaOperativa + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#Insumo").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
    
}

/*Función para limpiar el modal de subir archivos.
Mario Gress
2018
*/

function LimpiarModalSubirArchivos()
{
    $("#FechaIniI").val('');
    $("#FechaFinI").val('');
    $("#TipoArchivo").val('-1');
    $("#SelectDetalleInsumo").hide();
    $("#UnidadNegocio").empty();
    $("#Insumo").empty();
    $("#progress").empty();
    $("#SubTipoArchivo").val(-1);

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadNegocio",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#UnidadNegocio").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para subir un nuevo archivo 
Mario Gress
2018
*/

function SubirArchivo() {

    var TipoDocumento = $("#TipoArchivo").val();
    var FechaIni = $("#FechaIniI").val();
    var FechaFin = $("#FechaFinI").val();
    var Insumo = $("#Insumo").val();
    var NombreArchivo = $("#NombreArchivo").val();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    var IDUN = $("#UnidadNegocio").val();
    var SubTipo = $("#SubTipoArchivo").val();
    

    var error = 0;

    $("#MensajeErrorSubirArchivo").empty();

    if(TipoDocumento == "-1")
    {
        $("#MensajeErrorSubirArchivo").append("Seleccione el tipo de documento a subir");        
        error++;
    }
    if(TipoDocumento == "2")
    {
        if(Insumo <= "0")
        {
            $("#MensajeErrorSubirArchivo").append("Seleccione el insumo al que quiere asociar el documento");
            error++;
        }        
    }

    if(NombreArchivo == "" || NombreArchivo == " ")
    {
        $("#MensajeErrorSubirArchivo").append("Seleccione un archivo a subir por favor");
        error++;
    }

    if (FechaIni == "" || SPFechaFin == "") {
        $("#MensajeErrorSubirArchivo").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true) {
        $("#MensajeErrorSubirArchivo").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if(IDUN == "-1")
    {
        $("#MensajeErrorSubirArchivo").append("<p>Seleccione una unidad.</p>");
        error++;
    }

    if (SubTipo == -1)
    {
        $("#MensajeErrorSubirArchivo").append("<p>Seleccione un área operativa</p>");
        error++;
    }

    if(error > 0)
    {
        $("#ErrorSubirArchivo").modal('show');
    } else {

        $("input[name=Excel]").simpleUpload("http://mrc.sytes.net/ReporteInsumos/SubirArchivo.asmx/SubirDocumento", {
            name: $("#ObserveIDS").val(),
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
                $("#RespuestaExcel").empty();
                $('#progress').html("¡Éxito al subir archivos!<br>");
                $("#ModalSubirExcel").modal('hide');
                $("#ModalCargaUsuarios").modal('show');
                $("#RespuestaExcel").append("<h4>Espere por favor<h4>");
                $("#Cargando").show();
                $.ajax({
                    type: "POST",
                    url: "Home.aspx/AgregarDocumento",
                    data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '", NombreArchivo:"' + data.msg + '", tipo:"' + TipoDocumento + '", IDUN:"' + IDUN + '", IDU:"' + 1 + '", IDI:"' + Insumo + '", SubTipo:"' + SubTipo + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        $("#RespuestaExcel").empty();                        
                        $("#RespuestaExcel").append(result.d);
                        $("#ModalSubirArchivos").modal("hide");
                    },
                    error: function (e) {
                        console.log(e.statusText);
                    }
                });
                $('#filename').empty();

            },
            error: function (error) {
                //upload failed
                $('#progress').html("Failure!<br>" + error.name + ": " + error.message);
            }
        });
    }
}



/*Función para limpiar el modal del reporte 
2018
Mario Gress
*/
function LimpiarModalReporte() {
    $("#FechaIni").val('');
    $("#FechaFin").val('');
    $("#ReporteUnidadNegocio").empty();
    $("#MensajeErrorReporteConcentrado").empty();
    $("#TablaReporteConcentrado").empty();
    $("#ReporteAreaOperativa").val(-1);
    $("#ProductoRE").val('');

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadNegocio",
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


/*Función para crear la tabla del reporte concentrado
Mario Gress
2018
*/

function CrearTablaReporteConcentrado()
{
    var FechaIni = $("#FechaIni").val();
    var FechaFin = $("#FechaFin").val();
    var IDUN = $("#ReporteUnidadNegocio").val();
    var Insumo = $("#ProductoRE").val();
    var error = 0;
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    var AreaOperativa = $("#ReporteAreaOperativa").val();
    var CheckCostos;
    $("#MensajeErrorReporteConcentrado").empty();
    $("#TablaReporteConcentrado").empty();

    if ($("#CheckCostos").prop('checked')) {
        CheckCostos = true;
    } else {
        CheckCostos = false;
    }

    if (FechaIni == "" || SPFechaFin == "") {
        $("#MensajeErrorReporteConcentrado").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if(AreaOperativa == -1)
    {
        $("#MensajeErrorReporteConcentrado").append("<p>Seleccione un área operativa.</p>");
        error++;
    }

    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true) {
        $("#MensajeErrorReporteConcentrado").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if(error > 0)
    {
        $("#ErrorReporteConcentrado").modal('show');
    } else {
        $.ajax({
            type: "POST",
            url: "Home.aspx/CrearTablaReporteConcentrado",
            data: '{FechaIni:"' + FechaIni + '", FechaFin:"' + FechaFin + '", IDUN:"' + IDUN + '", Insumo:"' + Insumo + '", AreaOperativa:"' + AreaOperativa + '", CheckCostos:"' + CheckCostos + '"}',
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

/*Función para limpiar el modal de reporte de estadisticas
Mario Gress
2018
*/

function LimpiarModalReporteEstadisticas()
{
    var FechaIni = $("#FechaIniGrafica").val("");
    var FechaFin = $("#FechaFinGrafica").val("");
    $("#GraficaInsumoConcentrado").empty();
    $("#GFechaInsumoUnidad").empty();
    $("#GFechaInsumoArea").empty();
    $("#UnidadReporteInsumo").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerUnidadNegocio",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#UnidadReporteInsumo").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });

}

/*Función para obtener los insumos del periodo seleccionado
Mario Gress
2018
*/

function ObtenerInsumosGrafica()
{
    var FechaIni = $("#FechaIniGrafica").val();
    var FechaFin = $("#FechaFinGrafica").val();
    $("#GraficaInsumoConcentrado").empty();

    $.ajax({
        type: "POST",
        url: "Home.aspx/ObtenerInsumosPeriodoGrafica",
        data: '{FechaIni: "' + FechaIni + '", FechaFin: "' + FechaFin + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $("#GraficaInsumoConcentrado").append(result.d);
        },
        error: function (e) {
            console.log(e.statusText);
        }
    });
}

/*Función para crear la gráfica comparativa de perdidas de un insumo entre unidades
Mario Gress
2018
*/

function CrearGraficaInsumoFecha()
{
    var FechaIni = $("#FechaIniGrafica").val();
    var FechaFin = $("#FechaFinGrafica").val();
    var Insumo = $("#GraficaInsumoConcentrado option:selected").text();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    $("#GFechaInsumoUnidad").empty();
    $("#MensajeErrorReporte").empty();
    var error = 0;

    if (FechaIni == "" || FechaFin == "") 
    {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true) 
    {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if (Insumo == "Seleccione un insumo...") 
    {
        $("#MensajeErrorReporte").append("<p>Seleccione un insumo por favor.</p>");
        error++;
    }


    if(error > 0)
    {
        $("#ErrorReporte").modal('show');
    }
    else {
        $("#GFechaInsumoUnidad").append("<canvas id='GInsumoUnidadBarras' style='max-width: 1200px;'></canvas>");
        var ctx = document.getElementById("GInsumoUnidadBarras").getContext('2d');

        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerDatosInsumoUnidadGrafica",
            data: '{Insumo:"' + Insumo + '", FechaIni: "' + FechaIni + '", FechaFin: "' + FechaFin + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var datos = result.d;
                var aux = true;
                /*Aquí me la fume la neta, pero l oque hice fue separar el array en dos diferentes para poderlos mandar a la gráfica*/
                var Unidades = [], Valores = [];                                
                datos.forEach(function (element) {                    
                    if(aux == true)
                    {
                        Unidades.push(element);
                        aux = false;
                    } else {
                        Valores.push(element);
                        aux = true;
                    }                    
                });
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: Unidades,
                        datasets: [{
                            label: '# Variación',
                            data: Valores,
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
    }

}

/*Función para crear la gráfica de comparativa de insumo por unidad entre áreas operativas
Mario Gress
2018
*/

function CrearGraficaInsumoFechaArea()
{
    var FechaIni = $("#FechaIniGrafica").val();
    var FechaFin = $("#FechaFinGrafica").val();
    var Insumo = $("#GraficaInsumoConcentrado option:selected").text();    
    var Unidad = $("#UnidadReporteInsumo").val();
    var SPFechaIni = FechaIni.split("-");
    var SPFechaFin = FechaFin.split("-");
    var DFechaIni = SPFechaIni[2] + SPFechaIni[1] + SPFechaIni[0];
    var DFechaFin = SPFechaFin[2] + SPFechaFin[1] + SPFechaFin[0];
    $("#GFechaInsumoArea").empty();
    $("#MensajeErrorReporte").empty();
    var error = 0;

    if (FechaIni == "" || FechaFin == "") {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }
    if (moment(moment(DFechaFin).format('YYYY-MM-DD')).isBefore(moment(DFechaIni).format('YYYY-MM-DD')) == true) {
        $("#MensajeErrorReporte").append("<p>Ingrese un rango de fechas valido por favor.</p>");
        error++;
    }

    if (Insumo == "Seleccione un insumo...") {
        $("#MensajeErrorReporte").append("<p>Seleccione un insumo por favor.</p>");
        error++;
    }

    if(Unidad == -1)
    {
        $("#MensajeErrorReporte").append("<p>Seleccione un unidad.</p>");
        error++;
    }

    if (error > 0) {
        $("#ErrorReporte").modal('show');
    }
    else
    {
        $("#GFechaInsumoArea").append("<canvas id='GInsumoUnidadAreaBarras' style='max-width: 1200px;'></canvas>");
        var ctx = document.getElementById("GInsumoUnidadAreaBarras").getContext('2d');

        $.ajax({
            type: "POST",
            url: "Home.aspx/ObtenerDatosInsumoUnidadGraficaArea",
            data: '{Insumo:"' + Insumo + '", FechaIni: "' + FechaIni + '", FechaFin: "' + FechaFin + '", Unidad: "' + Unidad + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                var datos = result.d;
                var aux = true;
                /*Aquí me la fume la neta, pero l oque hice fue separar el array en dos diferentes para poderlos mandar a la gráfica*/
                var AreaOperativa = [], Valores = [];
                datos.forEach(function (element) {
                    if (aux == true) {
                        switch(element) {
                            case "0":
                                AreaOperativa.push("Piso");
                                break;
                            case "1":
                                AreaOperativa.push("Cocina");
                                break;
                            case "2":
                                AreaOperativa.push("Panaderia");
                                break;                                
                            default:
                                AreaOperativa.push("Otro");
                                break;

                        }                        
                        aux = false;
                    } else {
                        Valores.push(element);
                        aux = true;
                    }
                });
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: AreaOperativa,
                        datasets: [{
                            label: '# Variación',
                            data: Valores,
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
    }


}