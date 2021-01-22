using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class ModeloControllers
    {
        TblModelo ValidadEntidad = new TblModelo();
        List<Entidad.EntidadModelo> LstModelos = new List<Entidad.EntidadModelo>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();
        //retornamos un modelo en especifico
        public Object GetModeloxid(int Parametro)
        {
            var Query = from C in Model.TblModelo
                        where C.Id == Parametro
                        select new { C.Id, C.IdProducto, C.IdGama, C.Descripcion, C.Especificaciones };
            return Query.ToList();
        }
        //Metodo para Listar Todos los Elementos de Modelo
        public List<Entidad.EntidadModelo> GetModelos()
        {
            try
            {
                LstModelos = new List<Entidad.EntidadModelo>();

                var Lista = (from M in Model.TblModelo
                             join P in Model.TblProductos on M.IdProducto equals P.Id
                             join G in Model.TblGama on M.IdGama equals G.Id
                             select new Entidad.EntidadModelo
                             {
                                 Id = M.Id,
                                 IdProducto = P.Id,
                                 IdGama = G.Id,
                                 Gama = G.Descripcion,
                                 Descripcion = M.Descripcion,
                                 Especificaciones = M.Especificaciones
                             }).ToList();


                foreach (Entidad.EntidadModelo d in Lista)
                {
                    Entidad.EntidadModelo DT = new Entidad.EntidadModelo();
                    DT = d;

                    TblProductos _TblProductos = new TblProductos();

                    _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IdProducto);


                    DT.Producto = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                    LstModelos.Add(DT);
                }

                return LstModelos;
            }
            catch
            {
                return LstModelos = new List<Entidad.EntidadModelo>();
            }
        }
        //Metodo para Listar el Producto por parametro
        public List<Entidad.EntidadModelo> GetProductosxParametro(string Parametro)
        {
            try
            {
                
                LstModelos = new List<Entidad.EntidadModelo>();
                //si existe en producto se retorta
                try
                {
                    var Lista = (from M in Model.TblModelo
                                  join P in Model.TblProductos on M.IdProducto equals P.Id
                                  join G in Model.TblGama on M.IdGama equals G.Id
                                  where P.TblCategorias.Descripcion.Contains(Parametro) || P.TblMarca.Descripcion.Contains(Parametro)
                                  select new Entidad.EntidadModelo
                                  {
                                      Id = M.Id,
                                      IdProducto = P.Id,
                                      IdGama = G.Id,
                                      Gama = G.Descripcion,
                                      Descripcion = M.Descripcion,
                                      Especificaciones = M.Especificaciones
                                  }).ToList();

                    if (Lista.Count >= 1)
                    {
                        foreach (Entidad.EntidadModelo d in Lista)
                        {
                            Entidad.EntidadModelo DT = new Entidad.EntidadModelo();
                            DT = d;

                            TblProductos _TblProductos = new TblProductos();

                            _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IdProducto);


                            DT.Producto = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                            LstModelos.Add(DT);
                        }

                        return LstModelos;
                    }
                }
                catch
                {
                    LstModelos = new List<Entidad.EntidadModelo>();
                }
                //si existe en Gama se retorta
                try
                {
                    var Lista = (from M in Model.TblModelo
                                  join P in Model.TblProductos on M.IdProducto equals P.Id
                                  join G in Model.TblGama on M.IdGama equals G.Id
                                  where G.Descripcion.Contains(Parametro)
                                  select new Entidad.EntidadModelo
                                  {
                                      Id = M.Id,
                                      IdProducto = P.Id,
                                      IdGama = G.Id,
                                      Gama = G.Descripcion,
                                      Descripcion = M.Descripcion,
                                      Especificaciones = M.Especificaciones
                                  }).ToList();

                    if (Lista.Count >= 1)
                    {
                        foreach (Entidad.EntidadModelo d in Lista)
                        {
                            Entidad.EntidadModelo DT = new Entidad.EntidadModelo();
                            DT = d;

                            TblProductos _TblProductos = new TblProductos();

                            _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IdProducto);


                            DT.Producto = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                            LstModelos.Add(DT);
                        }

                        return LstModelos;
                    }
                }
                catch
                {
                    LstModelos = new List<Entidad.EntidadModelo>();
                }
                //si existe en Modelo se retorta
                try
                {
                    var Lista = (from M in Model.TblModelo
                                 join P in Model.TblProductos on M.IdProducto equals P.Id
                                 join G in Model.TblGama on M.IdGama equals G.Id
                                 where M.Descripcion.Contains(Parametro)
                                 select new Entidad.EntidadModelo
                                 {
                                     Id = M.Id,
                                     IdProducto = P.Id,
                                     IdGama = G.Id,
                                     Gama = G.Descripcion,
                                     Descripcion = M.Descripcion,
                                     Especificaciones = M.Especificaciones
                                 }).ToList();

                    if (Lista.Count >= 1)
                    {
                        foreach (Entidad.EntidadModelo d in Lista)
                        {
                            Entidad.EntidadModelo DT = new Entidad.EntidadModelo();
                            DT = d;

                            TblProductos _TblProductos = new TblProductos();

                            _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IdProducto);


                            DT.Producto = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                            LstModelos.Add(DT);
                        }

                        return LstModelos;
                    }
                }
                catch
                {
                    LstModelos = new List<Entidad.EntidadModelo>();
                }
                //sino hay coincidencia se retorna todos
                try
                {
                    var Lista = (from M in Model.TblModelo
                                  join P in Model.TblProductos on M.IdProducto equals P.Id
                                  join G in Model.TblGama on M.IdGama equals G.Id
                                  where G.Descripcion.Contains(Parametro)
                                  select new Entidad.EntidadModelo
                                  {
                                      Id = M.Id,
                                      IdProducto = P.Id,
                                      IdGama = G.Id,
                                      Gama = G.Descripcion,
                                      Descripcion = M.Descripcion,
                                      Especificaciones = M.Especificaciones
                                  }).ToList();

                    foreach (Entidad.EntidadModelo d in Lista)
                    {
                        Entidad.EntidadModelo DT = new Entidad.EntidadModelo();
                        DT = d;

                        TblProductos _TblProductos = new TblProductos();

                        _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IdProducto);


                        DT.Producto = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                        LstModelos.Add(DT);
                    }

                    return LstModelos;
                }
                catch
                {
                    LstModelos = new List<Entidad.EntidadModelo>();
                }

                return LstModelos;
            }
            catch
            {
                return LstModelos = new List<Entidad.EntidadModelo>();
            }
        }
        //Metodo para Guardar
        public bool Guardar(TblModelo Entidad)
        {
            try
            {
                ValidadEntidad = new TblModelo();
                //validamos si ya existe el Modelo, no se puede repetir a menos que varie la gama o descripcion
                ValidadEntidad = Model.TblModelo.FirstOrDefault(x=>x.IdProducto == Entidad.IdProducto && x.IdGama == Entidad.IdGama && x.Descripcion == Entidad.Descripcion);

                if (ValidadEntidad is null)
                {
                    TblModelo _Cat = new TblModelo();
                    _Cat.IdProducto = Entidad.IdProducto;
                    _Cat.IdGama = Entidad.IdGama;
                    _Cat.Descripcion = Entidad.Descripcion;
                    _Cat.Especificaciones = Entidad.Especificaciones;
                    _Cat.FechaCrea = DateTime.Now;
                    _Cat.IdUsuarioCrea = 1;

                    Model.TblModelo.Add(_Cat);
                    Model.SaveChanges();

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch
            {
                return false;
            }
        }
        //Metodo para Actualizar
        public bool Actualizar(TblModelo Entidad)
        {
            try
            {
                try
                {
                    //cargamos el modelo que coinciden con el filtro.
                    ValidadEntidad = Model.TblModelo.FirstOrDefault(x => x.IdProducto == Entidad.IdProducto && x.IdGama == Entidad.IdGama && x.Descripcion == Entidad.Descripcion);
                }
                catch
                {
                    ValidadEntidad = new TblModelo();
                }

                if (ValidadEntidad is null)
                {
                    //cargamos la entidad a editar
                    TblModelo _Cat = Model.TblModelo.FirstOrDefault(x => x.Id == Entidad.Id);
                    _Cat.IdProducto = Entidad.IdProducto;
                    _Cat.IdGama = Entidad.IdGama;
                    _Cat.Descripcion = Entidad.Descripcion;
                    _Cat.Especificaciones = Entidad.Especificaciones;
                    _Cat.FechaModifica = DateTime.Now;
                    _Cat.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                    return true;
                }
                else
                {
                    //cargamos la entidad a editar
                    TblModelo _Cat = Model.TblModelo.FirstOrDefault(x => x.Id == Entidad.Id);
                    _Cat.IdProducto = Entidad.IdProducto;
                    _Cat.IdGama = Entidad.IdGama;
                    _Cat.Descripcion = Entidad.Descripcion;
                    _Cat.Especificaciones = Entidad.Especificaciones;
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
        //Metodo para eliminar
        public bool Eliminar(int id)
        {
            try
            {
                //Si el Modelo a Eliminar tiene dependencia en ProductosAlmacenDet, no se elimina
                var ListaModelo = (from PAD in Model.TblProductosAlmacenDet
                                   join M in Model.TblModelo on PAD.IdModelo equals M.Id
                                   where PAD.IdModelo == id
                                   select new
                                   {
                                       PAD.Id
                                   }).ToList();

                if (ListaModelo.Count >= 1)
                {
                    return false;
                }
                else
                {
                    ValidadEntidad = new TblModelo();
                    ValidadEntidad = Model.TblModelo.FirstOrDefault(x => x.Id == id);
                    Model.TblModelo.Remove(ValidadEntidad);
                    Model.SaveChanges();

                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
