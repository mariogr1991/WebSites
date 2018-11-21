<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataTable.aspx.cs" Inherits="DataTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>         
    <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
    <link href="CSS/mdb.css" rel="stylesheet" />
    <title></title>
</head>
<body>
<table id="example" class="display table table-hover table-bordered table-striped table-bordered" style="width:100%">
        <thead class="blue-grey lighten-4">
            <tr>
                <th>Unidad</th>
                <th>Producto</th>
                <th>Unidad de Medida</th>
                <th>Costo Unitario</th>
                <th>Inventario Inicial</th>
                <th>$ Inventario Inicial</th>
                <th>Compras</th>
                <th>$ Compras</th>
                <th>Utilizado</th>
                <th>$ Utilizado</th>
                <th>Inventario Final</th>
                <th>$ Inventario Final</th>
                <th>Inventario Inicial - Compras</th>
                <th>$ Inventario Inicial - Compras</th>
                <th>Diferencia Variación</th>
                <th>Variación Utilizado</th>
                <th>Variación</th>
                <th>$ Variación</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Unidad</th>
                <th>Producto</th>
                <th>Unidad de Medida</th>
                <th>Costo Unitario</th>
                <th>Inventario Inicial</th>
                <th>$ Inventario Inicial</th>
                <th>Compras</th>
                <th>$ Compras</th>
                <th>Utilizado</th>
                <th>$ Utilizado</th>
                <th>Inventario Final</th>
                <th>$ Inventario Final</th>
                <th>Inventario Inicial - Compras</th>
                <th>$ Inventario Inicial - Compras</th>
                <th>Diferencia Variación</th>
                <th>Variación Utilizado</th>
                <th>Variación</th>
                <th>$ Variación</th>
            </tr>
        </tfoot>
    </table>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="DataTables/datatables.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $.ajax({
                type: "POST",
                url: "DataTable.aspx/CrearTablaReporteConcentrado",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    
                    $('#example').DataTable({
                        data: result.d,
                        "language": {
                            "lengthMenu": "Mostrar _MENU_ registros por página",
                            "zeroRecords": "Sin registros",
                            "info": "Mostrando página _PAGE_ de _PAGES_",
                            "infoEmpty": "Sin información",
                            "infoFiltered": "(Filtrado por _MAX_ total de registros)"
                        }
                        });
                },
                error: function (e) {
                    console.log(e.statusText);
                }
            
            });

        });

    </script>
</body>
</html>
