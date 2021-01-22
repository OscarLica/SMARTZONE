using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class GamaControllers
    {
        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        //Metodo para Listar Todos los Elementos de Gama
        public Object GetGamas()
        {
            var Query = from C in Model.TblGama
                        select new { C.Id, C.Descripcion };
            return Query.ToList();
        }
    }
}
