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
    public partial class CatModelos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static Object CargarModelos()
        {
            ModeloControllers MC = new ModeloControllers();
            return MC.GetModelos();
        }

        [WebMethod]
        public static Object BuscarModelo(string Parametro)
        {
            ModeloControllers MC = new ModeloControllers();
            return MC.GetProductosxParametro(Parametro);
        }

        [WebMethod]
        public static Object ListarProductos()
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.GetProductos2();
        }

        [WebMethod]
        public static Object ListarGamas()
        {
            GamaControllers GC = new GamaControllers();
            return GC.GetGamas();
        }

        [WebMethod]
        public static Object AgregarModelo(int IdProducto, int IdGama, string Modelo, string Caracteristicas)
        {
            DataModel.TblModelo _TblModelo = new DataModel.TblModelo();

            _TblModelo.IdProducto = IdProducto;
            _TblModelo.IdGama = IdGama;
            _TblModelo.Descripcion = Modelo;
            _TblModelo.Especificaciones = Caracteristicas;
            ModeloControllers MC = new ModeloControllers();
            return MC.Guardar(_TblModelo);
        }

        [WebMethod]
        public static Object ModificarModelo(int Id, int IdProducto, int IdGama, string Modelo, string Caracteristicas)
        {
            DataModel.TblModelo _TblModelo = new DataModel.TblModelo();

            _TblModelo.Id = Id;
            _TblModelo.IdProducto = IdProducto;
            _TblModelo.IdGama = IdGama;
            _TblModelo.Descripcion = Modelo;
            _TblModelo.Especificaciones = Caracteristicas;
            ModeloControllers MC = new ModeloControllers();
            return MC.Actualizar(_TblModelo);
        }

        [WebMethod]
        public static Object EliminarModelo(int Id)
        {
            ModeloControllers MC = new ModeloControllers();
            return MC.Eliminar(Id);
        }
    }
}