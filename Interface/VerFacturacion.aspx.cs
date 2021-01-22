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
    public partial class VerFacturacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static Object ListarFactura(int id)
        {
            FacturaControllers FC = new FacturaControllers();
            //retornamos el detalle
            return FC.GetDetalleFactura(id);
        }
        [WebMethod]
        public static Object Anular(string NumFAC)
        {
            FacturaControllers FC = new FacturaControllers();
            int a = FC.Anular(NumFAC);
            return FC.GetDetalleFactura(a);

        }
        [WebMethod]
        public static Object Valiar(string FechaVence)
        {
            //CONVERTIMOS LAS FECHAS
            //SI LA FECHA DE VENCIMIENTO ES MAYOR A LA FECHA DEL DIA DE ANULACION ENTONCES SE PUEDE ANULAR, CASO CONTRARIO NO PORQ
            //LA FACTURA YA ESTA VENCIDA.
            DateTime Date = Convert.ToDateTime(FechaVence);
            string temp = DateTime.Now.ToString("dd/MM/yyyy");
            DateTime Actual = Convert.ToDateTime(temp);
            if (Date> Actual)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}