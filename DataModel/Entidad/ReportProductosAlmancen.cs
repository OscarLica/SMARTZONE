using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class ReportProductosAlmancen
    {
        public int IdAlmacen { get; set; }
        public string Producto { get; set; }
        public int Total { get; set; }
    }
}
