using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Interface
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Usuario"] == null)
                Response.Redirect("Login.aspx");

            User.Text = "Usuario: " + Session["Usuario"].ToString();
        }
    }
}