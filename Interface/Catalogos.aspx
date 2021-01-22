<%@ Page Title="Catalogos" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Catalogos.aspx.cs" Inherits="Interface.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="Modulos">
        <a href="CatMonedas.aspx">            
            <img class="Modulos" src="img/Monedas.png" />MONEDAS</a>    
        <br />
        <a href="CatProductos.aspx">            
            <img class="Modulos" src="img/Productos.png" />PRODUCTOS</a>    
        <br />
        <a href="CatModelos.aspx">            
            <img class="Modulos" src="img/Modelos.png" />MODELOS</a>    
        <br />
    </div>
</asp:Content>
