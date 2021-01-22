using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class ReporteCompras
    {
        public string Recibo { get; set; }
        public decimal Total { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Iva { get; set; }
        public DateTime FechaCrea { get; set; }
        public string Proveedor { get; set; }
    }
}
