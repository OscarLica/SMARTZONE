using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class ReporteVentas
    {
        public string CodFactura { get; set; }
        public string DatosCliente { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }
        public decimal Iva { get; set; }
        public System.DateTime FechaCrea { get; set; }
    }
}
