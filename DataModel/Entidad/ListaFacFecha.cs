using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
   public  class ListaFacFecha
    {
        [NotMapped]
        public string CodFac { get; set; }
        [NotMapped]
        public string FechaFac { get; set; }
    }
}
