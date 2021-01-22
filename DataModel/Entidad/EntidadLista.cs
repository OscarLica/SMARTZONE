using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
    public class EntidadLista
    {
        [NotMapped]
        public int Id { get; set; }
        [NotMapped]
        public string Descripcion { get; set; }

    }
}
