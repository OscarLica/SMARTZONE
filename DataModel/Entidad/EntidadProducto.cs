using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadProducto
    {
        public int Id { get; set; }
        public int IdAlmacen { get; set; }
        [NotMapped]
        public string Almacen { get; set; }
        public int IdCategoria { get; set; }
        [NotMapped]
        public string Categoria { get; set; }
        public int IdMarca { get; set; }
        [NotMapped]
        public string Marca { get; set; }
        [NotMapped]
        public string Descripcion { get; set; }
        public int IdUsuarioCrea { get; set; }
        public Nullable<int> IdUsuarioModifica { get; set; }
        public System.DateTime FechaCrea { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
    }
}
