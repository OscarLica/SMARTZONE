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
    public partial class Facturacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static Object CargarNumFacFecha()
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.retornarFechaCodProd();
        }
        [WebMethod]
        public static Object ListarMonedas()
        {
            MonedaControllers MC = new MonedaControllers();
            return MC.GetMonedas();
        }
        [WebMethod]
        public static Object ListarProductos()
        {
            ProductosControllers PC = new ProductosControllers();
            return PC.GetProductos2();
        }
        [WebMethod]
        public static Object ListarModelos(string IdProducto)
        {            
            FacturaControllers FC = new FacturaControllers();
            return FC.GetModelosxProducto(IdProducto);
        }
        [WebMethod]
        public static Object ValidarExistencia(int IdModelo)
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.CalcularExistencia(IdModelo);
        }
        [WebMethod]
        public static Object GuardarProducto(int Id, string CodFactura, string DatosCliente, 
                                             int IdProAlmacenDet, int Cantidad, string Descuento, int Precio, int DiasGarantia)
        {

            DataModel.TblFactura _TblFactura = new DataModel.TblFactura();
            DataModel.TblDetalleFactura _TblDetalleFactura = new DataModel.TblDetalleFactura();
            FacturaControllers FC = new FacturaControllers();

            _TblFactura.Id = Id;
            _TblFactura.IdMoneda = 1;
            _TblFactura.CodFactura = CodFactura;
            _TblFactura.DatosCliente = DatosCliente;
            _TblDetalleFactura.Cantidad = Cantidad;
            if(string.IsNullOrEmpty(Descuento) || Descuento == "Seleccione el Descuento")
            {
                _TblDetalleFactura.Descuento = 0;
            }
            else
            {
                _TblDetalleFactura.Descuento = Convert.ToInt32(Descuento);
            }
           
            _TblDetalleFactura.PrecioxUnd = Precio;
            _TblDetalleFactura.GarantiaDias = DiasGarantia;
            //Guardamos el maestro detalle
            int parametro = FC.GuardarMaestroDetalle(_TblFactura, _TblDetalleFactura, IdProAlmacenDet);
            //retornamos el detalle
            return FC.GetDetalleFactura(parametro);
        }
        [WebMethod]
        public static Object EliminarDetalle(int idPam, int IdDet, int Cant)
        {
            FacturaControllers PC = new FacturaControllers();
            bool Revertir = PC.RevertirDetalleAlmacen(IdDet); //hay que revertir el codfactura y estado del detallealmacen.
            bool bandera = PC.EliminarDetalle(IdDet, idPam, Cant);
            return PC.GetDetalleFactura(idPam);
        }
        [WebMethod]
        public static Object Procesar(int idPam, int Parametro, string Efectivo, string Vuelto)
        {
            FacturaControllers PA = new FacturaControllers();
            if (Parametro == 0)
            {                
                return PA.EliminarMaestroDetalle(idPam);
            }
            else
            {
                return PA.Facturar(idPam, Efectivo, Vuelto);
            }
        }
        [WebMethod]
        public static Object BuscarModelo(string Parametro, string IdProducto)
        {
            FacturaControllers MC = new FacturaControllers();
            return MC.GetProductosxParametro(Parametro, IdProducto);
        }
        [WebMethod]
        public static Object Actualizar(int IdCat, int IdDetalleFactura, int Cantidad, string Descuento, int IdModelo)
        {//Tipo = Accesorios u otros
            int intDescuento = 0;
            if (string.IsNullOrEmpty(Descuento) || Descuento == "Seleccione el Descuento")
            {
                intDescuento = 0;
            }
            else
            {
                intDescuento = Convert.ToInt32(Descuento);
            }
            FacturaControllers FC = new FacturaControllers();
            int parametro = FC.ActualizarDetalle(IdCat, IdDetalleFactura, Cantidad, intDescuento, IdModelo);
            //retornamos el detalle
            return FC.GetDetalleFactura(parametro);
        }
        [WebMethod]
        public static Object ValidarExistencia(int IdModelo, string CodFact)
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.CalcularExistencia(IdModelo, CodFact);
        }
    }
}