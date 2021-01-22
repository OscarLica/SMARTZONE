<%@ Page Title="Catalogo de Modelos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CatModelos.aspx.cs" Inherits="Interface.CatModelos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            document.getElementById('txtDescripcion').value = "";
            document.getElementById('txtProducto').value = "";
            document.getElementById('txtGama').value = "";
            document.getElementById('txtEspecificaciones').value = "";            
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            const url = "CatModelos.aspx/CargarModelos";
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
            response.d.forEach((modelos) => {
                let tr = document.createElement("tr");
                let tdProducto = document.createElement("td");
                tdProducto.append(modelos.Producto);
                let tdGama = document.createElement("td");
                tdGama.append(modelos.Gama);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(modelos.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarModelos');
                    document.getElementById('txtIdP2').value = modelos.IdProducto;
                    document.getElementById('txtProducto2').value = modelos.Producto;
                    document.getElementById('txtIdG2').value = modelos.IdGama;
                    document.getElementById('txtGama2').value = modelos.Gama;
                    document.getElementById('txtIdM2').value = modelos.Id;
                    document.getElementById('txtDescripcion2').value = modelos.Descripcion;
                    document.getElementById('txtEspecificaciones2').value = modelos.Especificaciones;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = modelos.Id;
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL MODELO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdProducto, tdGama, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblModelos.querySelector("tbody").append(Frag);

            //Asignar eventos
            btnBuscarModelos.addEventListener("click", BuscarModelo);
            btnAgregar.addEventListener("click", Agregar);
            btnAgregarPro.addEventListener("click", AgregarProducto);
            btnAgregarGam.addEventListener("click", AgregarGama);
            btnAceptar.addEventListener("click", Recargar);
            btnModificar.addEventListener("click", Modificar);
            btnAgregarPro2.addEventListener("click", ModificarProducto);
            btnAgregarGam2.addEventListener("click", ModificarGama);
            btnEliminar.addEventListener("click", Eliminar);
            //final eventos
        }
        //Buscar 
        const BuscarModelo = async () => {
            document.getElementById('txtDescripcion').value = "";
            document.getElementById('txtProducto').value = "";
            document.getElementById('txtGama').value = "";
            document.getElementById('txtEspecificaciones').value = "";            
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "CatModelos.aspx/BuscarModelo";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Parametro: txtBuscar.value })
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((modelos) => {
                let tr = document.createElement("tr");
                let tdProducto = document.createElement("td");
                tdProducto.append(modelos.Producto);
                let tdGama = document.createElement("td");
                tdGama.append(modelos.Gama);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(modelos.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarModelos');
                    document.getElementById('txtIdP2').value = modelos.IdProducto;
                    document.getElementById('txtProducto2').value = modelos.Producto;
                    document.getElementById('txtIdG2').value = modelos.IdGama;
                    document.getElementById('txtGama2').value = modelos.Gama;
                    document.getElementById('txtIdM2').value = modelos.Id;
                    document.getElementById('txtDescripcion2').value = modelos.Descripcion;
                    document.getElementById('txtEspecificaciones2').value = modelos.Especificaciones;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = modelos.Id;
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL MODELO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdProducto, tdGama, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblModelos.querySelector("tbody").append(Frag);
        }
        //GuardarNuevo
        const Agregar = async () => {
            if (txtDescripcion.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'INGRESE LA DESCRIPCION DEL MODELO';
            }
            else if (txtProducto.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'SELECCIONE UN PRODUCTO';
            }
            else if (txtGama.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'SELECCIONE UNA GAMA';
            }
            else if (txtEspecificaciones.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'INGRESE LAS CARACTERISTICAS';
            }
            else {
                const url = "CatModelos.aspx/AgregarModelo";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ IdProducto: txtIdP.value, IdGama: txtIdG.value, Modelo: txtDescripcion.value, Caracteristicas: txtEspecificaciones.value })
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {
                    ModalFunction('ModalAgregarModelos'); //ocultamos el modal
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO AGREGADO CON EXITO';
                }
                else {
                    document.getElementById('lblMensajeAgregar').innerHTML = 'MODELO YA EXISTE, SELECCIONE OTRO PRODUCTO O GAMA';
                }
            }
        }
        //Agregar Producto
        const AgregarProducto = async () => {
            document.getElementById('CuerpoPro').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalProductos'); //ocultamos el modal
            const url = "CatModelos.aspx/ListarProductos";
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
                    document.getElementById('txtIdP').value = productos.Id;
                    document.getElementById('txtProducto').value = productos.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatProductos.querySelector("tbody").append(Frag);
        }
        //Agregar Gama
        const AgregarGama = async () => {
            document.getElementById('CuerpoGam').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalGama'); //ocultamos el modal
            const url = "CatModelos.aspx/ListarGamas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((gama) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(gama.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(gama.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalGama');
                    document.getElementById('txtIdG').value = gama.Id;
                    document.getElementById('txtGama').value = gama.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatGamas.querySelector("tbody").append(Frag);
        }
        //Cargar Valores de la Grid
        const Recargar = async () => {
            document.getElementById('txtDescripcion').value = "";
            document.getElementById('txtProducto').value = "";
            document.getElementById('txtGama').value = "";
            document.getElementById('txtEspecificaciones').value = "";            
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "CatModelos.aspx/CargarModelos";
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
            response.d.forEach((modelos) => {
                let tr = document.createElement("tr");
                let tdProducto = document.createElement("td");
                tdProducto.append(modelos.Producto);
                let tdGama = document.createElement("td");
                tdGama.append(modelos.Gama);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(modelos.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarModelos');
                    document.getElementById('txtIdP2').value = modelos.IdProducto;
                    document.getElementById('txtProducto2').value = modelos.Producto;
                    document.getElementById('txtIdG2').value = modelos.IdGama;
                    document.getElementById('txtGama2').value = modelos.Gama;
                    document.getElementById('txtIdM2').value = modelos.Id;
                    document.getElementById('txtDescripcion2').value = modelos.Descripcion;
                    document.getElementById('txtEspecificaciones2').value = modelos.Especificaciones;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = modelos.Id;
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL MODELO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdProducto, tdGama, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblModelos.querySelector("tbody").append(Frag);
        }
        //Modificar
        const Modificar = async () => {
            if (txtDescripcion2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'INGRESE LA DESCRIPCION DEL MODELO';
            }
            else if (txtProducto2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'SELECCIONE UN PRODUCTO';
            }
            else if (txtGama2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'SELECCIONE UNA GAMA';
            }
            else if (txtEspecificaciones2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'INGRESE LAS CARACTERISTICAS';
            }
            else {
                const url = "CatModelos.aspx/ModificarModelo";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ Id: txtIdM2.value,  IdProducto: txtIdP2.value, IdGama: txtIdG2.value, Modelo: txtDescripcion2.value, Caracteristicas: txtEspecificaciones2.value})
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {
                    ModalFunction('ModalModificarModelos'); //ocultamos el modal
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO';
                }
                else {
                    document.getElementById('lblMensajeModificar').innerHTML = 'MODELO YA EXISTE, SELECCIONE OTRO PRODUCTO O GAMA';
                }
            }
        }
        //Modificar Categoria
        const ModificarProducto = async () => {
            document.getElementById('CuerpoPro').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalProductos'); //ocultamos el modal
            const url = "CatModelos.aspx/ListarProductos";
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
                    document.getElementById('txtIdP2').value = productos.Id;
                    document.getElementById('txtProducto2').value = productos.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatProductos.querySelector("tbody").append(Frag);
        }
        //Modificar Marca
        const ModificarGama = async () => {
            document.getElementById('CuerpoGam').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalGama'); //ocultamos el modal
            const url = "CatModelos.aspx/ListarGamas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((gama) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(gama.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(gama.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalGama');
                    document.getElementById('txtIdG2').value = gama.Id;
                    document.getElementById('txtGama2').value = gama.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatGamas.querySelector("tbody").append(Frag);
        }
        //Eliminar
        const Eliminar = async () => {
            const url = "CatModelos.aspx/EliminarModelo";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Id: txtIdEliminar.value })
                });
            response = await response.json();
            console.log(response);
            if (response.d == true) {
                ModalFunction('ModalEliminar'); //ocultamos el modal
                ModalFunction('ModalMensaje'); //Mostrar Mensaje
                document.getElementById('lblMensaje').innerHTML = 'REGISTRO ELIMINADO CON EXITO';
            }
            else {
                document.getElementById('lblEliminar').innerHTML = 'EXISTEN PRODUCTOS EN ALMACEN QUE DEPENDEN DE ESTE MODELO!, NO SE PUEDE ELIMINAR';
            }
        }

        window.onload = Onload;
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ModeloContainer">
        <div class="ModalTitle">
            LISTA DE MODELOS
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscarModelos" class="btnSuccess" value="Buscar" />
        </div>
        <div id="Scroll2">
            <table id="TblModelos" class="TblForm">
                <thead>
                    <tr>
                        <th>PRODUCTO</th>
                        <th>GAMA</th>
                        <th>DESCRIPCION</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
        </div>
        <div class="ModalActions" style="text-align: center">
            <input type="button" class="btnPrimary" onclick="ModalFunction('ModalAgregarModelos')" value="Agregar" />
            <input type="button" class="btnCancel" onclick="window.location = 'Catalogos.aspx'" value="Regresar" />
        </div>
    </div>

    <%--INICIO MODELES--%>

    <%--AGREGAR MODELO--%>
    <div class="Modal" id="ModalAgregarModelos">
        <div class="ModalContentModelo">
            <div class="ModalTitle">
                AGREGAR MODELO                
            </div>
            <div style="text-align: center">
                <label class="lblMensaje1" id="lblMensajeAgregar"></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoDescripcion">
                    Modelo:<input type="text" class="txtForm1" name="Type" id="txtDescripcion" maxlength="20" />
                </label>
                <label for="TextoProducto">
                    Producto:<input type="text" class="txtForm1" name="Type" id="txtProducto" readonly="readonly" />
                    <input type="button" id="btnAgregarPro" class="btnSuccess" value="+" />
                </label>
                <label for="TextoGama">
                    Gama:<input type="text" class="txtForm1" name="Type" id="txtGama" readonly="readonly" />
                    <input type="button" id="btnAgregarGam" class="btnSuccess" value="+" />
                </label>
            </div>
            <div class="ModalActions" style=" text-align: center">
                <label for="TextoCaracteristicas">
                    <label>Caracteristicas</label>
                    <textarea id="txtEspecificaciones" class="txtEspecificaciones" name="Caracteristicas" rows="20" cols="40" maxlength="300"></textarea>
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar" class="btnSuccess" value="Agregar" />
                <input type="button" class="btnCancel" onclick="window.location = 'CatModelos.aspx'" value="Cancelar" />
                <label for="TextoIdP" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdP" /></label>
                <label for="TextoIdG" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdG" /></label>
            </div>
        </div>
    </div>
    <%--MODIFICAR MODELO--%>
    <div class="Modal" id="ModalModificarModelos">
        <div class="ModalContentModelo">
            <div class="ModalTitle">
                MODIFICAR PRODUCTO
            </div>
            <div style="text-align: center">
                <label class="lblMensaje1" id="lblMensajeModificar"></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoDescripcion">
                    Modelo:<input type="text" class="txtForm1" name="Type" id="txtDescripcion2" maxlength="20" />
                </label>
                <label for="TextoProducto">
                    Producto:<input type="text" class="txtForm1" name="Type" id="txtProducto2" readonly="readonly" />
                    <input type="button" id="btnAgregarPro2" class="btnSuccess" value="+" />
                </label>
                <label for="TextoGama">
                    Gama:<input type="text" class="txtForm1" name="Type" id="txtGama2" readonly="readonly" />
                    <input type="button" id="btnAgregarGam2" class="btnSuccess" value="+" />
                </label>
            </div>
            <div class="ModalActions" style=" text-align: center">
                <label for="TextoCaracteristicas">
                    <label>Caracteristicas</label>
                    <textarea id="txtEspecificaciones2" class="txtEspecificaciones" name="Caracteristicas" rows="20" cols="40" maxlength="300"></textarea>
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnModificar" class="btnSuccess" value="Actualizar" />
                <input type="button" class="btnCancel" onclick="window.location = 'CatModelos.aspx'" value="Cancelar" />
                <label for="TextoIdP" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdP2" /></label>
                <label for="TextoIdG" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdG2" /></label>
                <label for="TextoId" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdM2" /></label>
            </div>
        </div>
    </div>
    <%--ELIMINAR--%>
    <div class="Modal" id="ModalEliminar">
        <div class="ModalContent">
            <div class="ModalTitle">
                ELIMINAR MODELO
            </div>
            <div class="ModalActions" style="text-align: center">
                <label class="lblMensaje1" id="lblEliminar"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnEliminar" class="btnSuccess" value="Aceptar" />
                <input type="button" class="btnCancel" onclick="ModalFunction('ModalEliminar')" value="Cancelar" />
                <label for="TextoId" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdEliminar" /></label>
            </div>
        </div>
    </div>
    <%--MENSAJES--%>
    <div class="Modal" id="ModalMensaje">
        <div class="ModalContent">
            <div class="ModalTitle">
                SMARTZONE
            </div>
            <div class="ModalActions" style="text-align: center">
                <label id="lblMensaje"></label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAceptar" class="btnSuccess" onclick="ModalFunction('ModalMensaje')" value="Aceptar" />
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
                    <tbody id="CuerpoPro">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalProductos')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>
    <%--CAT GAMA--%>
    <div class="Modal" id="ModalGama">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO GAMA
            </div>
            <div class="Content">
                <table id="TblCatGamas" class="TblForm">
                    <thead>
                        <tr>
                            <th>ID GAMA</th>
                            <th>DESCRIPCION</th>
                            <th>OPCIONES</th>
                        </tr>
                    </thead>
                    <tbody id="CuerpoGam">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalGama')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>

    <%--FIN MODELES--%>
</asp:Content>
