using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class CategoriasControllers
    {
        TblCategorias ValidadEntidad = new TblCategorias();
        List<TblCategorias> ListaEntidad = new List<TblCategorias>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        public Object GetCategorias()
        {
            var Query = from C in Model.TblCategorias
                        select new { C.Id, C.Descripcion };
            return Query.ToList();
        }
    }
}
