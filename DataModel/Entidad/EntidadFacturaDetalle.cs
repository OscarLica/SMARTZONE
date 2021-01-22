using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadFacturaDetalle
    {
        public int Id { get; set; }
        public int IdFactura { get; set; }
        public int IdProductoAlmacenDet { get; set; }
        public int Cantidad { get; set; }
        public int Descuento { get; set; }
        public decimal PrecioxUnd { get; set; }
        public decimal Total { get; set; }
        [NotMapped]
        public string Descripcion { get; set; }
        [NotMapped]
        public string CodFactura { get; set; }
        [NotMapped]
        public decimal SubTotal { get; set; }
        [NotMapped]
        public decimal Iva { get; set; }
        [NotMapped]
        public decimal Total2 { get; set; }
        [NotMapped]
        public int IdModelo { get; set; }
        [NotMapped]
        public string Cliente { get; set; }
        [NotMapped]
        public decimal Efectivo { get; set; }
        [NotMapped]
        public decimal Vuelto { get; set; }
        [NotMapped]
        public DateTime FechaTemporal { get; set; }
        [NotMapped]
        public string FechaFacturacion { get; set; }
        [NotMapped]
        public string Estado { get; set; }
        [NotMapped]
        public string DescProducto { get; set; }
        [NotMapped]
        public string DescModelo { get; set; }
        public Nullable<int> GarantiaDias { get; set; }
        [NotMapped]
        public int IdCategoria { get; set; }
        [NotMapped]
        public int IdProducto { get; set; }
        [NotMapped]
        public int IdDetalleProductosAlmacen { get; set; }
        [NotMapped]
        public int EnExistencia { get; set; }
        [NotMapped]
        public int IdDetFactura { get; set; }
        public Nullable<System.DateTime> FechaVenceGarantia { get; set; }
    }
}
