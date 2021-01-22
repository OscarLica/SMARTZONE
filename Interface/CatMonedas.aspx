<%@ Page Title="Catalogo de Monedas" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CatMonedas.aspx.cs" Inherits="Interface.Modulos.Catalogos.Moneda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            const url = "CatMainMoneda.aspx/CargarMonedas";
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
            response.d.forEach((moneda) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(moneda.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(moneda.Descripcion);
                let tdSimbolo = document.createElement("td");
                tdSimbolo.append(moneda.Simbolo);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Detalle";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarMonedas');
                    document.getElementById('txtId').value = moneda.Id;
                    document.getElementById('txtNombreMoneda').value = moneda.Descripcion;
                    document.getElementById('txtSimbologia').value = moneda.Simbolo;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdSimbolo, tdActions);
                Frag.append(tr);
            });
            TblMoneda.querySelector("tbody").append(Frag);

            //Asignar eventos
            btnBuscarMoneda.addEventListener("click", BuscarMoneda);
            btnActualizar.addEventListener("click", ActualizarMoneda);
            btnMensaje.addEventListener("click", Mensaje);
            btnAgregar.addEventListener("click", AgregarMoneda);
            //final eventos
        }

        //Buscar Moneda
        const BuscarMoneda = async () => {
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "CatMainMoneda.aspx/BuscarMonedaxNombre";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Moneda: txtBuscar.value })
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((moneda) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(moneda.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(moneda.Descripcion);
                let tdSimbolo = document.createElement("td");
                tdSimbolo.append(moneda.Simbolo);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Detalle";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarMonedas'); //abrimos el modal
                    document.getElementById('txtId').value = moneda.Id;
                    document.getElementById('txtNombreMoneda').value = moneda.Descripcion;
                    document.getElementById('txtSimbologia').value = moneda.Simbolo;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdSimbolo, tdActions);
                Frag.append(tr);
            });
            TblMoneda.querySelector("tbody").append(Frag);
        }

        //Update
        const ActualizarMoneda = async () => {
            ModalFunction('ModalModificarMonedas'); //ocultamos el modal
            const url = "CatMainMoneda.aspx/ActualizarMoneda";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Id: txtId.value, Moneda: txtNombreMoneda.value, Simbolo: txtSimbologia.value })
                });
            response = await response.json();
            console.log(response);
            if (response.d == true) {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje
                document.getElementById('lblMensaje').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO';
            }
            else {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje
                document.getElementById('lblMensaje').innerHTML = 'ERROR AL ACTUALIZAR REGISTRO';
            }
        }

        //Mensaje
        const Mensaje = async () => {
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalMensaje'); //ocultamos el modal
            const url = "CatMainMoneda.aspx/CargarMonedas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((moneda) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(moneda.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(moneda.Descripcion);
                let tdSimbolo = document.createElement("td");
                tdSimbolo.append(moneda.Simbolo);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Detalle";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarMonedas');
                    document.getElementById('txtId').value = moneda.Id;
                    document.getElementById('txtNombreMoneda').value = moneda.Descripcion;
                    document.getElementById('txtSimbologia').value = moneda.Simbolo;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdSimbolo, tdActions);
                Frag.append(tr);
            });
            TblMoneda.querySelector("tbody").append(Frag);
        }

        //Agregar
        const AgregarMoneda = async () => {
            ModalFunction('ModalAgregarMonedas'); //ocultamos el modal
            const url = "CatMainMoneda.aspx/AgregarMoneda";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({Moneda: txtNombreMoneda1.value, Simbolo: txtSimbologia1.value })
                });
            response = await response.json();
            console.log(response);
            if (response.d == true) {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje
                document.getElementById('lblMensaje').innerHTML = 'REGISTRO AGREGADO CON EXITO';
            }
            else {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje
                document.getElementById('lblMensaje').innerHTML = 'ERROR AL AGREGAR REGISTRO';
            }
        }

        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="MonedaContainer">
        <div class="ModalTitle">
            CATALOGO DE MONEDAS
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscarMoneda" class="btnSuccess" value="Buscar" />
        </div>
        <div class="Content">
            <table id="TblMoneda" class="TblForm">
                <thead>
                    <tr>
                        <th>ID MONEDA</th>
                        <th>TIPO MONEDA</th>
                        <th>SIMBOLOGIA</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: center">
                <button type="button" class="btnPrimary" onclick="ModalFunction('ModalAgregarMonedas')">Agregar Moneda</button>
                <input type="button" class="btnCancel" onclick="window.location = 'Catalogos.aspx'" value="Regresar" />
            </div>
        </div>
    </div>

    <%--INICIO MODELES--%>

    <div class="Modal" id="ModalAgregarMonedas">
        <div class="ModalContent">
            <div class="ModalTitle">
                AGREGAR MONEDAS
            </div>
            <div class="ModalActions" style="text-align: center">
                <label for="TextoMoneda">
                    Moneda:
                    <input type="text" class="txtForm2" name="Type" id="txtNombreMoneda1" maxlength="15"/></label>
                <label for="TextoSimbolo">
                    Simbolo:
                    <input type="text" class="txtForm2" name="Type" id="txtSimbologia1" maxlength="3"/></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar" class="btnSuccess" value="Agregar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalAgregarMonedas')" value="Cancelar" />
            </div>
        </div>
    </div>

    <div class="Modal" id="ModalMensaje">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label id="lblMensaje"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnMensaje" class="btnSuccess" value="Aceptar" />
            </div>
        </div>
    </div>

    <div class="Modal" id="ModalModificarMonedas">
        <div class="ModalContent">
            <div class="ModalTitle">
                MODIFICAR MONEDAS
            </div>
            <div class="ModalActions" style="text-align: center">
                <label for="TextoId" style="visibility: hidden">
                    Id:
                    <input type="text" class="txtForm2" name="Type" id="txtId"/></label>
                <label for="TextoMoneda">
                    Moneda:
                    <input type="text" class="txtForm2" name="Type" id="txtNombreMoneda" maxlength="15"/></label>
                <label for="TextoSimbolo">
                    Simbolo:
                    <input type="text" class="txtForm2" name="Type" id="txtSimbologia" maxlength="3"/></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnActualizar" class="btnSuccess" value="Actualizar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalModificarMonedas')" value="Cancelar" />
            </div>
        </div>
    </div>

    <%--FIN MODELES--%>
</asp:Content>
