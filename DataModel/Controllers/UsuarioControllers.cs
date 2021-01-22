using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
   public class UsuarioControllers
    {
        BDSMARTZONEEntities _Context;
        public UsuarioControllers()
        {
             _Context = new BDSMARTZONEEntities();
        }
        public TblEmpleado Login(string usuario, string password) {
            var usu = _Context.TblUsuario.FirstOrDefault(x => x.Session == usuario && x.Password == password);
            if (usu is null) return null;

            return _Context.TblEmpleado.Find(usu.IdEmpleado);
        }
    }
}
