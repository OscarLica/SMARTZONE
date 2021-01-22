using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadFactura
    {
        public int Id { get; set; }
        public int IdMoneda { get; set; }
        [NotMapped]
        public string Moneda { get; set; }
        public string CodFactura { get; set; }
        public string DatosCliente { get; set; }
        public string Estado { get; set; }
        //public int Cantidad { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Iva { get; set; }
        public decimal Total { get; set; }
        public int IdUsuarioCrea { get; set; }
        [NotMapped]
        public bool Anulado { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    }
}
