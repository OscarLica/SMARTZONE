<%@ Page Title="Modulo Facturacion" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="MainFacturacion.aspx.cs" Inherits="Interface.MainFacturacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            const url = "MainFacturacion.aspx/ListarFacturas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: {
                        'Accept': 'application/json', 'Content-Type': 'application/json'
                    }
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((facturas) => {
                let tr = document.createElement("tr");
                let tdCodFactura = document.createElement("td");
                tdCodFactura.append(facturas.CodFactura);
                let tdCliente = document.createElement("td");
                tdCliente.append(facturas.DatosCliente);
                let tdEstado = document.createElement("td");
                tdEstado.append(facturas.Estado);
                let tdSubTotal = document.createElement("td");
                tdSubTotal.append(facturas.SubTotal);
                let tdIva = document.createElement("td");
                tdIva.append(facturas.Iva);
                let tdTotal = document.createElement("td");
                tdTotal.append(facturas.Total);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    location = "./VerFacturacion.aspx?IdFactura=" + facturas.Id;
                }
                //let btnView2 = document.createElement("input");
                //btnView2.value = "Anular";
                //btnView2.type = "button";
                //btnView2.onclick = () => {
                //    if (facturas.Estado == "Anulado") {
                //        ModalFunction('ModalMensaje1');
                //        document.getElementById('lblMensaje2').innerHTML = 'FACTURA Y SU DETALLE YA ESTAN ANULADAS';
                //    }
                //    else {
                //        ModalFunction('ModalAnular');
                //        document.getElementById('lblMensajeAnular').innerHTML = 'SEGURO DESEA ANULAR LA FACTURA Y SU DETALLE???';
                //        document.getElementById('txtIdFactura').value = facturas.Id;
                //    }
                //}
                tdActions.append(btnView/*, btnView2*/);
                //apends
                tr.append(tdCodFactura, tdCliente, tdEstado, tdSubTotal, tdIva, tdTotal, tdActions);
                Frag.append(tr);
            });
            TblFactura.querySelector("tbody").append(Frag);

            //Asignar eventos
            btnBuscar.addEventListener("click", BuscarFacturas);
            //btnAnular.addEventListener("click", Anular);
            //final eventos
        }
        //BuscarProducto
        const BuscarFacturas = async () => {
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "MainFacturacion.aspx/Buscar";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Parametro: txtBuscar.value })
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((facturas) => {
                let tr = document.createElement("tr");
                let tdCodFactura = document.createElement("td");
                tdCodFactura.append(facturas.CodFactura);
                let tdCliente = document.createElement("td");
                tdCliente.append(facturas.DatosCliente);
                let tdEstado = document.createElement("td");
                tdEstado.append(facturas.Estado);
                let tdSubTotal = document.createElement("td");
                tdSubTotal.append(facturas.SubTotal);
                let tdIva = document.createElement("td");
                tdIva.append(facturas.Iva);
                let tdTotal = document.createElement("td");
                tdTotal.append(facturas.Total);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    location = "./VerFacturacion.aspx?IdFactura=" + facturas.Id;
                }
                //let btnView2 = document.createElement("input");
                //btnView2.value = "Anular";
                //btnView2.type = "button";
                //btnView2.onclick = () => {
                //    if (facturas.Estado == "Anulado") {
                //        ModalFunction('ModalMensaje1');
                //        document.getElementById('lblMensaje2').innerHTML = 'FACTURA Y SU DETALLE YA ESTAN ANULADAS';
                //    }
                //    else {
                //        ModalFunction('ModalAnular');
                //        document.getElementById('lblMensajeAnular').innerHTML = 'SEGURO DESEA ANULAR LA FACTURA Y SU DETALLE???';
                //        document.getElementById('txtIdFactura').value = facturas.Id;
                //    }
                //}
                tdActions.append(btnView/*, btnView2*/);
                //apends
                tr.append(tdCodFactura, tdCliente, tdEstado, tdSubTotal, tdIva, tdTotal, tdActions);
                Frag.append(tr);
            });
            TblFactura.querySelector("tbody").append(Frag);
        }

        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ProductosContainer">
        <div class="ModalTitle">
            MODULO FACTURACION
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscar" class="btnSuccess" value="Buscar" />
        </div>
        <div class="Content">
            <table id="TblFactura" class="TblForm">
                <thead>
                    <tr>
                        <th>N° FACTURA</th>
                        <th>CLIENTE</th>
                        <th>ESTADO</th>
                        <th>SUB TOTAL</th>
                        <th>IVA</th>
                        <th>TOTAL</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnPrimary" onclick="window.location = 'Facturacion.aspx'" value="Nueva Factura" />
<%--                <input type="button" class="btnPrimary" onclick="window.location = 'Devolucion.aspx'" value="Devolucion" />--%>
                <input type="button" class="btnCancel" onclick="window.location = 'Default.aspx'" value="Regresar" />
            </div>
        </div>
    </div>
    <%--ANULAR--%>
    <div class="Modal" id="ModalAnular">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <%--<label class="lblMensaje1" id="lblMensaje">FACTURA SE PODRÁ ANULAR SIEMPRE Y CUANDO LOS ARTICULOS AUN ESTEN EN GARANTIA</label>--%>
                <label class="lblMensaje2" id="lblMensajeAnular"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAnular" class="btnSuccess" value="Anular" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalAnular')" value="Cancelar" />
                <label for="TextoId" style="visibility: hidden">IdFactura:<input type="number" class="txtForm2" name="Type" id="txtIdFactura" /></label>
            </div>
        </div>
    </div>
    <%--Mensaje--%>
    <div class="Modal" id="ModalMensaje1">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensaje2"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnSuccess" onclick="ModalFunction('ModalMensaje1')" value="Aceptar" />
            </div>
        </div>
    </div>
</asp:Content>
