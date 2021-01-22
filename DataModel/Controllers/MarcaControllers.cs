using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class MarcaControllers
    {
        TblMarca ValidadEntidad = new TblMarca();
        List<TblMarca> ListaEntidad = new List<TblMarca>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        public Object GetMarcas()
        {
            var Query = from C in Model.TblMarca
                        select new { C.Id, C.Descripcion };
            return Query.ToList();
        }
    }
}
