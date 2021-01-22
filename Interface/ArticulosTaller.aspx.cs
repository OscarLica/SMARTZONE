using DataModel.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Interface
{
    public partial class ArticulosTaller : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Object BuscarProductoxNombre(string Producto)
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            return PC.GetProductosAlmacenxNombreTaller(Producto);
        }
    }
}