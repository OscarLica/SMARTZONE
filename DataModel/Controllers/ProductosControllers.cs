using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class ProductosControllers
    {
        TblProductos ValidadEntidad = new TblProductos();
        List<Entidad.EntidadProducto> LstProductos = new List<Entidad.EntidadProducto>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();
        //retornamos un producto en especifico
        public Object GetProductoxid(int Parametro)
        {
            var Query = from C in Model.TblProductos
                        where C.Id == Parametro
                        select new { C.Id, C.IdAlmacen, C.IdCategoria, C.IdMarca };
            return Query.ToList();
        }
        //Metodo para Listar Todos los Elementos de Productos
        public List<Entidad.EntidadProducto> GetProductos()
        {
            try
            {
                var Lista = (from P in Model.TblProductos
                             join A in Model.TblAlmacen on P.IdAlmacen equals A.Id
                             join C in Model.TblCategorias on P.IdCategoria equals C.Id
                             join M in Model.TblMarca on P.IdMarca equals M.Id
                             select new Entidad.EntidadProducto
                             {
                                 Id = P.Id,
                                 Almacen = A.Descripcion,
                                 IdCategoria = C.Id,
                                 Categoria = C.Descripcion,
                                 IdMarca = M.Id,
                                 Marca = M.Descripcion
                             }).ToList();

                return Lista;
            }
            catch
            {
                return LstProductos = new List<Entidad.EntidadProducto>();
            }
        }
        //Metodo para Listar Todos los Elementos de Productos Descripcion concatenada
        public List<Entidad.EntidadProducto> GetProductos2()
        {
            try
            {
                LstProductos = new List<Entidad.EntidadProducto>();

                var Lista = (from P in Model.TblProductos
                             join A in Model.TblAlmacen on P.IdAlmacen equals A.Id
                             join C in Model.TblCategorias on P.IdCategoria equals C.Id
                             join M in Model.TblMarca on P.IdMarca equals M.Id
                             select new Entidad.EntidadProducto
                             {
                                 Id = P.Id,
                                 Almacen = A.Descripcion,
                                 IdCategoria = C.Id,
                                 Categoria = C.Descripcion,
                                 IdMarca = M.Id,
                                 Marca = M.Descripcion
                             }).ToList();

                foreach (Entidad.EntidadProducto d in Lista)
                {
                    Entidad.EntidadProducto DT = new Entidad.EntidadProducto();
                    DT = d;
                    if (DT.Marca == "N/A")
                    {
                        DT.Descripcion = d.Categoria;
                    }
                    else
                    {
                        DT.Descripcion = d.Categoria + ' ' + d.Marca;
                    }
                  
                    LstProductos.Add(DT);
                }

                return LstProductos;
            }
            catch
            {
                return LstProductos = new List<Entidad.EntidadProducto>();
            }
        }
        //Metodo para Listar el Producto por parametro
        public List<Entidad.EntidadProducto> GetProductosxParametro(string Parametro)
        {
            try
            {
                //si existe en categoria se retorta
                LstProductos = new List<Entidad.EntidadProducto>();

                try
                {
                    LstProductos = (from P in Model.TblProductos
                                 join A in Model.TblAlmacen on P.IdAlmacen equals A.Id
                                 join C in Model.TblCategorias on P.IdCategoria equals C.Id
                                 join M in Model.TblMarca on P.IdMarca equals M.Id
                                 where C.Descripcion.Contains(Parametro)
                                 select new Entidad.EntidadProducto
                                 {
                                     Id = P.Id,
                                     Almacen = A.Descripcion,
                                     Categoria = C.Descripcion,
                                     Marca = M.Descripcion,
                                 }).ToList();

                    if (LstProductos.Count>=1)
                    {
                        return LstProductos;
                    }
                }
                catch
                {
                    LstProductos = new List<Entidad.EntidadProducto>();
                }

                try
                {
                    LstProductos = (from P in Model.TblProductos
                                    join A in Model.TblAlmacen on P.IdAlmacen equals A.Id
                                    join C in Model.TblCategorias on P.IdCategoria equals C.Id
                                    join M in Model.TblMarca on P.IdMarca equals M.Id
                                    where M.Descripcion.Contains(Parametro)
                                    select new Entidad.EntidadProducto
                                    {
                                        Id = P.Id,
                                        Almacen = A.Descripcion,
                                        Categoria = C.Descripcion,
                                        Marca = M.Descripcion,
                                    }).ToList();

                    if (LstProductos.Count >= 1)
                    {
                        return LstProductos;
                    }
                }
                catch
                {
                    LstProductos = new List<Entidad.EntidadProducto>();
                }

                try
                {
                    //retorna todos los valores en caso que no coinicida el filtro
                    LstProductos = (from P in Model.TblProductos
                                    join A in Model.TblAlmacen on P.IdAlmacen equals A.Id
                                    join C in Model.TblCategorias on P.IdCategoria equals C.Id
                                    join M in Model.TblMarca on P.IdMarca equals M.Id
                                    select new Entidad.EntidadProducto
                                    {
                                        Id = P.Id,
                                        Almacen = A.Descripcion,
                                        Categoria = C.Descripcion,
                                        Marca = M.Descripcion,
                                    }).ToList();

                    return LstProductos;
                }
                catch
                {
                    LstProductos = new List<Entidad.EntidadProducto>();
                }

                return LstProductos;
            }
            catch
            {
                return LstProductos = new List<Entidad.EntidadProducto>();
            }
        }
        //Metodo para Guardar
        public bool Guardar(TblProductos Entidad)
        {
            try
            {
                ValidadEntidad = new TblProductos();
                //validamos si ya existe el producto, no se puede repetir el producto a menos que varie la categoria o marca
                ValidadEntidad = Model.TblProductos.FirstOrDefault(x => x.IdCategoria == Entidad.IdCategoria && x.IdMarca == Entidad.IdMarca);

                if (ValidadEntidad is null)
                {
                    TblProductos _Cat = new TblProductos();
                    _Cat.IdAlmacen = 1;
                    _Cat.IdCategoria = Entidad.IdCategoria;
                    _Cat.IdMarca = Entidad.IdMarca;
                    _Cat.FechaCrea = DateTime.Now;
                    _Cat.IdUsuarioCrea = 1;

                    Model.TblProductos.Add(_Cat);
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
        public bool Actualizar(TblProductos Entidad)
        {
            try
            {
                try
                {
                    //cargamos el producto que coinciden con el filtro.
                    ValidadEntidad = Model.TblProductos.FirstOrDefault(x => x.IdCategoria == Entidad.IdCategoria && x.IdMarca == Entidad.IdMarca);
                }
                catch
                {
                    ValidadEntidad = new TblProductos();
                }
                
                if (ValidadEntidad is null)
                {
                    TblProductos _Cat = Model.TblProductos.FirstOrDefault(x => x.Id == Entidad.Id);
                    //_Cat.IdAlmacen = Entidad.IdAlmacen;
                    _Cat.IdCategoria = Entidad.IdCategoria;
                    _Cat.IdMarca = Entidad.IdMarca;
                    _Cat.FechaModifica = DateTime.Now;
                    _Cat.IdUsuarioModifica = 1;
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
        //Metodo para eliminar
        public bool Eliminar(int id)
        {
            try
            {
                //Si el Producto a Eliminar tiene dependencia en Modelo, no se elimina
                var ListaModelo = (from M in Model.TblModelo
                                   join P in Model.TblProductos on M.IdProducto equals P.Id
                                   where M.IdProducto == id
                                   select new
                                   {
                                       M.Id
                                   }).ToList();

                if (ListaModelo.Count>=1)
                {
                    return false;
                }
                else
                {
                    ValidadEntidad = new TblProductos();
                    ValidadEntidad = Model.TblProductos.FirstOrDefault(x => x.Id == id);
                    Model.TblProductos.Remove(ValidadEntidad);
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
