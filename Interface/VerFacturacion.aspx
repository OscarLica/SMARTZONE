<%@ Page Title="Ver Factura" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="VerFacturacion.aspx.cs" Inherits="Interface.VerFacturacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            document.getElementById("txtRUC").value = "JP16075900";
            let params = new URLSearchParams(location.search);
            const IdFactura = params.get("IdFactura");
            console.log(IdFactura);
            const url = "VerFacturacion.aspx/ListarFactura";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id: IdFactura })
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdCantidad = document.createElement("td");
                tdCantidad.append(productos.Cantidad);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(productos.Descripcion);
                let tdGarantia = document.createElement("td");
                tdGarantia.append(productos.GarantiaDias);
                let tdPrecio = document.createElement("td");
                tdPrecio.append(productos.PrecioxUnd);
                let tdDescuento = document.createElement("td");
                tdDescuento.append(productos.Descuento);
                let tdTotal = document.createElement("td");
                tdTotal.append(productos.Total);
                //obtenemos el SubTotal, Iva y Total
                document.getElementById('txtSubTotal').value = productos.SubTotal;
                document.getElementById('txtIva').value = productos.Iva;
                document.getElementById('txtTotal').value = productos.Total2;
                document.getElementById('txtNumFactura').value = productos.CodFactura;
                document.getElementById('txtDatosCliente').value = productos.Cliente;
                document.getElementById('txtEfectivo').value = productos.Efectivo;
                document.getElementById('txtCambio').value = productos.Vuelto;
                document.getElementById('txtFecha').value = productos.FechaFacturacion;
                document.getElementById('txtEstado').value = productos.Estado;

                if (productos.Estado == "Anulado") {
                    document.getElementById('txtEstado').style.backgroundColor = "red";
                }
                else {
                    document.getElementById('txtEstado').style.backgroundColor = "green";
                }
                tr.append(tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                Frag.append(tr);
            });
            TblDetalle.querySelector("tbody").append(Frag);
            //Asignar eventos
            btnAnular.addEventListener("click", Anular);
            btnAnular1.addEventListener("click", Anular1);
        }
        ////Anular
        const Anular = async () => {
            if (txtEstado.value == "Anulado") {
                    ModalFunction('ModalMensaje1');
                    document.getElementById('lblMensaje2').innerHTML = 'FACTURA Y SU DETALLE YA ESTAN ANULADAS';
            }
            else {
                ModalFunction('ModalAnular'); //ocultamos el modal
                const url = "VerFacturacion.aspx/Valiar";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ FechaVence: txtFecha.value })
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {      
                    document.getElementById('lblMensajeAnular').innerHTML = 'ESTA SEGURO EN ANULAR LA FACTURA Y SU DETALLE';                    
                    document.getElementById("btnAnular1").disabled = false; //habilitamos el boton anular
                }
                else {
                    document.getElementById('lblMensajeAnular').innerHTML = 'FACTURA YA ESTA VENCIADA NO SE PUEDE ANULAR'; 
                    document.getElementById("btnAnular1").disabled = true; //bloquamos el boton anular
                }
            }
        }
        ////Anular
        const Anular1 = async () => {
                document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                ModalFunction('ModalAnular'); //ocultamos el modal
                const url = "VerFacturacion.aspx/Anular";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ NumFAC: txtNumFactura.value })
                    });
                response = await response.json();
                console.log(response);           
                let Frag = document.createDocumentFragment();
                response.d.forEach((productos) => {
                    let tr = document.createElement("tr");
                    let tdCantidad = document.createElement("td");
                    tdCantidad.append(productos.Cantidad);
                    let tdDescripcion = document.createElement("td");
                    tdDescripcion.append(productos.Descripcion);
                    let tdGarantia = document.createElement("td");
                    tdGarantia.append(productos.GarantiaDias);
                    let tdPrecio = document.createElement("td");
                    tdPrecio.append(productos.PrecioxUnd);
                    let tdDescuento = document.createElement("td");
                    tdDescuento.append(productos.Descuento);
                    let tdTotal = document.createElement("td");
                    tdTotal.append(productos.Total);
                    //obtenemos el SubTotal, Iva y Total
                    document.getElementById('txtSubTotal').value = productos.SubTotal;
                    document.getElementById('txtIva').value = productos.Iva;
                    document.getElementById('txtTotal').value = productos.Total2;
                    document.getElementById('txtNumFactura').value = productos.CodFactura;
                    document.getElementById('txtDatosCliente').value = productos.Cliente;
                    document.getElementById('txtEfectivo').value = productos.Efectivo;
                    document.getElementById('txtCambio').value = productos.Vuelto;
                    document.getElementById('txtFecha').value = productos.FechaFacturacion;
                    document.getElementById('txtEstado').value = productos.Estado;

                    if (productos.Estado == "Anulado") {
                        document.getElementById('txtEstado').style.backgroundColor = "red";
                    }
                    else {
                        document.getElementById('txtEstado').style.backgroundColor = "green";
                    }
                    tr.append(tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                    Frag.append(tr);
                });
            TblDetalle.querySelector("tbody").append(Frag);
                    ModalFunction('ModalMensaje1');
                    document.getElementById('lblMensaje2').innerHTML = 'FACTURA ANULADA CON EXITO';
        }
        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%--ENCABEZADO--%>
    <div class="GroupDiv" id="ProductoContainer">
        <div class="ModalTitle">
            FACTURA            
        </div>
        <div class="ModalActions" style="display: inline-flex; text-align: center">
            <label class="lblMensaje1" id="lblMensaje">FACTURA SE PODRÁ ANULAR SIEMPRE Y CUANDO NO ESTE VENCIDA</label>
        </div>
        <div class="col-lg-12" style="margin-top:20px;">
            <div class="col-xs-12 col-sm-6 col-md-6">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <label for="TextoRUC">RUC:<input type="text" class="txtFormRUC" name="Type" id="txtRUC" readonly="readonly" /></label>     
                    <label for="TextoFactura">N° Factura:<input type="text" class="txtFormF2" name="Type" id="txtNumFactura" readonly="readonly" /></label>
                    <label for="TextoEstado">Estado:<input type="text" class="txtFormF2" name="Type" id="txtEstado" readonly="readonly" /></label>
                    <label for="TextoFecha">Fecha Vence:<input type="text" class="txtFormF2" name="Type" id="txtFecha" readonly="readonly" /></label>
                </div>
            </div>    
        </div>
        <div class="col-lg-12" style="margin-top:20px;">
            <div class="col-xs-12 col-sm-6 col-md-6">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <label for="TextoCliente">Datos Cliente:<input type="text" class="txtFormF" name="Type" id="txtDatosCliente" readonly="readonly" /></label>
                </div>
            </div>    
        </div>
    </div>
    <%--DETALLE--%>
    <div class="GroupDiv" id="ProductosDetalle">
        <div class="ModalTitle">
            DETALLE DE FACTURA
        </div>
        <div class="Content">
            <table id="TblDetalle" class="TblForm">
                <thead>
                    <tr>
                        <th>CANTIDAD</th>
                        <th>DESCRIPCION</th>
                        <th>DIAS GARANTIA</th>
                        <th>PRECIO</th>
                        <th>DESCUENTO</th>
                        <th>TOTAL</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: right">
                <label for="TextoSubTotal">SubTotal:<input type="text" class="txtForm2" name="Type" id="txtSubTotal" readonly="readonly" /></label>
                <label for="TextoIva">Iva:<input type="text" class="txtForm2" name="Type" id="txtIva" readonly="readonly" /></label>
                <label for="TextoTotal">Monto Total:<input type="text" class="txtForm2" name="Type" id="txtTotal" readonly="readonly" /></label>
            </div>
            <div class="ModalActions" style="display: inline-flex">
                <label for="TextoEfectivo">C$ Efectivo:<input type="number" class="txtForm1" name="Type" id="txtEfectivo" readonly="readonly" /></label>
                <label for="TextoCambio">C$ Cambio:<input type="text" class="txtForm1" name="Type" id="txtCambio" readonly="readonly" /></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAnular" class="btnPrimary" <%--onclick="ModalFunction('ModalAnular')"--%> value="Anular" />
                <input type="button" class="btnCancel" onclick="window.location = 'MainFacturacion.aspx'" value="Regresar" />
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
    <%--ANULAR--%>
    <div class="Modal" id="ModalAnular">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensajeAnular"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAnular1" class="btnSuccess" value="Aceptar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalAnular')" value="Cancelar" />
            </div>
        </div>
    </div>
</asp:Content>
