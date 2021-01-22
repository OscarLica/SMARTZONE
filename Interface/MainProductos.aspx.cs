using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataModel.Controllers;

namespace Interface.Modulos.Productos
{
    public partial class MainProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Object CargarProductos()
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            return PC.GetProductos();
        }
        [WebMethod]
        public static Object CargarProductosTaller()
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            return PC.GetProductosTaller();
        }

        [WebMethod]
        public static Object BuscarProductoxNombre(string Producto)
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            return PC.GetProductosAlmacenxNombre(Producto);
        }
    }
}