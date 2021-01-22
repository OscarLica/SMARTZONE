using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadProductoAlmacenDet
    {
        public int Id { get; set; }
        public int IdProductosAlmacen { get; set; }
        public int IdModelo { get; set; }
        [NotMapped]
        public string Modelo { get; set; }
        public string CodProducto { get; set; }
        public string Serie { get; set; }
        public string IMEI { get; set; }
        public bool Estado { get; set; }
        public int PrecioC { get; set; }
        [NotMapped]
        public string SubTotal { get; set; }
        [NotMapped]
        public string Iva { get; set; }
        [NotMapped]
        public string Total { get; set; }
        [NotMapped]
        public string EstadoVenta { get; set; }
        [NotMapped]
        public string GAMA { get; set; }
        [NotMapped]
        public string Caracteristicas { get; set; }
        [NotMapped]
        public int IDPRODUCTO { get; set; }
        [NotMapped]
        public string NOMREPRODUCTO { get; set; }
        public Nullable<int> PrecioV { get; set; }
        public string CodFactura { get; set; }
        public Nullable<System.DateTime> FechaBaja { get; set; }
        public string MotivoBaja { get; set; }
        public int IdUsuarioCrea { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    }
}
