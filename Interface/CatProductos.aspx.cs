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
    public partial class CatProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Object CargarProductos()
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.GetProductos();
        }

        [WebMethod]
        public static Object BuscarProductoxParametro(string Parametro)
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.GetProductosxParametro(Parametro);
        }

        [WebMethod]
        public static Object AgregarProducto(int IdCategoria, int IdMarca)
        {
            DataModel.TblProductos _TblProductos = new DataModel.TblProductos();

            _TblProductos.IdCategoria = IdCategoria;
            _TblProductos.IdMarca = IdMarca;
            ProductosControllers PC = new ProductosControllers();
            return PC.Guardar(_TblProductos);
        }

        [WebMethod]
        public static Object ModificarProducto(int Id, int IdCategoria, int IdMarca)
        {
            DataModel.TblProductos _TblProductos = new DataModel.TblProductos();

            _TblProductos.Id = Id;
            _TblProductos.IdCategoria = IdCategoria;
            _TblProductos.IdMarca = IdMarca;
            ProductosControllers PC = new ProductosControllers();
            return PC.Actualizar(_TblProductos);
        }

        [WebMethod]
        public static Object EliminarProducto(int Id)
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.Eliminar(Id);
        }

        [WebMethod]
        public static Object ListarMarcas()
        {
            MarcaControllers MC = new MarcaControllers();
            return MC.GetMarcas();
        }

        [WebMethod]
        public static Object ListarCategorias()
        {
            CategoriasControllers CC = new CategoriasControllers();
            return CC.GetCategorias();
        }
    }
}