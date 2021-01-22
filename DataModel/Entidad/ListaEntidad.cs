using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Entidad
{
   public  class ListaEntidad
    {
        [NotMapped]
        public string CodProd { get; set; }
        [NotMapped]
        public string IMEI { get; set; }
    }
}
