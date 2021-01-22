using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataModel.Controllers;

namespace Interface
{
    public partial class MainProductosAlmacen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod] 
        public static Object CargarProductosAlmacen(int id)
        {
            ProductosAlmacenControllers PA = new ProductosAlmacenControllers();
            return PA.GetProductosAlmacen(id);
        }
        [WebMethod]
        public static Object LiberarProducto(int iddetalle, int idmaestro)
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            return PC.LiberarProducto(iddetalle);
        }
        [WebMethod]
        public static Object DarBaja(int iddetalle, int idmaestro, string motivo)
        {
            ProductosAlmacenDetControllers PAD = new ProductosAlmacenDetControllers();
            PAD.DarBaja(iddetalle, motivo);

            ProductosAlmacenControllers PA = new ProductosAlmacenControllers();
            return PA.GetProductosAlmacen(idmaestro);
        }
        [WebMethod]
        public static Object BuscarProductoxNombre(string Buscar, int id)
        {
            ProductosAlmacenDetControllers PA = new ProductosAlmacenDetControllers();
            return PA.GetProductosAlmacenxparametro(Buscar, id);
        }
        [WebMethod]
        public static Object ModicarProducto(int id, int idDet, int PrecioV)
        {           
            ProductosAlmacenDetControllers PAC = new ProductosAlmacenDetControllers();
            DataModel.TblProductosAlmacenDet _Detalle = new DataModel.TblProductosAlmacenDet();

            _Detalle.Id = idDet;
            _Detalle.PrecioV = PrecioV;

            PAC.Actualizar(_Detalle);       

            ProductosAlmacenControllers PA = new ProductosAlmacenControllers();
            return PA.GetProductosAlmacen(id);
        }

    }
}