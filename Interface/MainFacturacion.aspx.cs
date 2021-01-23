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
    public partial class MainFacturacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Object ListarFacturas()
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.ListarFacturas();
        }

        public static Object ProductoGarantia()
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.ProducosGarantia();
        }
        [WebMethod]
        public static Object Buscar(string Parametro)
        {
            FacturaControllers FC = new FacturaControllers();
            return FC.ListarFacturasxParametro(Parametro);
        }
        //[WebMethod]
        //public static Object Anular(int id)
        //{
        //    FacturaControllers FC = new FacturaControllers();
        //    bool a = FC.Anular(id);
        //    //List<DataModel.Entidad.EntidadFactura> lista = new List<DataModel.Entidad.EntidadFactura>();
        //    //List<DataModel.Entidad.EntidadFactura> listaFinal = new List<DataModel.Entidad.EntidadFactura>();
        //    //lista = FC.ListarFacturas();
        //    return FC.ListarFacturas();
        //    //foreach (DataModel.Entidad.EntidadFactura d in lista)
        //    //{
        //    //    DataModel.Entidad.EntidadFactura DT = new DataModel.Entidad.EntidadFactura();
        //    //    DT = d;
        //    //    DT.Anulado = a;
        //    //    listaFinal.Add(DT);
        //    //}
        //    //return listaFinal;
        //}
    }
}