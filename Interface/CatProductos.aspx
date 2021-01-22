<%@ Page Title="Catalogo de Productos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="CatProductos.aspx.cs" Inherits="Interface.CatProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        const Onload = async () => {
            document.getElementById('txtCategoria').value = "";
            document.getElementById('txtMarca').value = "";
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            const url = "CatProductos.aspx/CargarProductos";
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
                let tdAlmacen = document.createElement("td");
                tdAlmacen.append(productos.Almacen);
                let tdCategoria = document.createElement("td");
                tdCategoria.append(productos.Categoria);
                let tdMarca = document.createElement("td");
                tdMarca.append(productos.Marca);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarProductos');
                    document.getElementById('txtIdP').value = productos.Id;
                    document.getElementById('txtIdC2').value = productos.IdCategoria;
                    document.getElementById('txtCategoria2').value = productos.Categoria;
                    document.getElementById('txtIdM2').value = productos.IdMarca;
                    document.getElementById('txtMarca2').value = productos.Marca;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('txtIdEliminar').value = productos.Id;
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL PRODUCTO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdAlmacen, tdCategoria, tdMarca, tdActions);
                Frag.append(tr);
            });
            TblProducto.querySelector("tbody").append(Frag);

            //Asignar eventos
            btnBuscarProductos.addEventListener("click", BuscarProducto);
            btnAgregar.addEventListener("click", Agregar);
            btnAgregarCat.addEventListener("click", AgregarCategoria);  
            btnAgregarMar.addEventListener("click", AgregarMarca); 
            btnAceptar.addEventListener("click", Recargar);  
            btnModificar.addEventListener("click", Modificar); 
            btnAgregarCat2.addEventListener("click", ModificarCategoria);  
            btnAgregarMar2.addEventListener("click", ModificarMarca); 
            btnEliminar.addEventListener("click", Eliminar); 
            //final eventos
        }
        //Buscar 
        const BuscarProducto = async () => {
            document.getElementById('txtCategoria').value = "";
            document.getElementById('txtMarca').value = "";
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "CatProductos.aspx/BuscarProductoxParametro";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                    body: JSON.stringify({ Parametro: txtBuscar.value })
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((productos) => {
                let tr = document.createElement("tr");
                let tdAlmacen = document.createElement("td");
                tdAlmacen.append(productos.Almacen);
                let tdCategoria = document.createElement("td");
                tdCategoria.append(productos.Categoria);
                let tdMarca = document.createElement("td");
                tdMarca.append(productos.Marca);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarProductos');
                    document.getElementById('txtIdP').value = productos.Id;
                    document.getElementById('txtIdC2').value = productos.IdCategoria;
                    document.getElementById('txtCategoria2').value = productos.Categoria;
                    document.getElementById('txtIdM2').value = productos.IdMarca;
                    document.getElementById('txtMarca2').value = productos.Marca;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL PRODUCTO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdAlmacen, tdCategoria, tdMarca, tdActions);
                Frag.append(tr);
            });
            TblProducto.querySelector("tbody").append(Frag);
        }
        //GuardarNuevo
        const Agregar = async () => {
            if (txtCategoria.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'SELECCIONE UNA CATEGORIA';
            }
            else if (txtMarca.value == "") {
                document.getElementById('lblMensajeAgregar').innerHTML = 'SELECCIONE UNA MARCA';
            }
            else {
                const url = "CatProductos.aspx/AgregarProducto";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ IdCategoria: txtIdC.value, IdMarca: txtIdM.value })
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {
                    ModalFunction('ModalAgregarProductos'); //ocultamos el modal
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO AGREGADO CON EXITO';
                }
                else {
                     document.getElementById('lblMensajeAgregar').innerHTML = 'PRODUCTO YA EXISTE, SELECCIONE OTRA CATEGORIA O MARCA';
                }
            }
        }
        //Agregar Categoria
        const AgregarCategoria = async () => {
            document.getElementById('CuerpoCat').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalCategorias'); //ocultamos el modal
            const url = "CatProductos.aspx/ListarCategorias";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((categoria) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(categoria.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(categoria.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalCategorias');
                    document.getElementById('txtIdC').value = categoria.Id;
                    document.getElementById('txtCategoria').value = categoria.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatCategorias.querySelector("tbody").append(Frag);
        }
        //Agregar Marca
        const AgregarMarca = async () => {
            document.getElementById('CuerpoMar').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalMarca'); //ocultamos el modal
            const url = "CatProductos.aspx/ListarMarcas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((marca) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(marca.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(marca.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalMarca');
                    document.getElementById('txtIdM').value = marca.Id;
                    document.getElementById('txtMarca').value = marca.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatMarcas.querySelector("tbody").append(Frag);
        }
        //Cargar Valores de la Grid
        const Recargar = async () => {
            document.getElementById('txtCategoria').value = "";
            document.getElementById('txtMarca').value = "";
            document.getElementById('lblMensajeAgregar').innerHTML = '';
            document.getElementById('lblMensajeModificar').innerHTML = '';
            document.getElementById('Cuerpo').innerHTML = ''; //Aqui limpiamos el la grid
            const url = "CatProductos.aspx/CargarProductos";
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
                let tdAlmacen = document.createElement("td");
                tdAlmacen.append(productos.Almacen);
                let tdCategoria = document.createElement("td");
                tdCategoria.append(productos.Categoria);
                let tdMarca = document.createElement("td");
                tdMarca.append(productos.Marca);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Ver";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalModificarProductos');
                    document.getElementById('txtIdP').value = productos.Id;
                    document.getElementById('txtIdC2').value = productos.IdCategoria;
                    document.getElementById('txtCategoria2').value = productos.Categoria;
                    document.getElementById('txtIdM2').value = productos.IdMarca;
                    document.getElementById('txtMarca2').value = productos.Marca;
                }
                let btnDel = document.createElement("input");
                btnDel.value = "Eliminar";
                btnDel.type = "button";
                btnDel.onclick = () => {
                    ModalFunction('ModalEliminar');
                    document.getElementById('lblEliminar').innerHTML = 'ESTA SEGURO EN ELIMINAR EL PRODUCTO????';
                }
                tdActions.append(btnView, btnDel);
                //apends
                tr.append(tdAlmacen, tdCategoria, tdMarca, tdActions);
                Frag.append(tr);
            });
            TblProducto.querySelector("tbody").append(Frag);
        }
        //Modificar
        const Modificar = async () => {
            if (txtCategoria2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'SELECCIONE UNA CATEGORIA';
            }
            else if (txtMarca2.value == "") {
                document.getElementById('lblMensajeModificar').innerHTML = 'SELECCIONE UNA MARCA';
            }
            else {
                const url = "CatProductos.aspx/ModificarProducto";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ Id: txtIdP.value, IdCategoria: txtIdC2.value, IdMarca: txtIdM2.value })
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {
                    ModalFunction('ModalModificarProductos'); //ocultamos el modal
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO ACTUALIZADO CON EXITO';
                }
                else {
                     document.getElementById('lblMensajeModificar').innerHTML = 'PRODUCTO YA EXISTE, SELECCIONE OTRA CATEGORIA O MARCA';
                }
            }
        }
        //Modificar Categoria
        const ModificarCategoria = async () => {
            document.getElementById('CuerpoCat').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalCategorias'); //ocultamos el modal
            const url = "CatProductos.aspx/ListarCategorias";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((categoria) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(categoria.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(categoria.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalCategorias');
                    document.getElementById('txtIdC2').value = categoria.Id;
                    document.getElementById('txtCategoria2').value = categoria.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatCategorias.querySelector("tbody").append(Frag);
        }
        //Modificar Marca
        const ModificarMarca = async () => {
            document.getElementById('CuerpoMar').innerHTML = ''; //Aqui limpiamos el la grid
            ModalFunction('ModalMarca'); //ocultamos el modal
            const url = "CatProductos.aspx/ListarMarcas";
            let response = await fetch(
                url, {
                    method: "POST",
                    headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
                });
            response = await response.json();
            console.log(response);

            let Frag = document.createDocumentFragment();
            response.d.forEach((marca) => {
                let tr = document.createElement("tr");
                let tdId = document.createElement("td");
                tdId.append(marca.Id);
                let tdDescripcion = document.createElement("td");
                tdDescripcion.append(marca.Descripcion);
                //actions
                let tdActions = document.createElement("td");
                let btnView = document.createElement("input");
                btnView.value = "Agregar";
                btnView.type = "button";
                btnView.onclick = () => {
                    ModalFunction('ModalMarca');
                    document.getElementById('txtIdM2').value = marca.Id;
                    document.getElementById('txtMarca2').value = marca.Descripcion;
                }
                tdActions.append(btnView);
                //apends
                tr.append(tdId, tdDescripcion, tdActions);
                Frag.append(tr);
            });
            TblCatMarcas.querySelector("tbody").append(Frag);
        }
        //Eliminar
        const Eliminar = async () => {
                const url = "CatProductos.aspx/EliminarProducto";
                let response = await fetch(
                    url, {
                        method: "POST",
                        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' },
                        body: JSON.stringify({ Id: txtIdEliminar.value})
                    });
                response = await response.json();
                console.log(response);
                if (response.d == true) {
                    ModalFunction('ModalEliminar'); //ocultamos el modal
                    ModalFunction('ModalMensaje'); //Mostrar Mensaje
                    document.getElementById('lblMensaje').innerHTML = 'REGISTRO ELIMINADO CON EXITO';
                }
                else {
                    document.getElementById('lblEliminar').innerHTML = 'EXISTEN MODELOS QUE DEPENDEN DE ESTE PRODUCTO!, NO SE PUEDE ELIMINAR';                    
                }
        }

        window.onload = Onload;
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="GroupDiv" id="ProductosContainer">
        <div class="ModalTitle">
            LISTA DE PRODUCTOS
        </div>
        <div class="ModalActions">
            <input type="text" value="" class="txtForm" id="txtBuscar" placeholder="Busqueda" />
            <input type="button" id="btnBuscarProductos" class="btnSuccess" value="Buscar" />
        </div>
        <div class="Content">
            <table id="TblProducto" class="TblForm">
                <thead>
                    <tr>
                        <th>ALMACEN</th>
                        <th>CATEGORIA</th>
                        <th>MARCA</th>
                        <th>OPCIONES</th>
                    </tr>
                </thead>
                <tbody id="Cuerpo">
                </tbody>
            </table>
            <div class="ModalActions" style="text-align: center">
                <input type="button" class="btnPrimary" onclick="ModalFunction('ModalAgregarProductos')" value="Agregar" />
                <input type="button" class="btnCancel" onclick="window.location = 'Catalogos.aspx'" value="Regresar" />
            </div>
        </div>
    </div>

    <%--INICIO MODELES--%>

    <%--AGREGAR PRODUCTO--%>
    <div class="Modal" id="ModalAgregarProductos">
        <div class="ModalContentCat">
            <div class="ModalTitle">
                AGREGAR PRODUCTO                
            </div>
            <div style="text-align:center">
                <label class="lblMensaje1" id="lblMensajeAgregar"></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoCategoria">
                    Categoria:<input type="text" class="txtForm1" name="Type" id="txtCategoria" readonly="readonly" />
                    <input type="button" id="btnAgregarCat" class="btnSuccess" value="+" />
                </label>
                <label for="TextoMarca">
                    Marca:<input type="text" class="txtForm1" name="Type" id="txtMarca" readonly="readonly" />
                    <input type="button" id="btnAgregarMar" class="btnSuccess" value="+" />
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnAgregar" class="btnSuccess" value="Agregar" />
                <input type="button" class="btnCancel" onclick="window.location = 'CatProductos.aspx'" value="Cancelar" />
                <label for="TextoIdC" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdC" /></label>
                <label for="TextoIdM" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdM" /></label>
            </div>
        </div>
    </div>
    <%--MODIFICAR PRODUCTO--%>
    <div class="Modal" id="ModalModificarProductos">
        <div class="ModalContentCat">
            <div class="ModalTitle">
                MODIFICAR PRODUCTO
            </div>
            <div style="text-align:center">
                <label class="lblMensaje1" id="lblMensajeModificar"></label>
            </div>
            <div class="ModalActions" style="display: inline-flex; text-align: center">
                <label for="TextoCategoria">
                    Categoria:<input type="text" class="txtForm1" name="Type" id="txtCategoria2" readonly="readonly" />
                    <input type="button" id="btnAgregarCat2" class="btnSuccess" value="+" />
                </label>
                <label for="TextoMarca">
                    Marca:<input type="text" class="txtForm1" name="Type" id="txtMarca2" readonly="readonly" />
                    <input type="button" id="btnAgregarMar2" class="btnSuccess" value="+" />
                </label>
            </div>
            <div class="ModalActions" style="text-align: center">
                <input type="button" id="btnModificar" class="btnSuccess" value="Actualizar" />
                <input type="button" class="btnCancel" onclick="window.location = 'CatProductos.aspx'" value="Cancelar" />
                <label for="TextoIdC" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdC2" /></label>
                <label for="TextoIdM" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdM2" /></label>
                <label for="TextoId" style="visibility: hidden">Id:<input type="text" class="txtForm2" name="Type" id="txtIdP" /></label>
            </div>
        </div>
    </div>
    <%--ELIMINAR--%>
    <div class="Modal" id="ModalEliminar">
        <div class="ModalContent">
            <div class="ModalTitle">
                ELIMINAR PRODUCTO
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
    <%--CAT CATEGORIAS--%>
    <div class="Modal" id="ModalCategorias">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO CATEGORIAS
            </div>
            <div class="Content">
                <table id="TblCatCategorias" class="TblForm">
                    <thead>
                        <tr>
                            <th>ID CATEGORIA</th>
                            <th>DESCRIPCION</th>
                            <th>OPCIONES</th>
                        </tr>
                    </thead>
                    <tbody id="CuerpoCat">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalCategorias')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>
    <%--CAT MARCAS--%>
    <div class="Modal" id="ModalMarca">
        <div class="ModalContent">
            <div class="ModalTitle">
                CATALOGO MARCAS
            </div>
            <div class="Content">
                <table id="TblCatMarcas" class="TblForm">
                    <thead>
                        <tr>
                            <th>ID MARCA</th>
                            <th>DESCRIPCION</th>
                            <th>OPCIONES</th>
                        </tr>
                    </thead>
                    <tbody id="CuerpoMar">
                    </tbody>
                </table>
                <div class="ModalActions" style="text-align: center">
                    <input type="button" class="btnCancel" onclick="ModalFunction('ModalMarca')" value="Cancelar" />
                </div>
            </div>
        </div>
    </div>

    <%--FIN MODELES--%>
</asp:Content>
