using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataModel.Controllers;

namespace Interface.Modulos.Catalogos
{
    public partial class Moneda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static Object CargarMonedas()
        {
            MonedaControllers MC = new MonedaControllers();
            return MC.GetMonedas();
        }

        [WebMethod]
        public static Object BuscarMonedaxNombre(string Moneda)
        {
            MonedaControllers MC = new MonedaControllers();
            return MC.GetMonedasxNombre(Moneda);
        }

        [WebMethod]
        public static Object ActualizarMoneda(int Id, string Moneda, string Simbolo)
        {
            DataModel.TblMoneda _TblMoneda = new DataModel.TblMoneda();
            MonedaControllers MC = new MonedaControllers();

            _TblMoneda.Id = Id;
            _TblMoneda.Descripcion = Moneda;
            _TblMoneda.Simbolo = Simbolo;

            return MC.ActualizarMonedas(_TblMoneda);
        }

        [WebMethod]
        public static Object AgregarMoneda(string Moneda, string Simbolo)
        {
            DataModel.TblMoneda _TblMoneda = new DataModel.TblMoneda();
            MonedaControllers MC = new MonedaControllers();

            _TblMoneda.Descripcion = Moneda;
            _TblMoneda.Simbolo = Simbolo;

            return MC.Guardar(_TblMoneda);
        }
    }
}