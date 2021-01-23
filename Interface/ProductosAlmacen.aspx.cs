using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataModel.Controllers;
using DataModel.Entidad;

namespace Interface
{
    public partial class ProductosAlmacen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<ReportProductosAlmancen> ReporteProductosBodega() {
            return new ProductosAlmacenControllers().ReporteProductosAlmacen();
        }

        public List<ReportProductosAlmancen> GenerarReporteProductosBodega()
        {
            return new ProductosAlmacenControllers().ReporteProductosAlmacen();
        }

        [WebMethod]
        public static Object ListarProveedor()
        {
            ProveedoresControllers PC = new ProveedoresControllers();
            return PC.GetProveedores();
        }

        [WebMethod]
        public static Object CargarNumRecibo()
        {
            ProductosAlmacenControllers PAC = new ProductosAlmacenControllers();
            return PAC.GetNumRecibo();
        }

        [WebMethod]
        public static Object CargarNumProductoIMEI()
        {
            ProductosAlmacenDetControllers PADC = new ProductosAlmacenDetControllers();
            return PADC.retornarImeiCodProd();
        }
        [WebMethod]
        public static Object CargarNumProducto()
        {
            ProductosAlmacenDetControllers PADC = new ProductosAlmacenDetControllers();
            return PADC.GetNumProd();
        }
        [WebMethod]
        public static Object ListarProductos()
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.GetProductos2();
        }

        [WebMethod]
        public static Object ListarModelos(int IdProducto)
        {
            ProductosAlmacenDetControllers PADC = new ProductosAlmacenDetControllers();
            return PADC.GetModelosxProducto(IdProducto);
        }

        [WebMethod]
        public static Object GuardarProducto(int Id, int IdProveedor, string NumRec, bool Excento, int IdModelo, string CodProd, string Serie, string IMEI, int PrecioC)
        {

            DataModel.TblProductosAlmacen _TblProductosAlmacen = new DataModel.TblProductosAlmacen();
            DataModel.TblProductosAlmacenDet _TblProductosAlmacenDet = new DataModel.TblProductosAlmacenDet();
            ProductosAlmacenControllers PA = new ProductosAlmacenControllers();

            _TblProductosAlmacen.Id = Id;
            _TblProductosAlmacen.IdProveedor = IdProveedor;
            _TblProductosAlmacen.NumRecibo = NumRec;
            _TblProductosAlmacen.ExcentoIva = Excento;

            _TblProductosAlmacenDet.IdModelo = IdModelo;
            _TblProductosAlmacenDet.Serie = Serie;
            if (string.IsNullOrEmpty(Serie))
            {
                _TblProductosAlmacenDet.Serie = "N/A";
            }
            _TblProductosAlmacenDet.CodProducto = CodProd;
            _TblProductosAlmacenDet.IMEI = IMEI;
            if (string.IsNullOrEmpty(IMEI))
            {
                _TblProductosAlmacenDet.IMEI = "N/A";
            }
            _TblProductosAlmacenDet.PrecioC = PrecioC;
            //Guardamos el maestro detalle
            int parametro = PA.GuardarMaestroDetalle(_TblProductosAlmacen, _TblProductosAlmacenDet);
            //retornamos el detalle
            return PA.GetProductosAlmacen(parametro);
        }

        [WebMethod]
        public static Object ValidarSerieImei(string Serie, string Imei)
        {
            ProductosAlmacenControllers PAC = new ProductosAlmacenControllers();
            return PAC.ValidarSerieImei(Serie, Imei);
        }

        [WebMethod]
        public static Object EliminarDetalle(int idPam, int IdDet)
        {
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            bool bandera = PC.EliminarDetalle(IdDet, idPam);

            ProductosAlmacenControllers PA = new ProductosAlmacenControllers();
            return PA.GetProductosAlmacen(idPam);
        }

        [WebMethod]
        public static Object Procesar(int idPam, int Parametro)
        {
            if (Parametro == 0)
            {
                ProductosAlmacenControllers PA = new ProductosAlmacenControllers();
                return PA.EliminarMaestroDetalle(idPam);
            }
            return true;
        }
    }
}