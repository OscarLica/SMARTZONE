<%@ Page Title="REGISTRAR PRODCTOS" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="ProductosAlmacen.aspx.cs" Inherits="Interface.ProductosAlmacen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            document.getElementById("txtId").value = "0";
            //deshabilitamos el boton hasta que se haya agregado detalle
            document.getElementById("btnProcesarA").disabled = true;
            const url = "ProductosAlmacen.aspx/CargarNumRecibo";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: {
                        'Accept': 'application/json', 'Content-Type': 'application/json'
                    }
                });
            response = await response.json();
            console.log(response);
            document.getElementById('txtRecibo').value = response.d; //obtenemos el consecutivo
            //Asignar eventos
            btnAgregarDet.addEventListener("click", AgregarDetalle);
            btnAgregarProd.addEventListener("click", AgregarProducto);
            btnAgregarPro.addEventListener("click", AgregarProveedor);
            btnAgregarMod.addEventListener("click", AgregarModelo);
            btnAgregar.addEventListener("click", Agregar);
            btnAgregar2.addEventListener("click", AgregarNuevo);
            btnEliminar.addEventListener("click", EliminarDetalle);
            btnProcesarA.addEventListener("click", ProcesarA);
            btnProcesarC.addEventListener("click", ProcesarC);
            btnProcesar.addEventListener("click", Procesar);

            //final eventos
        }
        //Procesar
        const ProcesarA = async () => {
            ModalFunction('ModalProceso'); //Mostrar Mensaje   
            document.getElementById('lblMensajeProcesar').innerHTML = 'SEGURO DESEA PROCEDER ??';
            document.getElementById('txtProcesar').value = "1";
        }
        //Cancelar Proceso
        const ProcesarC = async () => {
            if (txtId.value == 0) {
                location = "MainProductos.aspx"
            }
            else {
                ModalFunction('ModalProceso'); //Mostrar Mensaje   
                document.getElementById('lblMensajeProcesar').innerHTML = 'SEGURO DESEA CANCELAR EL PROCESO??';
                document.getElementById('txtProcesar').value = "0";
            }
        }
        //Confirmar Procesar
        const Procesar = async () =>
        {
            // si txtProcesar.value == 0, cancelamos el proceso y eliminamos todo lo creado, caso contrario lo procesamos
            const url = "ProductosAlmacen.aspx/Procesar";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        idPam: txtId.value, Parametro: txtProcesar.value
                    })
                });
            response = await response.json();
            console.log(response);

            location = "MainProductos.aspx";
        }
        //AgregarNuevo
        const AgregarNuevo = async () => {
            ModalFunction('ModalMensaje1'); //Mostrar Mensaje 
                const url = "ProductosAlmacen.aspx/CargarNumProducto";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: {
                            'Accept': 'application/json', 'Content-Type': 'application/json'
                        }
                    });
                response = await response.json();
                console.log(response);
                document.getElementById('txtCodProducto').value = response.d; //obtenemos el consecutivo prod
                //document.getElementById('txtImei').value = response.d.IMEI; //obtenemos el consecutivo imei   
                //document.getElementById('txtImeiconsecutivo').value = response.d.IMEI; //obtenemos el consecutivo imei   
                ModalFunction('ModalAgregarDetalle'); //Mostrar el modal             
        }
        //AgregarDetalle
        const AgregarDetalle = async () => {
            document.getElementById("txtProducto").value = "";
            document.getElementById("txtModelo").value = "";
            document.getElementById("txtImei").value = "";
            document.getElementById("txtSerie").value = "";
            document.getElementById("txtPrecioCompra").value = "0";
            document.getElementById('lblMensaje1').innerHTML = '';
            document.getElementById('txtEspecificaciones').value = '';

            if (txtProveedor.value == "") {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                document.getElementById('lblMensaje').innerHTML = 'DEBE INGRESAR UN PROVEEDOR';
            }
            else {
                const url = "ProductosAlmacen.aspx/CargarNumProducto";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: {
                            'Accept': 'application/json', 'Content-Type': 'application/json'
                        }
                    });
                response = await response.json();
                console.log(response);
                document.getElementById('txtCodProducto').value = response.d; //obtenemos el consecutivo prod
                //document.getElementById('txtImei').value = response.d.IMEI; //obtenemos el consecutivo imei   
                //document.getElementById('txtImeiconsecutivo').value = response.d.IMEI; //obtenemos el consecutivo imei   
                ModalFunction('ModalAgregarDetalle'); //Mostrar el modal
            }
        }
        //Agregar a tabla
        const Agregar = async () => {
            if (txtProducto.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRODUCTO';
            }
            else if (txtModelo.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL MODELO';
            }
            else if (txtPrecioCompra.value == "" || txtPrecioCompra.value == "0") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRECIO DE LA COMPRA';
            }
            else if (txtIdCategoria.value != 2 && txtSerie.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL N° SERIE';
            }
            else if (txtIdCategoria.value != 2 && txtImei.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL IMEI';
            }
            else {
                //validamos la serie y el imei que no existan, ya que deben ser unicos
                if (txtIdCategoria.value != 2) {
                    const url = "ProductosAlmacen.aspx/ValidarSerieImei";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                Serie: txtSerie.value, Imei: txtImei.value
                            })
                        });
                    response = await response.json();
                    console.log(response);

                    if (response.d == true) {
                        document.getElementById('lblMensaje1').innerHTML = 'SERIE ó IMEI YA EXISTE';
                    }
                    else {
                        var parametro = false;
                        //const parametro = true;
                        if (document.getElementById('Excento').checked) //tiene q pagar iva
                        {
                            parametro = false;
                        }
                        else if (document.getElementById('NoExcento').checked) //no pagara iva
                        {
                            parametro = true;
                        }
                        ModalFunction('ModalAgregarDetalle'); //ocultamos el modal
                        document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                        const url = "ProductosAlmacen.aspx/GuardarProducto";
                        let response = await fetch(
                            url, {
                                method: "POST",
                                headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                                body: JSON.stringify({
                                    Id: txtId.value, IdProveedor: txtIdProveedor.value, NumRec: txtRecibo.value, Excento: parametro, IdModelo: txtIdModelo.value, CodProd: txtCodProducto.value, Serie: txtSerie.value, IMEI: txtImei.value, PrecioC: txtPrecioCompra.value
                                })
                            });
                        response = await response.json();
                        console.log(response);
                        let Frag = document.createDocumentFragment();
                        response.d.forEach((productos) => {
                            let tr = document.createElement("tr");
                            let tdCodProd = document.createElement("td");
                            tdCodProd.append(productos.CodProducto);
                            let tdModelo = document.createElement("td");
                            tdModelo.append(productos.Modelo);
                            let tdSerie = document.createElement("td");
                            tdSerie.append(productos.Serie);
                            let tdImei = document.createElement("td");
                            tdImei.append(productos.IMEI);
                            let tdPrecioC = document.createElement("td");
                            tdPrecioC.append(productos.PrecioC);
                            //actions
                            let tdActions = document.createElement("td");
                            let btnView = document.createElement("input");
                            btnView.value = "-";
                            btnView.type = "button";
                            btnView.onclick = () => {
                                document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                                ModalFunction('ModalEliminar');
                                document.getElementById('txtIdEliminar').value = productos.Id;
                            }
                            tdActions.append(btnView);
                            //apends
                            //obtenemos el id de producto
                            document.getElementById('txtId').value = productos.IdProductosAlmacen;
                            //obtenemos el SubTotal, Iva y Total
                            document.getElementById('txtSubTotal').value = productos.SubTotal;
                            document.getElementById('txtIva').value = productos.Iva;
                            document.getElementById('txtTotal').value = productos.Total;

                            tr.append(tdActions,tdCodProd, tdModelo, tdSerie, tdImei, tdPrecioC);
                            Frag.append(tr);
                        });
                        TblDetalle.querySelector("tbody").append(Frag);

                        //habilitamos el boton hasta que se haya agregado detalle
                        document.getElementById("btnProcesarA").disabled = false;
                        ModalFunction('ModalMensaje1'); //Mostrar Mensaje               
                        document.getElementById('lblMensaje2').innerHTML = 'REGISTRO AGREGADO CON EXITO, DESEA AGREGAR NUEVO PRODUCTO ?';

                        //limpiamos las cajas de texto
                        document.getElementById("txtProducto").value = "";
                        document.getElementById("txtModelo").value = "";
                        document.getElementById("txtImei").value = "";
                        document.getElementById("txtSerie").value = "";
                        document.getElementById("txtPrecioCompra").value = "0";
                    }
                }
                else {
                    var parametro = false;
                    //const parametro = true;
                    if (document.getElementById('Excento').checked) //tiene q pagar iva
                    {
                        parametro = false;
                    }
                    else if (document.getElementById('NoExcento').checked) //no pagara iva
                    {
                        parametro = true;
                    }
                    ModalFunction('ModalAgregarDetalle'); //ocultamos el modal
                    document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                    const url = "ProductosAlmacen.aspx/GuardarProducto";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                Id: txtId.value, IdProveedor: txtIdProveedor.value, NumRec: txtRecibo.value, Excento: parametro, IdModelo: txtIdModelo.value, CodProd: txtCodProducto.value, Serie: txtSerie.value, IMEI: txtImei.value, PrecioC: txtPrecioCompra.value
                            })
                        });
                    response = await response.json();
                    console.log(response);
                    let Frag = document.createDocumentFragment();
                    response.d.forEach((productos) => {
                        let tr = document.createElement("tr");
                        let tdCodProd = document.createElement("td");
                        tdCodProd.append(productos.CodProducto);
                        let tdModelo = document.createElement("td");
                        tdModelo.append(productos.Modelo);
                        let tdSerie = document.createElement("td");
                        tdSerie.append(productos.Serie);
                        let tdImei = document.createElement("td");
                        tdImei.append(productos.IMEI);
                        let tdPrecioC = document.createElement("td");
                        tdPrecioC.append(productos.PrecioC);
                        //actions
                        let tdActions = document.createElement("td");
                        let btnView = document.createElement("input");
                        btnView.value = "-";
                        btnView.type = "button";
                        btnView.onclick = () => {
                            document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                            ModalFunction('ModalEliminar');
                            document.getElementById('txtIdEliminar').value = productos.Id;
                        }
                        tdActions.append(btnView);
                        //apends
                        //obtenemos el id de producto
                        document.getElementById('txtId').value = productos.IdProductosAlmacen;
                        //obtenemos el SubTotal, Iva y Total
                        document.getElementById('txtSubTotal').value = productos.SubTotal;
                        document.getElementById('txtIva').value = productos.Iva;
                        document.getElementById('txtTotal').value = productos.Total;

                        tr.append(tdActions, tdCodProd, tdModelo, tdSerie, tdImei, tdPrecioC);
                        Frag.append(tr);
                    });
                    TblDetalle.querySelector("tbody").append(Frag);

                    //habilitamos el boton hasta que se haya agregado detalle
                    document.getElementById("btnProcesarA").disabled = false;
                    ModalFunction('ModalMensaje1'); //Mostrar Mensaje               
                    document.getElementById('lblMensaje2').innerHTML = 'REGISTRO AGREGADO CON EXITO, DESEA AGREGAR NUEVO PRODUCTO ?';

                    //limpiamos las cajas de texto
                    document.getElementById("txtProducto").value = "";
                    document.getElementById("txtModelo").value = "";
                    document.getElementById("txtImei").value = "";
                    document.getElementById("txtSerie").value = "";
                    document.getElementById("txtPrecioCompra").value = "0";
                }
            }
        }
        //Agregar Prodcuto
        const AgregarProducto = async () => {
            document.getElementById('lblMensaje1').innerHTML = '';
            document.getElementById('CuerpoProd').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalProductos'); //ocultamos el modal
            const url = "ProductosAlmacen.aspx/ListarProductos";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(productos.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(productos.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {                    
                    ModalFunction('ModalProductos');                                   
                    document.getElementById('txtIdProducto').value = productos.Id;
                    document.getElementById('txtProducto').value = productos.Descripcion;
                    document.getElementById('txtIdCategoria').value = productos.IdCategoria;
                    if (productos.IdCategoria == 2) {
                        txtImei.value = "";
                        document.getElementById('txtEspecificaciones').value = '';
                        document.getElementById("txtModelo").value = "";
                    }
                    else
                    {
                        txtImei.value = "";
                        document.getElementById('txtEspecificaciones').value = '';
                        document.getElementById("txtModelo").value = "";
                    }
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatProductos.querySelector("tbody").append(Frag);
        }
        //Agregar Proveedor
        const AgregarProveedor = async () => {
            document.getElementById('CuerpoPro').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalProveedor'); //ocultamos el modal
            const url = "ProductosAlmacen.aspx/ListarProveedor";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((proveedor) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(proveedor.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(proveedor.Descripcion);
                let tdRuc = document.createElement("td");
                tdRuc.append(proveedor.RUC);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalProveedor');
                    document.getElementById('txtIdProveedor').value = proveedor.Id;
                    document.getElementById('txtProveedor').value = proveedor.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdRuc, tdActions);
                Frag.append(tr);
            });
            TblCatProveedor.querySelector("tbody").append(Frag);
        }
        //Agregar Modelo
        const AgregarModelo = async () => {
            if (txtProducto.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRODUCTO';
            }
            else {
                document.getElementById('lblMensaje1').innerHTML = '';
                document.getElementById('CuerpoMod').innerHTML = ''; //Aqui limpiamos el la grid
                ModalFunction('ModalModelo'); //ocultamos el modal
                const url = "ProductosAlmacen.aspx/ListarModelos";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            IdProducto: txtIdProducto.value,
                        })
                    });
                response = await response.json();
                console.log(response);
                let Frag = document.createDocumentFragment();
                response.d.forEach((modelos) => {
                    let tr = document.createElement("tr");
                    //let tdId = document.createElement("td");
                    //tdId.append(modelos.Id);
                    let tdDescripcion = document.createElement("td");
                    tdDescripcion.append(modelos.Descripcion);
                    let tdEspecificaciones = document.createElement("td");
                    tdEspecificaciones.append(modelos.Especificaciones);
                    //actions
                    let tdActions = document.createElement("td");
                    let btnView = document.createElement("input");
                    btnView.value = "Agregar";
                    btnView.type = "button";
                    btnView.onclick = () => {
                        ModalFunction('ModalModelo');
                        document.getElementById('txtIdModelo').value = modelos.Id;
                        document.getElementById('txtModelo').value = modelos.Descripcion;
                        document.getElementById('txtEspecificaciones').value = modelos.Especificaciones; 
                    }
                    tdActions.append(btnView);
                    //apends
                    tr.append(tdDescripcion, tdEspecificaciones, tdActions);
                    Frag.append(tr);
                });
                TblCatModelos.querySelector("tbody").append(Frag);
            }
        }
        //Eliminar Detalle
        const EliminarDetalle = async () => {
            ModalFunction('ModalEliminar'); //Mostrar/ocultar Mensaje       
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "ProductosAlmacen.aspx/EliminarDetalle";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        idPam: txtId.value, IdDet: txtIdEliminar.value
                    })
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdCodProd = document.createElement("td");
                tdCodProd.append(productos.CodProducto);
                let tdModelo = document.createElement("td");
                tdModelo.append(productos.Modelo);
                let tdSerie = document.createElement("td");
                tdSerie.append(productos.Serie);
                let tdImei = document.createElement("td");
                tdImei.append(productos.IMEI);
                let tdPrecioC = document.createElement("td");
                tdPrecioC.append(productos.PrecioC);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "-";
                btnView.type = "button";
                btnView.onclick = () => {
                    document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = productos.Id;
                }
                tdActions.append(btnView);
                //apends
                //obtenemos el id de producto
                document.getElementById('txtId').value = productos.IdProductosAlmacen;
                //obtenemos el SubTotal, Iva y Total
                document.getElementById('txtSubTotal').value = productos.SubTotal;
                document.getElementById('txtIva').value = productos.Iva;
                document.getElementById('txtTotal').value = productos.Total;

                tr.append(tdCodProd, tdModelo, tdSerie, tdImei, tdPrecioC, tdActions);
                Frag.append(tr);
            });
            TblDetalle.querySelector("tbody").append(Frag);
        }

        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%--MAESTRO--%>
    <div class="GroupDiv" id="ProductoContainer">
        <div class="ModalTitle">
            REGISTRAR PRODUCTOS NUEVOS
        </div>
        <div class="ModalActions" style="display: inline-flex; text-align: center">
            <label for="TextoRecibo">N° Recibo:<input type="text" class="txtForm1" name="Type" id="txtRecibo" readonly="readonly" /></label>
            <label for="TextoProveedor">
                Proveedor:<input type="text" class="txtForm1" name="Type" id="txtProveedor" readonly="readonly" />
                <input type="button" id="btnAgregarPro" class="btnSuccess" value="+" />
            </label>
            <label for="RadioTexto">Excento del IVA:   SI<input type="radio" name="Type" id="Excento" value="True" />NO<input type="radio" name="Type" id="NoExcento" checked value="False" /></label>
        </div>
        <div>
            <label for="TextoIdProveedor" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdProveedor" /></label>
            <label for="TextoIdProductosAlmacen" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtId" /></label>
        </div>
    </div>
    <%--DETALLE--%>
    <div class="GroupDiv" id="ProductosDetalle">
        <div class="ModalActions">
            <input type="button" id="btnAgregarDet" class="btnSuccess" value="Agregar Productos" />
        </div>
        <div class="ModalTitle">
            DETALLE DE PRODUCTOS
        </div>
        <div class="Content">
            <table id="TblDetalle" class="TblForm">
                <thead>
                    <tr>
                        <th>OPCION</th>
                        <th>COD. PRODUCTO</th>
                        <th>MODELO</th>
                        <th>SERIE</th>
                        <th>IMEI</th>
                        <th>PRECIO COMPRA</th>                        
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
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnProcesarA" class="btnSuccess" value="PROCESAR PRODUCTOS" />
                <input type="button" id="btnProcesarC" class="btnCancel" value="CANCELAR PROCESO" />
            </div>
        </div>
    </div>
    <%--INICIO MODELES--%>
    <div class="Modal" id="ModalMensaje">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label id="lblMensaje"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalMensaje')" value="Aceptar" />
            </div>
        </div>
    </div>
    <%--MENSAJE DE GUARDAR NUEVAMENTE--%>
    <div class="Modal" id="ModalMensaje1">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensaje2"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar2" class="btnSuccess" value="Agregar Nuevo" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalMensaje1')" value="Cerrar" />
            </div>
        </div>
    </div>
    <%--ELIMINAR REGISTRO--%>
    <div class="Modal" id="ModalEliminar">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensajeEliminar"></label>
                <label for="TextoIdEliminar" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdEliminar" /></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnEliminar" class="btnSuccess" value="Eliminar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalEliminar')" value="Cancelar" />
            </div>
        </div>
    </div>
    <%--AGREGAR DETALLE--%>
    <div class="Modal" id="ModalAgregarDetalle">
        <div class="ModalContent">
            <div class="ModalTitle">
                AGREGAR PRODUCTO
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje1" id="lblMensaje1"></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoArticulo">Cod. Producto:<input type="text" class="txtForm1" name="Type" id="txtCodProducto" readonly="readonly" /></label>
                <label for="TextoProducto">
                    Producto:<input type="text" class="txtForm1" name="Type" id="txtProducto" readonly="readonly" />
                    <input type="button" id="btnAgregarProd" class="btnSuccess" value="+" />
                </label>
                <label for="TextoImei">N° Imei:<input type="text" class="txtForm1" name="Type" id="txtImei" maxlength="30" /></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoSerie">Codg. de Serie:<input type="text" class="txtForm1" name="Type" id="txtSerie" maxlength="30" /></label>
                <label for="TextoModelo">
                    Modelos:<input type="text" class="txtForm1" name="Type" id="txtModelo" readonly="readonly" />
                    <input type="button" id="btnAgregarMod" class="btnSuccess" value="+" />
                </label>
                <label for="TextoPrecio">Precio:<input type="number" class="txtForm1" name="Type" id="txtPrecioCompra" min="1" /></label>
            </div>
            <div class="ModalActions" style=" text-align: center">
                <label for="TextoCaracteristicas">
                    <label>Caracteristicas</label>
                    <textarea id="txtEspecificaciones" class="txtEspecificaciones" name="Caracteristicas" readonly="readonly"></textarea>
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar" class="btnSuccess" value="Agregar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalAgregarDetalle')" value="Cancelar" />
                <label for="TextoIdProducto" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdProducto" /></label>
                <label for="TextoIdModelo" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdModelo" /></label>
                <label for="TextoIdCategoria" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdCategoria" /></label>
<%--                <label for="TextoImei" style="visibility: hidden">imei:<input type="text" class="txtForm2" name="Type" id="txtImeiconsecutivo" /></label>--%>
            </div>
        </div>
    </div>
    <%--CAT PRODUCTOS--%>
    <div class="Modal" id="ModalProductos">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO PRODUCTOS
            </div>
            <div class="Content">
                <table id="TblCatProductos" class="TblForm">
                    <thead>
                        <tr>
                            <th>ID PRODUCTOS</th>
                            <th>DESCRIPCION</th>
                            <th>OPCIONES</th>
                        </tr>
                    </thead>
                    <tbody id="CuerpoProd">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalProductos')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>
    <%--CAT PROVEEDOR--%>
    <div class="Modal" id="ModalProveedor">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO PROVEEDORES
            </div>
            <div class="Content">
                <table id="TblCatProveedor" class="TblForm">
                    <thead>
                        <tr>
                            <th>ID CATEGORIA</th>
                            <th>DESCRIPCION</th>
                            <th>RUC</th>
                            <th>OPCIONES</th>
                        </tr>
                    </thead>
                    <tbody id="CuerpoPro">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalProveedor')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>
    <%--CAT MODELO--%>
    <div class="Modal" id="ModalModelo">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO MODELOS
            </div>
            <div class="Content">
                <div id="Scroll2">
                    <table id="TblCatModelos" class="TblForm">
                        <thead>
                            <tr>
<%--                                <th>ID MODELO</th>--%>
                                <th>DESCRIPCION</th>
                                <th>CARACTERISTICAS</th>
                                <th>OPCIONES</th>
                            </tr>
                        </thead>
                        <tbody id="CuerpoMod">
                        </tbody>
                    </table>
                </div>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalModelo')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>

    <div class="Modal" id="ModalProceso">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensajeProcesar"></label>
                <label for="TextoProcesar" style="visibility: hidden">Procesar:<input type="text" class="txtForm2" name="Type" id="txtProcesar" /></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnProcesar" class="btnSuccess" value="Aceptar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalProceso')" value="Cancelar" />
            </div>
        </div>
    </div>

</asp:Content>
