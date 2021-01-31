<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="Interface.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Script/jquery-3.5.1.js"></script>
    <script>
        $(function () {
            var generar = document.getElementById("GenerateReport");
            generar.addEventListener("click", GenerarReporte)
        });

        const GenerarReporte = async () => {
            let response = await fetch(
                "Reportes.aspx/GenerarReporte", {
                method: "POST",
                headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        IdTipoReporte: document.getElementById("TipoReporte").value
                })
            });
            debugger;
            response = await response.json();

            var byte = response.d.replace(/['"]+/g, '');

            var src = "data:application/pdf;base64," + byte;

            var embed = $("#embedReporte");

            document.getElementById("embedReporte").src = src;

            $(embed).show();
            $("#reporte-avance-procesos").show();
            $("#lblSinResultados").hide();  
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ProductosContainer">
        <div class="ModalTitle">
            REPORTES
        </div>
        <div class="ModalActions">
            <select class="txtForm" id="TipoReporte">
                <option value="1"> Reporte compras</option>
                <option value="2"> Reporte ventas</option>
                <option value="3"> Reporte producto en bodega</option>
                 <option value="4"> Reporte producto con garantia</option>
                <option value="5"> Reporte productos más vendidos</option>
            </select>
            <input type="button" id="GenerateReport" data-generate-report="true" class="btnSuccess" value="Generar" />
        </div>
        <div class="Content ModalActions">
            <label id="lblSinResultados">No se encontraron resultados</label>
            <iframe width="1000" height="600" id="embedReporte" class="embed-responsive-item"></iframe>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnCancel" onclick="window.location = 'Default.aspx'" value="Regresar" />
            </div>
        </div>
    </div>

</asp:Content>
