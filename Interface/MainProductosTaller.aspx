<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="MainProductosTaller.aspx.cs" Inherits="Interface.MainProductosTaller" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script>
            const Onload = async () => {
                let params = new URLSearchParams(location.search);
                const IdProducto = params.get("IdProducto");
                console.log(IdProducto);
                const url = "MainProductosTaller.aspx/CargarProductosAlmacenTaller";
                let response = await fetch(
                    url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ id: IdProducto })
                });
                response = await response.json();
                console.log(response);
                document.getElementById('txtId2').value = IdProducto;
                let Frag = document.createDocumentFragment();
                response.d.forEach((productos) => {
                    let tr = document.createElement("tr");
                    let tdCodProducto = document.createElement("td");
                    tdCodProducto.append(productos.CodProducto);
                    let tdModelo = document.createElement("td");
                    tdModelo.append(productos.Modelo);
                    let tdSerie = document.createElement("td");
                    tdSerie.append(productos.Serie);
                    let tdEstado = document.createElement("td");
                    tdEstado.append(productos.EstadoVenta);
                    let tdPrecioC = document.createElement("td");
                    tdPrecioC.append(productos.PrecioC);
                    let tdPrecioV = document.createElement("td");
                    tdPrecioV.append(productos.PrecioV);
                    //actions
                    let tdActions = document.createElement("td");
                    
                    let btnView2 = document.createElement("input");
                    btnView2.value = "Dar Alta";
                    btnView2.type = "button";
                    btnView2.onclick = () => {
                      
                            ModalFunction('ModalBaja');
                            document.getElementById('txtIdBaja').value = productos.Id;
                            document.getElementById('lblMensajeBaja').innerHTML = 'ESTÁ SEGURO EN DAR DE ALTA AL PRODUCTO?';
                        
                    }
                    let btnView3 = document.createElement("input");
                    btnView3.value = "Ver";
                    btnView3.type = "button";
                    btnView3.onclick = () => {
                        ModalFunction('ModalVer');
                        document.getElementById('txtImei').value = productos.IMEI;
                        document.getElementById('txtGama').value = productos.GAMA;
                        document.getElementById('txtCaracteristicas').value = productos.Caracteristicas;
                        document.getElementById('txtdebaja').value = productos.MotivoBaja;
                        document.getElementById('txtProducto').value = productos.NOMREPRODUCTO;
                    }
                   
                    tdActions.append( btnView2, btnView3/*, btnView4*/);
                    //apends
                    tr.append(tdCodProducto, tdModelo, tdSerie, tdEstado, tdPrecioC, tdPrecioV, tdActions);
                    Frag.append(tr);
                });
                TblProducto.querySelector("tbody").append(Frag);

                //Asignar eventos
                btnBuscarProductos.addEventListener("click", BuscarProducto);
                btnBaja.addEventListener("click", DarAlta);
                btnModificar.addEventListener("click", Modificar);
                btnAgregar.addEventListener("click", Agregar);
                btnAgregarMar.addEventListener("click", AgregarMarca);
                btnAgregarMar2.addEventListener("click", AgregarMarca2);
                //final eventos
            }
            //BuscarProducto
            const BuscarProducto = async () => {
                document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                let params = new URLSearchParams(location.search);
                const IdProducto = params.get("IdProducto");
                console.log(IdProducto);
                const url = "MainProductosTaller.aspx/BuscarProductoxNombre";
                let response = await fetch(
                    url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Buscar: txtBuscar.value, id: IdProducto })
                });
                response = await response.json();
                console.log(response);
                document.getElementById('txtId2').value = IdProducto;
                let Frag = document.createDocumentFragment();
                response.d.forEach((productos) => {
                    let tr = document.createElement("tr");
                    let tdCodProducto = document.createElement("td");
                    tdCodProducto.append(productos.CodProducto);
                    let tdModelo = document.createElement("td");
                    tdModelo.append(productos.Modelo);
                    let tdSerie = document.createElement("td");
                    tdSerie.append(productos.Serie);
                    let tdEstado = document.createElement("td");
                    tdEstado.append(productos.EstadoVenta);
                    let tdPrecioC = document.createElement("td");
                    tdPrecioC.append(productos.PrecioC);
                    let tdPrecioV = document.createElement("td");
                    tdPrecioV.append(productos.PrecioV);
                    //actions
                    let tdActions = document.createElement("td");
                    let btnView = document.createElement("input");
                    btnView.value = "Editar";
                    btnView.type = "button";
                    btnView.onclick = () => {
                        if (productos.EstadoVenta != "NO VENDIDO") {
                            ModalFunction('ModalMensaje1');
                            document.getElementById('lblMensaje2').innerHTML = 'PRODUCTO YA FUE VENDIDO O DADO DE BAJA';
                        }
                        else {
                            ModalFunction('ModalDetalle');
                            document.getElementById('lblMensaje1').style.display = 'none';
                            document.getElementById('txtId').value = productos.Id;
                            document.getElementById('txtPrecioC').value = productos.PrecioC;
                            document.getElementById('txtPrecioVenta').value = productos.PrecioV;
                        }
                    }
                    let btnView2 = document.createElement("input");
                    btnView2.value = "Dar Baja";
                    btnView2.type = "button";
                    btnView2.onclick = () => {
                        if (productos.EstadoVenta != "NO VENDIDO") {
                            ModalFunction('ModalMensaje1');
                            document.getElementById('lblMensaje2').innerHTML = 'PRODUCTO YA FUE VENDIDO O DADO DE BAJA';
                        }
                        else {
                            ModalFunction('ModalBaja');
                            document.getElementById('txtIdBaja').value = productos.Id;
                            document.getElementById('lblMensajeBaja').innerHTML = 'ESTA SEGURO EN DAR DE BAJA AL PRODUCTO??';
                        }
                    }
                    let btnView3 = document.createElement("input");
                    btnView3.value = "Ver";
                    btnView3.type = "button";
                    btnView3.onclick = () => {
                        ModalFunction('ModalVer');
                        document.getElementById('txtImei').value = productos.IMEI;
                        document.getElementById('txtGama').value = productos.GAMA;
                        document.getElementById('txtCaracteristicas').value = productos.Caracteristicas;
                        document.getElementById('txtdebaja').value = productos.MotivoBaja;
                        document.getElementById('txtProducto').value = productos.NOMREPRODUCTO;
                    }
                    tdActions.append(btnView, btnView2, btnView3);
                    //apends
                    tr.append(tdCodProducto, tdModelo, tdSerie, tdEstado, tdPrecioC, tdPrecioV, tdActions);
                    Frag.append(tr);
                });
                TblProducto.querySelector("tbody").append(Frag);
            }
            //DarBaja
            const DarAlta = async () => {
                document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                ModalFunction('ModalBaja');
                const url = "MainProductosAlmacen.aspx/LiberarProducto";
                let response = await fetch(
                    url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ iddetalle: txtIdBaja.value, idmaestro: txtId2.value })
                });
                response = await response.json();
                window.location.reload();
            }
            //Actualizar
            const Modificar = async () => {
                var Pc = parseInt(txtPrecioC.value);
                var Pv = parseInt(txtPrecioVenta.value);
                if (txtPrecioVenta.value == "") {
                    document.getElementById('lblMensaje1').style.display = 'block';
                    document.getElementById('lblMensaje1').innerHTML = 'DEBE INGRESAR EL PRECIO VENTA';
                }
                else if (Pv <= Pc) {
                    document.getElementById('lblMensaje1').style.display = 'block';
                    document.getElementById('lblMensaje1').innerHTML = 'PRECIO VENTA DEBE SER MAYOR A PRECIO COMPRA';
                }
                else {
                    ModalFunction('ModalDetalle'); //ocultamos el modal
                    document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
                    const url = "MainProductosAlmacen.aspx/ModicarProducto";
                    let response = await fetch(
                        url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            id: txtId2.value, idDet: txtId.value, PrecioV: txtPrecioVenta.value
                        })
                    });
                    response = await response.json();
                    console.log(response);
                    let Frag = document.createDocumentFragment();
                    response.d.forEach((productos) => {
                        let tr = document.createElement("tr");
                        let tdCodProducto = document.createElement("td");
                        tdCodProducto.append(productos.CodProducto);
                        let tdModelo = document.createElement("td");
                        tdModelo.append(productos.Modelo);
                        let tdSerie = document.createElement("td");
                        tdSerie.append(productos.Serie);
                        let tdEstado = document.createElement("td");
                        tdEstado.append(productos.EstadoVenta);
                        let tdPrecioC = document.createElement("td");
                        tdPrecioC.append(productos.PrecioC);
                        let tdPrecioV = document.createElement("td");
                        tdPrecioV.append(productos.PrecioV);
                        //actions
                        let tdActions = document.createElement("td");
                        let btnView = document.createElement("input");
                        btnView.value = "Editar";
                        btnView.type = "button";
                        btnView.onclick = () => {
                            if (productos.EstadoVenta != "NO VENDIDO") {
                                ModalFunction('ModalMensaje1');
                                document.getElementById('lblMensaje2').innerHTML = 'PRODUCTO YA FUE VENDIDO O DADO DE BAJA';
                            }
                            else {
                                ModalFunction('ModalDetalle');
                                document.getElementById('lblMensaje1').style.display = 'none';
                                document.getElementById('txtId').value = productos.Id;
                                document.getElementById('txtPrecioC').value = productos.PrecioC;
                                document.getElementById('txtPrecioVenta').value = productos.PrecioV;
                            }
                        }
                        let btnView2 = document.createElement("input");
                        btnView2.value = "Dar Baja";
                        btnView2.type = "button";
                        btnView2.onclick = () => {
                            
                                ModalFunction('ModalBaja');
                                document.getElementById('txtIdBaja').value = productos.Id;
                                document.getElementById('lblMensajeBaja').innerHTML = 'ESTA SEGURO EN DAR DE BAJA AL PRODUCTO??';
                            
                        }
                        let btnView3 = document.createElement("input");
                        btnView3.value = "Ver";
                        btnView3.type = "button";
                        btnView3.onclick = () => {
                            ModalFunction('ModalVer');
                            document.getElementById('txtImei').value = productos.IMEI;
                            document.getElementById('txtGama').value = productos.GAMA;
                            document.getElementById('txtCaracteristicas').value = productos.Caracteristicas;
                            document.getElementById('txtdebaja').value = productos.MotivoBaja;
                            document.getElementById('txtProducto').value = productos.NOMREPRODUCTO;
                        }
                        tdActions.append(btnView, btnView2, btnView3);
                        //apends
                        tr.append(tdCodProducto, tdModelo, tdSerie, tdEstado, tdPrecioC, tdPrecioV, tdActions);
                        Frag.append(tr);
                    });
                    TblProducto.querySelector("tbody").append(Frag);

                    ModalFunction('ModalMensaje1'); //Mostrar Mensaje               
                    document.getElementById('lblMensaje2').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO';

                    //limpiamos las cajas de texto
                    document.getElementById('txtPrecioVenta').value = "";
                }
            }

            window.onload = Onload;
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ProductosContainer">
        <div class="ModalTitle">
            PRODUCTOS EN TALLER
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscarProductos" class="btnSuccess" value="Buscar" />
        </div>
        <div class="Content">
            <%--capturamos la variable que esta siendo usada--%>
            <label for="TextoId2" style="visibility: hidden">Id2:<input type="text" class="txtForm2" name="Type" id="txtId2" /></label>
            <table id="TblProducto" class="TblForm">
                <thead>
                    <tr>
                        <th>COD PRODUCTO</th>
                        <th>MODELO</th>
                        <th>SERIE</th>
                        <th>ESTADO</th>
                        <th>PRECIO COMPRA</th>
                        <th>PRECIO VENTA</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnCancel" onclick="window.location = 'ArticulosTaller.aspx'" value="Regresar" />
            </div>
        </div>
    </div>
    <%--Modficar--%>
    <div class="Modal" id="ModalDetalle">
        <div class="ModalContent">
            <div class="ModalTitle">
                ACTUALIZAR PRECIO DE VENTA
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje1" id="lblMensaje1"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <label for="TextoPrecioV">
                    Precio V. :
                    <input type="number" class="txtForm2" name="Type" id="txtPrecioVenta" min="1" />
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnModificar" class="btnSuccess" value="Actualizar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalDetalle')" value="Cancelar" />
                <label for="TextoId" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtId" /></label>
                <label for="TextoId" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtPrecioC" /></label>
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
    <%--Dar Baja--%>
    <div class="Modal" id="ModalBaja">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje2" id="lblMensajeBaja"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnBaja" class="btnSuccess" value="Aceptar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalBaja')" value="Cancelar" />
                <label for="TextoId" style="visibility: hidden"> Id:<input type="text" class="txtForm2" name="Type" id="txtIdBaja" /></label>
            </div>
        </div>
    </div>
    <%--VER--%>
    <div class="Modal" id="ModalVer">
        <div class="ModalContentModelo">
            <div class="ModalTitle">
                DETALLE
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoDescripcion">
                    IMEI:<input type="text" class="txtForm1" name="Type" id="txtImei" readonly="readonly"  />
                </label>
                <label for="TextoProducto">
                    Producto:<input type="text" class="txtForm1" name="Type" id="txtProducto" readonly="readonly" />
                </label>
                <label for="TextoGama">
                    Gama:<input type="text" class="txtForm1" name="Type" id="txtGama" readonly="readonly" />
                </label>
            </div>
            <div class="ModalActions" style=" display: inline-flex">
                <label for="TextoCaracteristicas">
                    <label>Caracteristicas</label>
                    <textarea id="txtCaracteristicas" class="txtEspecificaciones2" name="Caracteristicas" rows="20" cols="40" readonly="readonly" ></textarea>
                </label>
                <label for="TextoBaja">
                    <label>Baja</label>
                    <textarea id="txtdebaja" class="txtEspecificaciones2" name="baja" rows="20" cols="40" readonly="readonly" ></textarea>
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalVer')" value="Regresar" />
            </div>
        </div>
    </div>
</asp:Content>
