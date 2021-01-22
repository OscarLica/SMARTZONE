<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="MainProductos.aspx.cs" Inherits="Interface.Modulos.Productos.MainProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            const url = "MainProductos.aspx/CargarProductos";
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
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdRecibo = document.createElement("td");
                tdRecibo.append(productos.NumRecibo);
                let tdProveedor = document.createElement("td");
                tdProveedor.append(productos.Proveedor);
                let tdExcento = document.createElement("td");
                tdExcento.append(productos.Excento);
                let tdExistencia = document.createElement("td");
                tdExistencia.append(productos.CantExistencia);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Detalle";
                btnView.type = "button";
                btnView.onclick = () => {
                    location = "./MainProductosAlmacen.aspx?IdProducto=" + productos.Id;
                }
                //let btnView2 = document.createElement("input");
                //btnView2.value = "Ver";
                //btnView2.type = "button";
                //btnView2.onclick = () => {
                //    location = "./MainProductosAlmacen.aspx?IdProducto=" + productos.Id;
                //}
                tdActions.append(btnView/*,btnView2*/);
                //apends
                tr.append(tdRecibo, tdProveedor, tdExcento, tdExistencia, tdActions);
                Frag.append(tr);
            });
            TblProducto.querySelector("tbody").append(Frag);

            //Asignar eventos
            btnBuscarProductos.addEventListener("click", BuscarProducto);                    
            //final eventos
        }

        const BuscarProducto = async () => {
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "MainProductos.aspx/BuscarProductoxNombre";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Producto: txtBuscar.value }) 
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdRecibo = document.createElement("td");
                tdRecibo.append(productos.NumRecibo);
                let tdProveedor = document.createElement("td");
                tdProveedor.append(productos.Proveedor);
                let tdExcento = document.createElement("td");
                tdExcento.append(productos.Excento);
                let tdExistencia = document.createElement("td");
                tdExistencia.append(productos.CantExistencia);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Detalle";
                btnView.type = "button";
                btnView.onclick = () => {
                    location = "./MainProductosAlmacen.aspx?IdProducto=" + productos.Id;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdRecibo, tdProveedor, tdExcento, tdExistencia, tdActions);
                Frag.append(tr);
            });
            TblProducto.querySelector("tbody").append(Frag);
        }
        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ProductosContainer">
        <div class="ModalTitle">
            PRODUCTOS EN BODEGA
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscarProductos" class="btnSuccess" value="Buscar" />
        </div>
        <div class="Content">
            <table id="TblProducto" class="TblForm">
                <thead>
                    <tr>
                        <th>N° RECIBO</th>
                        <th>PROVEEDOR</th>
                        <th>EXCENTO</th>
                        <th>DISPONIBLES</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnPrimary" onclick="window.location = 'ProductosAlmacen.aspx'" value="Agregar" />
                <input type="button" class="btnCancel" onclick="window.location = 'Default.aspx'" value="Regresar" />
            </div>
        </div>
    </div>

    <%--INICIO MODELES--%>

    <div class="Modal" id="ModalProductos">
        <div class="ModalContent">
            <div class="ModalTitle">
                AGREGAR PRODUCTO
            </div>
            <div class="ModalActions">
                <label for="TxtTexto">Producto:
                    <input type="text" name="Type" id="txtDescripcion" /></label>
                <label for="TxtTexto">Almacen:
                    <input type="text" name="Type" id="txtAlmacen" /></label>
                <label for="business">
                    Categorias:
                    <select id="business" name="business">
                        <option value="1">Celular</option>
                        <option value="2">Accesorios</option>
                    </select>
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnSuccess" value="Guardar" />
                <input type="button" class="btnCancel" onclick="window.location = 'MainProductos.aspx'" value="Cancelar" />
            </div>
        </div>
    </div>

    <div class="Modal" id="ModalAgregarProductos">
        <div class="ModalContent">
            <div class="ModalTitle">
                AGREGAR PRODUCTO
            </div>
            <div class="ModalActions">
            </div>
            <div class="Content">
            </div>
        </div>
    </div>

    <div class="Modal" id="ModalModificarProductos">
        <div class="ModalContent">
            <div class="ModalTitle">
                MODIFICAR PRODUCTO
            </div>
            <div class="ModalActions">
                <label for="RadioTexto">
                    <input type="radio" name="Type" id="RadioTexto" />Texto</label>
                <label for="RadioImg">
                    <input type="radio" name="Type" id="RadioImg" />Imagen</label>
                <label for="RadioVideo">
                    <input type="radio" name="Type" id="RadioVideo" />Video</label>
                <label for="RadioPdf">
                    <input type="radio" name="Type" id="RadioPdf" />PDF</label>
            </div>
            <div class="ModalActions">
                <input type="file" value="" />
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnSuccess" value="Guardar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalModificarMonedas')" value="Cancelar" />
            </div>
        </div>
    </div>

    <%--FIN MODELES--%>
</asp:Content>

