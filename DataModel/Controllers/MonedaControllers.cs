using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class MonedaControllers
    {
        TblMoneda ValidadEntidad = new TblMoneda();
        List<TblMoneda> ListaEntidad = new List<TblMoneda>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        public Object GetMonedas()
        {
            var Query = from C in Model.TblMoneda
                        select new { C.Id, C.Descripcion, C.Simbolo };
            return Query.ToList();
        }

        public Object GetMonedasxNombre(string Moneda)
        {
            var Query = from C in Model.TblMoneda
                        where C.Descripcion.Contains(Moneda)
                        select new { C.Id, C.Descripcion, C.Simbolo };
            return Query.ToList();
        }

        public bool ActualizarMonedas(TblMoneda _TblMoneda)
        {
            try
            {
                if(string.IsNullOrEmpty(_TblMoneda.Descripcion))
                {
                    return false;
                }
                else if(string.IsNullOrEmpty(_TblMoneda.Simbolo))
                {
                    return false;
                }
                else
                {
                    ListaEntidad = new List<TblMoneda>();
                    ListaEntidad = Model.TblMoneda.Where(x => x.Id != _TblMoneda.Id).ToList();

                    foreach (TblMoneda d in ListaEntidad)
                    {
                        TblMoneda DT = new TblMoneda();
                        DT = d;

                        if (DT.Descripcion == _TblMoneda.Descripcion)
                        {
                            return false;
                        }
                    }

                    TblMoneda _Cat = Model.TblMoneda.FirstOrDefault(x => x.Id == _TblMoneda.Id);
                    _Cat.Descripcion = _TblMoneda.Descripcion;
                    _Cat.Simbolo = _TblMoneda.Simbolo;
                    _Cat.FechaModifica = DateTime.Now;
                    _Cat.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        //Metodo para Guardar
        public bool Guardar(TblMoneda Entidad)
        {
            try
            {
                if (string.IsNullOrEmpty(Entidad.Descripcion))
                {
                    return false;
                }
                else if (string.IsNullOrEmpty(Entidad.Simbolo))
                {
                    return false;
                }
                else
                {
                    ValidadEntidad = new TblMoneda();
                    ValidadEntidad = Model.TblMoneda.FirstOrDefault(x => x.Descripcion == Entidad.Descripcion);
                    if (ValidadEntidad is null)
                    {
                        TblMoneda _Cat = new TblMoneda();
                        _Cat.Descripcion = Entidad.Descripcion;
                        _Cat.Simbolo = Entidad.Simbolo;
                        _Cat.FechaCrea = DateTime.Now;
                        _Cat.IdUsuarioCrea = 1;

                        Model.TblMoneda.Add(_Cat);
                        Model.SaveChanges();

                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
