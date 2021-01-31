using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class ProductosGarantia
    {
        public string Factura { get; set; }
        public string Producto { get; set; }
        public DateTime FechaFinGarantia { get; set; }
        public int DiasRestantes { get; set; }
    }
    public class ProductosMasVendidos
    {
        public string Producto { get; set; }
        public int Cantidad { get; set; }
        public decimal Total { get; set; }
    }
}
