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
    
    public partial class TblMoneda
    {
        public TblMoneda()
        {
            this.TblFactura = new HashSet<TblFactura>();
        }
    
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public string Simbolo { get; set; }
        public int IdUsuarioCrea { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    
        public virtual ICollection<TblFactura> TblFactura { get; set; }
    }
}
