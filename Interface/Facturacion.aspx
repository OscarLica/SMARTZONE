<%@ Page Title="Facturacion" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Facturacion.aspx.cs" Inherits="Interface.Facturacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            document.getElementById("txtId").value = "0";
            document.getElementById("txtRUC").value = "JP16075900";
            //deshabilitamos los botones hasta que se haya agregado detalle
            document.getElementById("btnProcesarA").disabled = true;
            document.getElementById("btnCalcular").disabled = true;
            const url = "Facturacion.aspx/CargarNumFacFecha";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: {
                        'Accept': 'application/json', 'Content-Type': 'application/json'
                    }
                });
            response = await response.json();
            console.log(response);
            document.getElementById('txtNumFactura').value = response.d.CodFac; //obtenemos el consecutivo
            document.getElementById('txtFecha').value = response.d.FechaFac; //obtenemos el consecutivo
            var d = new Date();
            d.setDate(15);
            document.getElementById("txtFecha").innerHTML = d;

            //Asignar eventos
            btnAgregarDet.addEventListener("click", AgregarDetalle);
            btnBuscarModelos.addEventListener("click", BuscarModelo);
            btnAgregarMod.addEventListener("click", AgregarModelo);
            btnAgregar.addEventListener("click", Agregar);
            btnAgregar2.addEventListener("click", AgregarNuevo);
            btnEliminar.addEventListener("click", EliminarDetalle);
            btnProcesarA.addEventListener("click", ProcesarA);
            btnProcesarC.addEventListener("click", ProcesarC);
            btnProcesar.addEventListener("click", Procesar);
            btnCalcular.addEventListener("click", Calcular);
            btnModificar.addEventListener("click", Modificar);
            //final eventos
            cargar_descuentos(); //cargamos la lista de los descuentos
            cargar_descuentos2(); //cargamos la lista de los descuentos
        }
        ////AgregarDetalle
        const AgregarDetalle = async () => {
            document.getElementById("txtProducto").value = "";
            document.getElementById("txtModelo").value = "";
            document.getElementById("txtPrecioUnitario").value = "0";
            document.getElementById("txtCantidad").value = "0";
            document.getElementById("txtGarantia").value = "0";
            document.getElementById('lblMensaje1').innerHTML = '';
            document.getElementById("txtCambio").value = '';
            document.getElementById("txtEfectivo").value = '';
            //cargar_descuentos();
            if (txtDatosCliente.value == "") {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                document.getElementById('lblMensaje').innerHTML = 'FAVOR AGREGAR DATOS DEL CLIENTE';
            }
            else {
                ModalFunction('ModalAgregarDetalle'); //Mostrar el modal
                const url = "Facturacion.aspx/ListarProductos";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                    });
                response = await response.json();
                console.log(response);
                //se cargara solo una vez
                if (document.getElementById("txtProducto").options.length == 1) {
                    addOptionsP("ListaProductos", response.d);
                }
                else {
                    document.getElementById("txtProducto").value = "Seleccione un Producto";
                }
            }
        }
        ////Agregar Modelo/Articulo
        const AgregarModelo = async () => {
            document.getElementById('txtBuscar').innerHTML = '';
            if (txtProducto.value == "" || txtProducto.value == "Seleccione un Producto") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE SELECCIONAR EL PRODUCTO';
            }
            else {
                document.getElementById("txtCantidad").value = "0";
                document.getElementById('lblMensaje1').innerHTML = '';
                document.getElementById('CuerpoMod').innerHTML = ''; //Aqui limpiamos la grid
                ModalFunction('ModalModelo'); //ocultamos el modal
                const url = "Facturacion.aspx/ListarModelos";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            IdProducto: txtProducto.value,
                        })
                    });
                response = await response.json();
                console.log(response);
                let Frag = document.createDocumentFragment();
                response.d.forEach((modelos) => {
                    let tr = document.createElement("tr");
                    let tdId = document.createElement("td");
                    tdId.append(modelos.Id);
                    let tdDescripcion = document.createElement("td");
                    tdDescripcion.append(modelos.Descripcion);
                    let tdEspecificaciones = document.createElement("td");
                    tdEspecificaciones.append(modelos.Especificaciones);
                    let tdExistencia = document.createElement("td");
                    tdExistencia.append(modelos.cantidadExistencia);
                    let tdPrecio = document.createElement("td");
                    tdPrecio.append(modelos.Precio);
                    //actions
                    let tdActions = document.createElement("td");
                    let btnView = document.createElement("input");
                    btnView.value = "Agregar";
                    btnView.type = "button";
                    btnView.onclick = () => {
                        ModalFunction('ModalModelo');
                        document.getElementById('txtIdProdet').value = modelos.Id;
                        document.getElementById('txtIdProducto').value = modelos.IdProducto;
                        document.getElementById('txtIdModelo').value = modelos.IdModelo;
                        document.getElementById('txtModelo').value = modelos.Descripcion;
                        document.getElementById('txtPrecioUnitario').value = modelos.Precio;
                        document.getElementById('txtIdCategoria').value = modelos.IdCategoria; //oculta la usamos para validar los accesorios
                        document.getElementById('txtExistencia').value = modelos.cantidadExistencia; //variable oculta para saber cuantos accesorios hay en existencia
                        if (modelos.IdCategoria == 1) { //celulares 90dias
                            document.getElementById("txtGarantia").value = "90";
                            document.getElementById("txtCantidad").value = "1"; //cuando son celular o tablet se debe agregar uno a uno por el imei/serie
                            document.getElementById("txtCantidad").readOnly = true;
                        }
                        else if (modelos.IdCategoria == 2) { //accesorios 30dias
                            document.getElementById("txtGarantia").value = "30";
                            document.getElementById("txtCantidad").readOnly = false;
                        }
                        else { //tabletas 60dias
                            document.getElementById("txtGarantia").value = "60";
                            document.getElementById("txtCantidad").value = "1"; //cuando son celular o tablet se debe agregar uno a uno por el imei/serie
                            document.getElementById("txtCantidad").readOnly = true;
                        }
                    }
                    tdActions.append(btnView);
                    //apends
                    tr.append(tdId, tdDescripcion, tdEspecificaciones, tdExistencia, tdPrecio, tdActions);
                    Frag.append(tr);
                });
                TblCatModelos.querySelector("tbody").append(Frag);
            }
        }
        ////Agregar a tabla
        const Agregar = async () => {
            var Existencia = 0;
            var Cantidad = parseInt(txtCantidad.value);

            if (txtProducto.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRODUCTO';
            }
            else if (txtModelo.value == "") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL ARTICULO';
            }
            else if (txtPrecioUnitario.value == "" || txtPrecioUnitario.value == "0") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRECIO UNITARIO';
            }
            else if (txtCantidad.value == "" || txtCantidad.value == "0") {
                document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR LA CANTIDAD A AGREGAR';
            }
            else if (txtCantidad.value < 1) {
                document.getElementById('lblMensaje1').innerHTML = 'CANTIDAD DEBE SER MAYOR A 1';
            }
            else {
                if (txtIdCategoria.value == 2) {
                    const url = "Facturacion.aspx/ValidarExistencia";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                IdModelo: txtIdModelo.value
                            })
                        });
                    response = await response.json();
                    console.log(response);
                    Existencia = response.d;

                    if (Existencia < Cantidad) {
                        document.getElementById('lblMensaje1').innerHTML = 'CANTIDAD DEBE SER MENOR O IGUAL A LA EXISTENCIA';
                    }
                    else {
                        ModalFunction('ModalAgregarDetalle'); //ocultamos el modal
                        document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos la grid
                        const url = "Facturacion.aspx/GuardarProducto";
                        let response = await fetch(
                            url, {
                                method: "POST",
                                headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                                body: JSON.stringify({
                                    Id: txtId.value, CodFactura: txtNumFactura.value, DatosCliente: txtDatosCliente.value, IdProAlmacenDet: txtIdProdet.value,
                                    Cantidad: txtCantidad.value, Descuento: txtDescuento.value, Precio: txtPrecioUnitario.value, DiasGarantia: txtGarantia.value
                                })
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
                            //actions
                            let tdActions = document.createElement("td");
                            let btnView = document.createElement("input");
                            btnView.value = "Del";
                            btnView.type = "button";
                            btnView.onclick = () => {
                                document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                                ModalFunction('ModalEliminar');
                                document.getElementById('txtIdEliminar').value = productos.Id;
                                document.getElementById('txtCantEliminar').value = productos.Cantidad;
                            }
                            let btnView2 = document.createElement("input");
                            btnView2.value = "Edit";
                            btnView2.type = "button";
                            btnView2.onclick = () => {
                                ModalFunction('ModalEditarDetalle');
                                document.getElementById("txtProducto2").disabled = true;
                                document.getElementById('txtProducto2').value = productos.DescProducto;
                                document.getElementById("txtModelo2").disabled = true;
                                document.getElementById('txtModelo2').value = productos.DescModelo; 
                                document.getElementById('txtGarantia2').value = productos.GarantiaDias; 
                                document.getElementById('txtCantidad2').value = productos.Cantidad; 
                                document.getElementById('txtDescuento2').value = productos.Descuento; 
                                document.getElementById('txtPrecioUnitario2').value = productos.PrecioxUnd; 
                                document.getElementById('txtIdModelo2').value = productos.IdModelo; 
                                document.getElementById('txtIdCategoria2').value = productos.IdCategoria; 
                                document.getElementById('txtIdProducto2').value = productos.IdProducto; 
                                document.getElementById('txtIdProdet2').value = productos.IdDetalleProductosAlmacen;
                                document.getElementById('txtExistencia2').value = productos.EnExistencia;
                                document.getElementById('txtIdDetFact').value = productos.IdDetFactura;
                                if (productos.IdCategoria != 2) {
                                    document.getElementById("txtCantidad2").disabled = true;//bloqueado
                                }
                                else {
                                    document.getElementById("txtCantidad2").disabled = false; //habilitado
                                }
                            }
                            tdActions.append(btnView, btnView2);
                            //apends
                            //obtenemos el id de factura
                            document.getElementById('txtId').value = productos.IdFactura;
                            //obtenemos el SubTotal, Iva y Total
                            document.getElementById('txtSubTotal').value = productos.SubTotal;
                            document.getElementById('txtIva').value = productos.Iva;
                            document.getElementById('txtTotal').value = productos.Total2;

                            tr.append(tdActions, tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                            Frag.append(tr);
                        });
                        TblDetalle.querySelector("tbody").append(Frag);

                        //habilitamos los botones hasta que se haya agregado detalle
                        document.getElementById("btnProcesarA").disabled = false;
                        document.getElementById("btnCalcular").disabled = false;
                        ModalFunction('ModalMensaje1'); //Mostrar Mensaje               
                        document.getElementById('lblMensaje2').innerHTML = 'REGISTRO AGREGADO CON EXITO, DESEA AGREGAR NUEVO PRODUCTO ?';

                        //limpiamos las cajas de texto
                        document.getElementById("txtProducto").value = "";
                        document.getElementById("txtModelo").value = "";
                        document.getElementById("txtDescuento").value = "0";
                        document.getElementById("txtPrecioUnitario").value = "0";
                        document.getElementById("txtCantidad").value = "0";
                        document.getElementById("txtGarantia").value = "0";
                    }
                }
                else {
                    ModalFunction('ModalAgregarDetalle'); //ocultamos el modal
                    document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos la grid
                    const url = "Facturacion.aspx/GuardarProducto";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                Id: txtId.value, /*IdMoneda: txtidMoneda.value,*/ CodFactura: txtNumFactura.value, DatosCliente: txtDatosCliente.value, IdProAlmacenDet: txtIdProdet.value,
                                Cantidad: txtCantidad.value, Descuento: txtDescuento.value, Precio: txtPrecioUnitario.value, DiasGarantia: txtGarantia.value
                            })
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
                        //actions
                        let tdActions = document.createElement("td");
                        let btnView = document.createElement("input");
                        btnView.value = "Del";
                        btnView.type = "button";
                        btnView.onclick = () => {
                            document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                            ModalFunction('ModalEliminar');
                            document.getElementById('txtIdEliminar').value = productos.Id;
                            document.getElementById('txtCantEliminar').value = productos.Cantidad;
                        }
                        let btnView2 = document.createElement("input");
                        btnView2.value = "Edit";
                        btnView2.type = "button";
                            btnView2.onclick = () => {
                                ModalFunction('ModalEditarDetalle');
                                document.getElementById("txtProducto2").disabled = true;
                                document.getElementById('txtProducto2').value = productos.DescProducto;
                                document.getElementById("txtModelo2").disabled = true;
                                document.getElementById('txtModelo2').value = productos.DescModelo; 
                                document.getElementById('txtGarantia2').value = productos.GarantiaDias; 
                                document.getElementById('txtCantidad2').value = productos.Cantidad; 
                                document.getElementById('txtDescuento2').value = productos.Descuento; 
                                document.getElementById('txtPrecioUnitario2').value = productos.PrecioxUnd; 
                                document.getElementById('txtIdModelo2').value = productos.IdModelo; 
                                document.getElementById('txtIdCategoria2').value = productos.IdCategoria; 
                                document.getElementById('txtIdProducto2').value = productos.IdProducto; 
                                document.getElementById('txtIdProdet2').value = productos.IdDetalleProductosAlmacen; 
                                document.getElementById('txtExistencia2').value = productos.EnExistencia; 
                                document.getElementById('txtIdDetFact').value = productos.IdDetFactura;
                                if (productos.IdCategoria != 2) {
                                    document.getElementById("txtCantidad2").disabled = true;//bloqueado
                                }
                                else {
                                    document.getElementById("txtCantidad2").disabled = false; //habilitado
                                }
                            }
                        tdActions.append(btnView, btnView2);
                        //apends
                        //obtenemos el id de factura
                        document.getElementById('txtId').value = productos.IdFactura;
                        //obtenemos el SubTotal, Iva y Total
                        document.getElementById('txtSubTotal').value = productos.SubTotal;
                        document.getElementById('txtIva').value = productos.Iva;
                        document.getElementById('txtTotal').value = productos.Total2;

                        tr.append(tdActions, tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                        Frag.append(tr);
                    });
                    TblDetalle.querySelector("tbody").append(Frag);

                    //habilitamos los botones hasta que se haya agregado detalle
                    document.getElementById("btnProcesarA").disabled = false;
                    document.getElementById("btnCalcular").disabled = false;
                    ModalFunction('ModalMensaje1'); //Mostrar Mensaje               
                    document.getElementById('lblMensaje2').innerHTML = 'REGISTRO AGREGADO CON EXITO, DESEA AGREGAR NUEVO PRODUCTO ?';

                    //limpiamos las cajas de texto
                    document.getElementById("txtProducto").value = "";
                    document.getElementById("txtModelo").value = "";
                    document.getElementById("txtDescuento").value = "0";
                    document.getElementById("txtPrecioUnitario").value = "0";
                    document.getElementById("txtCantidad").value = "0";
                    document.getElementById("txtGarantia").value = "0";
                }
            }
        }
        //Procesar
        const ProcesarA = async () => {
            if (txtEfectivo.value == "" || txtEfectivo.value == "0") {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                document.getElementById('lblMensaje').innerHTML = 'FAVOR INGRESAR EL MONTO A PAGAR';
                document.getElementById("txtCambio").value = '';
            }
            else {
                ModalFunction('ModalProceso'); //Mostrar Mensaje   
                document.getElementById('lblMensajeProcesar').innerHTML = 'SEGURO DESEA FACTURAR ??';
                document.getElementById('txtProcesar').value = "1";
            }
        }
        ////Cancelar Proceso
        const ProcesarC = async () => {
            if (txtId.value == 0) {
                location = "MainFacturacion.aspx"
            }
            else {
                ModalFunction('ModalProceso'); //Mostrar Mensaje   
                document.getElementById('lblMensajeProcesar').innerHTML = 'SEGURO DESEA CANCELAR EL PROCESO??';
                document.getElementById('txtProcesar').value = "0";
            }
        }
        ////Confirmar Procesar
        const Procesar = async () => {
            // si txtProcesar.value == 0, cancelamos el proceso y eliminamos todo lo creado, caso contrario lo procesamos
            const url = "Facturacion.aspx/Procesar";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        idPam: txtId.value, Parametro: txtProcesar.value, Efectivo: txtEfectivo.value, Vuelto: txtCambio.value
                    })
                });
            response = await response.json();
            console.log(response);

            location = "MainFacturacion.aspx";
        }
        ////AgregarNuevo
        const AgregarNuevo = async () => {
            document.getElementById("txtProducto").value = "";
            document.getElementById("txtModelo").value = "";
            document.getElementById("txtPrecioUnitario").value = "0";
            document.getElementById("txtCantidad").value = "0";
            document.getElementById("txtGarantia").value = "0";
            document.getElementById('lblMensaje1').innerHTML = '';

            ModalFunction('ModalMensaje1'); //Mostrar Mensaje 
                ModalFunction('ModalAgregarDetalle'); //Mostrar el modal
                const url = "Facturacion.aspx/ListarProductos";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                    });
                response = await response.json();
                console.log(response);
                //se cargara solo una vez
                if (document.getElementById("txtProducto").options.length == 1) {
                    addOptionsP("ListaProductos", response.d);
                }
                else {
                    document.getElementById("txtProducto").value = "Seleccione un Producto";
                }
        }
        ////Eliminar Detalle
        const EliminarDetalle = async () => {
            ModalFunction('ModalEliminar'); //Mostrar/ocultar Mensaje       
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "Facturacion.aspx/EliminarDetalle";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        idPam: txtId.value, IdDet: txtIdEliminar.value, Cant: txtCantEliminar.value
                    })
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
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Del";
                btnView.type = "button";
                btnView.onclick = () => {
                    document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = productos.Id;
                    document.getElementById('txtCantEliminar').value = productos.Cantidad;
                }
                let btnView2 = document.createElement("input");
                btnView2.value = "Edit";
                btnView2.type = "button";
                btnView2.onclick = () => {
                    ModalFunction('ModalEditarDetalle');
                    document.getElementById("txtProducto2").disabled = true;
                    document.getElementById('txtProducto2').value = productos.DescProducto;
                    document.getElementById("txtModelo2").disabled = true;
                    document.getElementById('txtModelo2').value = productos.DescModelo; 
                    document.getElementById('txtGarantia2').value = productos.GarantiaDias; 
                    document.getElementById('txtCantidad2').value = productos.Cantidad; 
                    document.getElementById('txtDescuento2').value = productos.Descuento; 
                    document.getElementById('txtPrecioUnitario2').value = productos.PrecioxUnd; 
                    document.getElementById('txtIdModelo2').value = productos.IdModelo; 
                    document.getElementById('txtIdCategoria2').value = productos.IdCategoria; 
                    document.getElementById('txtIdProducto2').value = productos.IdProducto; 
                    document.getElementById('txtIdProdet2').value = productos.IdDetalleProductosAlmacen; 
                    document.getElementById('txtExistencia2').value = productos.EnExistencia; 
                    document.getElementById('txtIdDetFact').value = productos.IdDetFactura;
                    if (productos.IdCategoria != 2) {
                        document.getElementById("txtCantidad2").disabled = true;//bloqueado
                    }
                    else {
                        document.getElementById("txtCantidad2").disabled = false; //habilitado
                    }
                }
                tdActions.append(btnView, btnView2);
                //apends
                //obtenemos el id de factura
                document.getElementById('txtId').value = productos.IdFactura;
                //obtenemos el SubTotal, Iva y Total
                document.getElementById('txtSubTotal').value = productos.SubTotal;
                document.getElementById('txtIva').value = productos.Iva;
                document.getElementById('txtTotal').value = productos.Total2;

                tr.append(tdActions, tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                Frag.append(tr);
            });
            TblDetalle.querySelector("tbody").append(Frag);
        }
        // funcion para Cargar al campo <select>
        function cargar_descuentos() {
            var array = ["10", "20", "30", "40", "50", "60", "70", "80", "90"];
            // Ordena el Array Alfabeticamente, es muy facil ;)):
            array.sort();
            addOptionsD("Descuento", array);
        }
        // funcion para Cargar al campo <select>
        function cargar_descuentos2() {
            var array = ["10", "20", "30", "40", "50", "60", "70", "80", "90"];
            // Ordena el Array Alfabeticamente, es muy facil ;)):
            array.sort();
            addOptionsD("Descuento2", array);
        }
        // Rutina para agregar opciones a un DESCUENTOS <select>
        function addOptionsD(domElement, array) {
            var select = document.getElementsByName(domElement)[0];

            for (value in array) {
                var option = document.createElement("option");
                option.text = array[value];
                select.add(option);
            }
        }
        // Rutina para agregar opciones a un PRODUCTO <select>
        function addOptionsP(domElement, array2) {
            var select = document.getElementsByName(domElement)[0];

            for (var i = 0; i < array2.length; i++) {
                var option = array2[i];
                select.options.add(new Option(option.Descripcion));
            }
        }
        //Calular
        const Calcular = async () => {
            var Efectivo = parseFloat(txtEfectivo.value);
            var Total = parseFloat(txtTotal.value);
            if (txtEfectivo.value == "" || txtEfectivo.value == "0") {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                document.getElementById('lblMensaje').innerHTML = 'FAVOR INGRESAR EL MONTO A PAGAR';
            }
            else if (Efectivo < Total) {
                ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                document.getElementById('lblMensaje').innerHTML = 'MONTO A PAGAR DEBE SER MAYOR O IGUAL AL MONTO TOTAL';
            }
            else {
                var calcular = Efectivo - Total;
                document.getElementById("txtCambio").value = calcular;
            }
        }
        //Buscar 
        const BuscarModelo = async () => {
            document.getElementById('CuerpoMod').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "Facturacion.aspx/BuscarModelo";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Parametro: txtBuscar.value, IdProducto: txtProducto.value })
                });
            response = await response.json();
            console.log(response);
            let Frag = document.createDocumentFragment();
            response.d.forEach((modelos) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(modelos.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(modelos.Descripcion);
                let tdEspecificaciones = document.createElement("td");
                tdEspecificaciones.append(modelos.Especificaciones);
                let tdExistencia = document.createElement("td");
                tdExistencia.append(modelos.cantidadExistencia);
                let tdPrecio = document.createElement("td");
                tdPrecio.append(modelos.Precio);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModelo');
                    document.getElementById('txtIdProdet').value = modelos.Id;
                    document.getElementById('txtIdProducto').value = modelos.IdProducto;
                    document.getElementById('txtIdModelo').value = modelos.IdModelo;
                    document.getElementById('txtModelo').value = modelos.Descripcion;
                    document.getElementById('txtPrecioUnitario').value = modelos.Precio;
                    document.getElementById('txtIdCategoria').value = modelos.IdCategoria; //oculta la usamos para validar los accesorios
                    document.getElementById('txtExistencia').value = modelos.cantidadExistencia; //variable oculta para saber cuantos accesorios hay en existencia
                    if (modelos.IdCategoria == 1) { //celulares 90dias
                        document.getElementById("txtGarantia").value = "90";
                        document.getElementById("txtCantidad").value = "1"; //cuando son celular o tablet se debe agregar uno a uno por el imei/serie
                        document.getElementById("txtCantidad").readOnly = true;

                    }
                    else if (modelos.IdCategoria == 2) { //accesorios 30dias
                        document.getElementById("txtGarantia").value = "30";
                        document.getElementById("txtCantidad").readOnly = false;
                    }
                    else { //tabletas 60dias
                        document.getElementById("txtGarantia").value = "60";
                        document.getElementById("txtCantidad").value = "1"; //cuando son celular o tablet se debe agregar uno a uno por el imei/serie
                        document.getElementById("txtCantidad").readOnly = true;
                    }
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdEspecificaciones, tdExistencia, tdPrecio, tdActions);
                Frag.append(tr);
            });
            TblCatModelos.querySelector("tbody").append(Frag);
        }
        //EVENTO CHANGE DEL SELECT PRODUCT
        function ProductChange(selectObj) {
            document.getElementById("txtModelo").value = "";
            document.getElementById("txtPrecioUnitario").value = "0";
            document.getElementById("txtCantidad").value = "0";
            document.getElementById("txtGarantia").value = "0";
            document.getElementById("txtDescuento").value = "Seleccione el Descuento";
        } 
        //Actulizar DetalleFactura
        const Modificar = async () => {
            var Existencia = 0;
            var Cantidad = parseInt(txtCantidad2.value);

            if (txtCantidad2.value < 1) {
                document.getElementById('lblMensaje1').innerHTML = 'CANTIDAD DEBE SER MAYOR A 1';
            }
            else {
                if (txtIdCategoria2.value == 2) {
                    const url = "Facturacion.aspx/ValidarExistencia";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                IdModelo: txtIdModelo.value, CodFact: txtNumFactura.value
                            })
                        });
                    response = await response.json();
                    console.log(response);
                    Existencia = response.d;

                    if (Existencia < Cantidad) {
                        document.getElementById('lblMensaje12').innerHTML = 'CANTIDAD DEBE SER MENOR O IGUAL A LA EXISTENCIA';
                    }
                    else {
                        ModalFunction('ModalEditarDetalle'); //ocultamos el modal
                        document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos la grid
                        const url = "Facturacion.aspx/Actualizar";
                        let response = await fetch(
                            url, {
                                method: "POST",
                                headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                                body: JSON.stringify({
                                    IdCat: txtIdCategoria2.value, IdDetalleFactura: txtIdDetFact.value, Cantidad: txtCantidad2.value, Descuento: txtDescuento2.value, IdModelo: txtIdModelo2.value
                                })
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
                            //actions
                            let tdActions = document.createElement("td");
                            let btnView = document.createElement("input");
                            btnView.value = "Del";
                            btnView.type = "button";
                            btnView.onclick = () => {
                                document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                                ModalFunction('ModalEliminar');
                                document.getElementById('txtIdEliminar').value = productos.Id;
                                document.getElementById('txtCantEliminar').value = productos.Cantidad;
                            }
                            let btnView2 = document.createElement("input");
                            btnView2.value = "Edit";
                            btnView2.type = "button";
                            btnView2.onclick = () => {
                                ModalFunction('ModalEditarDetalle');
                                document.getElementById("txtProducto2").disabled = true;
                                document.getElementById('txtProducto2').value = productos.DescProducto;
                                document.getElementById("txtModelo2").disabled = true;
                                document.getElementById('txtModelo2').value = productos.DescModelo; 
                                document.getElementById('txtGarantia2').value = productos.GarantiaDias; 
                                document.getElementById('txtCantidad2').value = productos.Cantidad; 
                                document.getElementById('txtDescuento2').value = productos.Descuento; 
                                document.getElementById('txtPrecioUnitario2').value = productos.PrecioxUnd; 
                                document.getElementById('txtIdModelo2').value = productos.IdModelo; 
                                document.getElementById('txtIdCategoria2').value = productos.IdCategoria; 
                                document.getElementById('txtIdProducto2').value = productos.IdProducto; 
                                document.getElementById('txtIdProdet2').value = productos.IdDetalleProductosAlmacen;
                                document.getElementById('txtExistencia2').value = productos.EnExistencia;
                                document.getElementById('txtIdDetFact').value = productos.IdDetFactura;
                                if (productos.IdCategoria != 2) {
                                    document.getElementById("txtCantidad2").disabled = true;//bloqueado
                                }
                                else {
                                    document.getElementById("txtCantidad2").disabled = false; //habilitado
                                }
                            }
                            tdActions.append(btnView, btnView2);
                            //apends
                            //obtenemos el id de factura
                            document.getElementById('txtId').value = productos.IdFactura;
                            //obtenemos el SubTotal, Iva y Total
                            document.getElementById('txtSubTotal').value = productos.SubTotal;
                            document.getElementById('txtIva').value = productos.Iva;
                            document.getElementById('txtTotal').value = productos.Total2;

                            tr.append(tdActions, tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                            Frag.append(tr);
                        });
                        TblDetalle.querySelector("tbody").append(Frag);

                        //habilitamos los botones hasta que se haya agregado detalle
                        document.getElementById("btnProcesarA").disabled = false;
                        document.getElementById("btnCalcular").disabled = false;
                        ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                        document.getElementById('lblMensaje').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO!!!';

                        //limpiamos las cajas de texto
                        document.getElementById("txtProducto").value = "";
                        document.getElementById("txtModelo").value = "";
                        document.getElementById("txtDescuento").value = "0";
                        document.getElementById("txtPrecioUnitario").value = "0";
                        document.getElementById("txtCantidad").value = "0";
                        document.getElementById("txtGarantia").value = "0";
                    }
                }
                else {
                    ModalFunction('ModalEditarDetalle'); //ocultamos el modal
                    document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos la grid
                    const url = "Facturacion.aspx/Actualizar";
                    let response = await fetch(
                        url, {
                            method: "POST",
                            headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                IdCat: txtIdCategoria2.value, IdDetalleFactura: txtIdDetFact.value, Cantidad: txtCantidad2.value, Descuento: txtDescuento2.value, IdModelo: txtIdModelo2.value
                            })
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
                        //actions
                        let tdActions = document.createElement("td");
                        let btnView = document.createElement("input");
                        btnView.value = "Del";
                        btnView.type = "button";
                        btnView.onclick = () => {
                            document.getElementById('lblMensajeEliminar').innerHTML = 'DESEA ELIMINAR EL REGISTRO ?';
                            ModalFunction('ModalEliminar');
                            document.getElementById('txtIdEliminar').value = productos.Id;
                            document.getElementById('txtCantEliminar').value = productos.Cantidad;
                        }
                        let btnView2 = document.createElement("input");
                        btnView2.value = "Edit";
                        btnView2.type = "button";
                            btnView2.onclick = () => {
                                ModalFunction('ModalEditarDetalle');
                                document.getElementById("txtProducto2").disabled = true;
                                document.getElementById('txtProducto2').value = productos.DescProducto;
                                document.getElementById("txtModelo2").disabled = true;
                                document.getElementById('txtModelo2').value = productos.DescModelo; 
                                document.getElementById('txtGarantia2').value = productos.GarantiaDias; 
                                document.getElementById('txtCantidad2').value = productos.Cantidad; 
                                document.getElementById('txtDescuento2').value = productos.Descuento; 
                                document.getElementById('txtPrecioUnitario2').value = productos.PrecioxUnd; 
                                document.getElementById('txtIdModelo2').value = productos.IdModelo; 
                                document.getElementById('txtIdCategoria2').value = productos.IdCategoria; 
                                document.getElementById('txtIdProducto2').value = productos.IdProducto; 
                                document.getElementById('txtIdProdet2').value = productos.IdDetalleProductosAlmacen; 
                                document.getElementById('txtExistencia2').value = productos.EnExistencia; 
                                document.getElementById('txtIdDetFact').value = productos.IdDetFactura;
                                if (productos.IdCategoria != 2) {
                                    document.getElementById("txtCantidad2").disabled = true;//bloqueado
                                }
                                else {
                                    document.getElementById("txtCantidad2").disabled = false; //habilitado
                                }
                            }
                        tdActions.append(btnView, btnView2);
                        //apends
                        //obtenemos el id de factura
                        document.getElementById('txtId').value = productos.IdFactura;
                        //obtenemos el SubTotal, Iva y Total
                        document.getElementById('txtSubTotal').value = productos.SubTotal;
                        document.getElementById('txtIva').value = productos.Iva;
                        document.getElementById('txtTotal').value = productos.Total2;

                        tr.append(tdActions, tdCantidad, tdDescripcion, tdGarantia, tdPrecio, tdDescuento, tdTotal);
                        Frag.append(tr);
                    });
                    TblDetalle.querySelector("tbody").append(Frag);

                    //habilitamos los botones hasta que se haya agregado detalle
                    document.getElementById("btnProcesarA").disabled = false;
                    document.getElementById("btnCalcular").disabled = false;
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje               
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO!!!';

                    //limpiamos las cajas de texto
                    document.getElementById("txtProducto").value = "";
                    document.getElementById("txtModelo").value = "";
                    document.getElementById("txtDescuento").value = "0";
                    document.getElementById("txtPrecioUnitario").value = "0";
                    document.getElementById("txtCantidad").value = "0";
                    document.getElementById("txtGarantia").value = "0";
                }
            }
        }
        window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%--ENCABEZADO--%>
    <div class="GroupDiv" id="ProductoContainer">
        <div class="ModalTitle">
            NUEVA FACTURA
        </div>
        <div class="col-lg-12" style="margin-top:20px;">
            <div class="col-xs-12 col-sm-6 col-md-6">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <label for="TextoRUC">RUC:<input type="text" class="txtFormRUC" name="Type" id="txtRUC" readonly="readonly" /></label>                            
                    <label for="TextoFactura">N° Factura:<input type="text" class="txtFormF2" name="Type" id="txtNumFactura" readonly="readonly" /></label>                            
                    <label for="TextoFecha">Fecha:<input type="text" class="txtFormF2" name="Type" id="txtFecha" readonly="readonly" /></label>
                    <label for="TextoCliente">Cliente:<input type="text" class="txtFormF" name="Type" id="txtDatosCliente" maxlength="50" /></label>
                </div>
            </div>    
        </div>
        <div>
            <label for="TextoIdFactura" style="visibility: hidden">Id:<input type="text" name="Type" id="txtId" /></label>
        </div>
    </div>
    <%--DETALLE--%>
    <div class="GroupDiv" id="ProductosDetalle">
        <div class="ModalActions">
            <input type="button" id="btnAgregarDet" class="btnSuccess" value="Agregar Productos" />
        </div>
        <div class="ModalTitle">
            DETALLE DE FACTURA
        </div>
        <div class="Content">
            <table id="TblDetalle" class="TblForm">
                <thead>
                    <tr>
                        <th>OPTION</th>
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
                <label for="TextoEfectivo">C$ Efectivo:<input type="number" class="txtForm1" name="Type" id="txtEfectivo" min="1" /></label>
                <label for="TextoCambio">C$ Cambio:<input type="text" class="txtForm1" name="Type" id="txtCambio" readonly="readonly" /></label>
                <label for="buton">
                    <input type="button" class="btnSuccess" name="Type" value="CALCULAR" id="btnCalcular" /></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnProcesarA" class="btnSuccess" value="FACTURAR" />
                <input type="button" id="btnProcesarC" class="btnCancel" value="CANCELAR" />
            </div>
        </div>
    </div>
    <%--AGREGAR DETALLE--%>
    <div class="Modal" id="ModalAgregarDetalle">
        <div class="ModalContentFac">
            <div class="ModalTitle">
                AGREGAR PRODUCTO
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje1" id="lblMensaje1"></label>
            </div>
            <div class="col-lg-12" style="margin-top:20px;">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <label for="TextoSelect"; style="margin-left: 30px">Producto:<select name="ListaProductos" id="txtProducto" onchange="ProductChange(this)" class="txtFormLista"><option>Seleccione un Producto</option></select></label>    
                        <label for="TextoModelo"; style="margin-left: 20px">
                            Articulos:<input type="text" class="txtFormLista" name="Type" id="txtModelo" readonly="readonly" />
                            <input type="button" id="btnAgregarMod" class="btnSuccess" value="+" />
                        </label>                        
                        <label for="TextoGarantia"; style="margin-left: 20px">Garantia:<input type="number" class="txtFormLista2" name="Type" id="txtGarantia" readonly="readonly" /></label>                            
                        <label for="TextoCantidad"; style="margin-left: 20px">Cantidad:<input type="number" class="txtFormLista2" name="Type" id="txtCantidad" min="1" /></label>
                    </div>
                </div>    
            </div>
            <div class="col-lg-12" style="margin-top:20px;">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <label for="TextoSelect"; style="margin-left: 20px">Descuento:<select name="Descuento" id="txtDescuento" class="txtFormLista"><option>Seleccione el Descuento</option></select></label>
                        <label for="TextoPrecio"; style="margin-left: 25px">Precio U:<input type="number" class="txtFormLista2" name="Type" id="txtPrecioUnitario" readonly="readonly" /></label>                    
                    </div>
                </div>    
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar" class="btnSuccess" value="Agregar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalAgregarDetalle')" value="Cancelar" />
                <label for="TextoIdProducto" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdProducto" /></label>
                <label for="TextoIdModelo" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdModelo" /></label>
                <label for="TextoIdCategoria" style="visibility: hidden">Categoria:<input type="text" class="txtForm2" name="Type" id="txtIdCategoria" /></label>
                <label for="TextoExistencia" style="visibility: hidden">Existencia:<input type="number" class="txtForm2" name="Type" id="txtExistencia" /></label>
                <label for="TextoIdProdet" style="visibility: hidden">IdProdet:<input type="number" class="txtForm2" name="Type" id="txtIdProdet" /></label>
            </div>
        </div>
    </div>
    <%--CAT ARTICULOS--%>
    <div class="Modal" id="ModalModelo">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO MODELOS
            </div>
            <div class="ModalActions">
                <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
                <input type="button" id="btnBuscarModelos" class="btnSuccess" value="Buscar" />
            </div>
            <div class="Content">
                <div id="Scroll2">
                    <table id="TblCatModelos" class="TblForm">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>DESCRIPCION</th>
                                <th>CARACTERISTICAS</th>
                                <th>CANT. EXISTENCIA</th>
                                <th>PRECIO VENTA</th>
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
    <%--MENSAJE--%>
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
                <label for="TextoCant" style="visibility: hidden">Cant:<input type="text" class="txtForm2" name="Type" id="txtCantEliminar" /></label>
            </div>
        </div>
    </div>
    <%--APROBAR O CANCELAR EL PROCESO--%>
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
    <%--EDITAR DETALLE--%>
    <div class="Modal" id="ModalEditarDetalle">
        <div class="ModalContentFac">
            <div class="ModalTitle">
                MODIFICAR PRODUCTO
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje1" id="lblMensaje12"></label>
            </div>
            <div class="col-lg-12" style="margin-top:20px;">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <label for="TextoSelect"; style="margin-left: 30px">Producto:<input type="text" name="ListaProductos" id="txtProducto2" class="txtFormLista3"></label>    
                        <label for="TextoModelo"; style="margin-left: 20px">
                            Articulos:<input type="text" class="txtFormLista" name="Type" id="txtModelo2" readonly="readonly" />
                        </label>                        
                        <label for="TextoGarantia"; style="margin-left: 20px">Garantia:<input type="number" class="txtFormLista2" name="Type" id="txtGarantia2" readonly="readonly" /></label>                            
                        <label for="TextoCantidad"; style="margin-left: 20px">Cantidad:<input type="number" class="txtFormLista2" name="Type" id="txtCantidad2" min="1" /></label>
                    </div>
                </div>    
            </div>
            <div class="col-lg-12" style="margin-top:20px;">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <label for="TextoSelect"; style="margin-left: 20px">Descuento:<select name="Descuento2" id="txtDescuento2" class="txtFormLista"><option>Seleccione el Descuento</option></select></label>
                        <label for="TextoPrecio"; style="margin-left: 25px">Precio U:<input type="number" class="txtFormLista2" name="Type" id="txtPrecioUnitario2" readonly="readonly" /></label>                    
                    </div>
                </div>    
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnModificar" class="btnSuccess" value="Actualizar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalEditarDetalle')" value="Cancelar" />
                <label for="TextoIdProducto" style="visibility: hidden">Idproducto:<input type="text" class="txtForm2" name="Type" id="txtIdProducto2" /></label>
                <label for="TextoIdModelo" style="visibility: hidden">Idmodelo:<input type="text" class="txtForm2" name="Type" id="txtIdModelo2" /></label>
                <label for="TextoIdCategoria" style="visibility: hidden">idCategoria:<input type="text" class="txtForm2" name="Type" id="txtIdCategoria2" /></label>
                <label for="TextoExistencia" style="visibility: hidden">Existencia:<input type="number" class="txtForm2" name="Type" id="txtExistencia2" /></label>
                <label for="TextoIdProductodet" style="visibility: hidden">IdProductodet:<input type="number" class="txtForm2" name="Type" id="txtIdProdet2" /></label>
                <label for="TextoIddetFac" style="visibility: hidden">IddetFac:<input type="number" class="txtForm2" name="Type" id="txtIdDetFact" /></label>
            </div>
        </div>
    </div>

</asp:Content>
