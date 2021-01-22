using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class ProveedoresControllers
    {
        TblProveedores ValidadEntidad = new TblProveedores();
        List<TblProveedores> ListaEntidad = new List<TblProveedores>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        public Object GetProveedores()
        {
            var Query = from C in Model.TblProveedores
                        select new { C.Id, C.Descripcion, C.RUC };
            return Query.ToList();
        }
    }
}
