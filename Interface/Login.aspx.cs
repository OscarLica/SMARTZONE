using DataModel.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Interface
{
    public partial class Login : System.Web.UI.Page
    {
        UsuarioControllers usuarioControllers;
        public Login()
        {
            usuarioControllers = new UsuarioControllers();
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            var usuario = usuarioControllers.Login(Username.Text, Password.Text);
            if (usuario is null)
            {
                mensaje.Text = "Usuario y/o contraseña incorrectos.";
                return;
            }


            Session["Usuario"] = $"{usuario.PrimerNombre} {usuario.SegundoNombre} {usuario.PrimerApellido} {usuario.SegundoApellido}";
            Response.Redirect("~/Default.aspx");
        }
    }
}