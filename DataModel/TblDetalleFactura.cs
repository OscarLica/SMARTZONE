//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class TblDetalleFactura
    {
        public int Id { get; set; }
        public int IdFactura { get; set; }
        public int Cantidad { get; set; }
        public int Descuento { get; set; }
        public decimal PrecioxUnd { get; set; }
        public decimal Total { get; set; }
        public Nullable<int> GarantiaDias { get; set; }
        public Nullable<System.DateTime> FechaVenceGarantia { get; set; }
    
        public virtual TblFactura TblFactura { get; set; }
    }
}
