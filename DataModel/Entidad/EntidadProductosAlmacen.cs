using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadProductosAlmacen
    {
        public int Id { get; set; }
        public int IdProveedor { get; set; }
        [NotMapped]
        public string Proveedor { get; set; }
        [NotMapped]
        public int CantExistencia { get; set; }
        [NotMapped]
        public string Excento { get; set; }
        public string NumRecibo { get; set; }
        public Nullable<decimal> SubTotal { get; set; }
        public Nullable<decimal> Iva { get; set; }
        public Nullable<bool> ExcentoIva { get; set; }
        public Nullable<decimal> Total { get; set; }
        public int IdUsuarioCrea { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    }
}
