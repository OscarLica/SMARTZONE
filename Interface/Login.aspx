<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Interface.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link href="Style/Login.css" rel="stylesheet" />
</head>
<body>
    <div class="main">
        <div class="container">
            <div class="middle">
                <div id="login">
                    <form method="get" runat="server">
                        <fieldset class="clearfix">
                            <asp:Label runat="server" ID="mensaje" style="color:white"></asp:Label>
                            <p><span class="fa fa-user"></span><asp:TextBox runat="server" CssClass="form-control" ID="Username" placeholder="Usuario"></asp:TextBox>
                            <!-- JS because of IE support; better: placeholder="Username" -->
                            <p><span class="fa fa-lock"></span>
                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Password" ID="Password" placeholder="Contraseña"></asp:TextBox>
                            <!-- JS because of IE support; better: placeholder="Password" -->
                            <div>
                                <span style="width: 50%; text-align: right; display: inline-block;">
                                    <asp:Button runat="server" OnClick="Unnamed_Click" Text="Entrar"/></span>
                            </div>
                        </fieldset>
                        <div class="clearfix"></div>
                    </form>
                    <div class="clearfix"></div>
                </div>
                <!-- end login -->
                <div class="logo">SMARTZONE<div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
