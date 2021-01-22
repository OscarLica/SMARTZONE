using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadModelo
    {
        public int Id { get; set; }
        public int IdProducto { get; set; }
        [NotMapped]
        public string Producto { get; set; }
        public int IdGama { get; set; }
        [NotMapped]
        public string Gama { get; set; }
        public string Descripcion { get; set; }
        public string Especificaciones { get; set; }
        [NotMapped]
        public Nullable<int> Precio { get; set; }
        [NotMapped]
        public int IdCategoria { get; set; }
        [NotMapped]
        public int cantidadExistencia { get; set; }
        [NotMapped]
        public int IdModelo { get; set; }
        public int IdUsuarioCrea { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    }
}
