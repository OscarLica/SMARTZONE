using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
namespace DataModel.Controllers
{
    public class ProductosAlmacenDetControllers
    {
        TblProductosAlmacenDet _Detalle = new TblProductosAlmacenDet();
        List<Entidad.EntidadProductoAlmacenDet> ListaDetalle = new List<Entidad.EntidadProductoAlmacenDet>();
        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        //Funcion para calcular el consecutivo de N° Producto
        public Object GetNumProd()
        {
            int valor = 600000000; //valor por defecto
            try
            {
                
                TblProductosAlmacenDet _TblProductosAlmacenDet = new TblProductosAlmacenDet();

                var recibo = Model.TblProductosAlmacenDet.OrderByDescending(x => x.Id).First().CodProducto;

                if (recibo is null)
                {
                    return valor;
                }
                else
                {
                    var consecutivo = Convert.ToInt32(recibo) + 1;

                    return consecutivo;
                }
            }
            catch
            {
                return valor;
            }
        }
        //Funcion para calcular el consecutivo de IMEI
        public Object GetIMEI()
        {
            Int64 valor = 355000000000000; //valor por defecto
            try
            {
                var todos = (from PA in Model.TblProductosAlmacenDet
                             where PA.IMEI != "N/A"
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 Id = PA.Id,
                                 IMEI = PA.IMEI
                             }).ToList();

                var recibo = todos.OrderByDescending(x => x.Id).First().IMEI;

                if (recibo is null)
                {
                    return valor;
                }
                else
                {
                    var consecutivo = Convert.ToInt64(recibo) + 1;

                    return consecutivo;
                }
            }
            catch
            {
                return valor;
            }
        }
        //Metodo para Listar Todos los Elementos de Modelo por IdProducto
        public /*List<Entidad.EntidadModelo>*/ Object GetModelosxProducto(int idproducto)
        {
            try
            {
                var Lista = (from M in Model.TblModelo
                             join P in Model.TblProductos on M.IdProducto equals P.Id
                             join G in Model.TblGama on M.IdGama equals G.Id
                             where M.IdProducto == idproducto
                             select new Entidad.EntidadModelo
                             {
                                 Id = M.Id,
                                 IdProducto = P.Id,
                                 IdGama = G.Id,
                                 Gama = G.Descripcion,
                                 Descripcion = M.Descripcion,
                                 Especificaciones = M.Especificaciones
                             }).ToList();
                return Lista;
            }
            catch
            {
                return null;
            }
        }
        //Metodo para Listar Todos los Elementos por filtro, se usa en MainProdcutosAlmacen
        public List<Entidad.EntidadProductoAlmacenDet> GetProductosAlmacenxparametro(string Parametro, int id)
        {
            try
            {
                ListaDetalle = new List<Entidad.EntidadProductoAlmacenDet>();
                if (string.IsNullOrEmpty(Parametro))
                {
                    //buscar por parametro vacio
                    var todos = (from PA in Model.TblProductosAlmacenDet
                                       join M in Model.TblModelo on PA.IdModelo equals M.Id
                                       where PA.IdProductosAlmacen == id
                                       select new Entidad.EntidadProductoAlmacenDet
                                       {
                                           Id = PA.Id,
                                           IdModelo = PA.IdModelo,
                                           Modelo = M.Descripcion,
                                           CodProducto = PA.CodProducto,
                                           Serie = PA.Serie,
                                           IMEI = PA.IMEI,
                                           PrecioC = PA.PrecioC,
                                           PrecioV = PA.PrecioV,
                                           MotivoBaja = PA.MotivoBaja,
                                           GAMA = M.TblGama.Descripcion,
                                           Caracteristicas = M.Especificaciones
                                       }).ToList();

                    if (todos.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductoAlmacenDet d in todos)
                        {
                            Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                            DT = d;
                            if (d.MotivoBaja != null)
                            {
                                DT.EstadoVenta = "DE BAJA";
                            }
                            else if (d.Estado == true)
                            {
                                DT.EstadoVenta = "VENDIDO";
                            }
                            else
                            {
                                DT.EstadoVenta = "NO VENDIDO";
                            }

                            TblProductos _TblProductos = new TblProductos();

                            _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                            DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                            ListaDetalle.Add(DT);
                        }
                        return ListaDetalle;
                    }
                }

                //buscar por codproducto
                var CodProducto = (from PA in Model.TblProductosAlmacenDet
                             join M in Model.TblModelo on PA.IdModelo equals M.Id
                             where PA.IdProductosAlmacen == id && PA.CodProducto.Contains(Parametro)
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 Id = PA.Id,
                                 IdModelo = PA.IdModelo,
                                 Modelo = M.Descripcion,
                                 CodProducto = PA.CodProducto,
                                 Serie = PA.Serie,
                                 IMEI = PA.IMEI,
                                 PrecioC = PA.PrecioC,
                                 PrecioV = PA.PrecioV,
                                 MotivoBaja = PA.MotivoBaja,
                                 GAMA = M.TblGama.Descripcion,
                                 Caracteristicas = M.Especificaciones
                             }).ToList();

                if(CodProducto.Count>=1)
                {
                    foreach (Entidad.EntidadProductoAlmacenDet d in CodProducto)
                    {
                        Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                        DT = d;
                        if (d.MotivoBaja != null)
                        {
                            DT.EstadoVenta = "DE BAJA";
                        }
                        else if (d.Estado == true)
                        {
                            DT.EstadoVenta = "VENDIDO";
                        }
                        else
                        {
                            DT.EstadoVenta = "NO VENDIDO";
                        }

                        TblProductos _TblProductos = new TblProductos();

                        _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                        DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                        ListaDetalle.Add(DT);
                    }
                    return ListaDetalle;
                }
                //buscar por serie
                var ListaSerie = (from PA in Model.TblProductosAlmacenDet
                                   join M in Model.TblModelo on PA.IdModelo equals M.Id
                                   where PA.IdProductosAlmacen == id && PA.Serie.Contains(Parametro)
                                   select new Entidad.EntidadProductoAlmacenDet
                                   {
                                       Id = PA.Id,
                                       IdModelo = PA.IdModelo,
                                       Modelo = M.Descripcion,
                                       CodProducto = PA.CodProducto,
                                       Serie = PA.Serie,
                                       IMEI = PA.IMEI,
                                       PrecioC = PA.PrecioC,
                                       PrecioV = PA.PrecioV,
                                       MotivoBaja = PA.MotivoBaja,
                                       GAMA = M.TblGama.Descripcion,
                                       Caracteristicas = M.Especificaciones
                                   }).ToList();

                if (ListaSerie.Count >= 1)
                {
                    foreach (Entidad.EntidadProductoAlmacenDet d in ListaSerie)
                    {
                        Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                        DT = d;
                        if (d.MotivoBaja != null)
                        {
                            DT.EstadoVenta = "DE BAJA";
                        }
                        else if (d.Estado == true)
                        {
                            DT.EstadoVenta = "VENDIDO";
                        }
                        else
                        {
                            DT.EstadoVenta = "NO VENDIDO";
                        }

                        TblProductos _TblProductos = new TblProductos();

                        _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                        DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                        ListaDetalle.Add(DT);
                    }
                    return ListaDetalle;
                }
                //buscar por todos
                var Lista = (from PA in Model.TblProductosAlmacenDet
                                  join M in Model.TblModelo on PA.IdModelo equals M.Id
                                  where PA.IdProductosAlmacen == id && PA.Serie.Contains(Parametro)
                                  select new Entidad.EntidadProductoAlmacenDet
                                  {
                                      Id = PA.Id,
                                      IdModelo = PA.IdModelo,
                                      Modelo = M.Descripcion,
                                      CodProducto = PA.CodProducto,
                                      Serie = PA.Serie,
                                      IMEI = PA.IMEI,
                                      PrecioC = PA.PrecioC,
                                      PrecioV = PA.PrecioV,
                                      MotivoBaja = PA.MotivoBaja,
                                      GAMA = M.TblGama.Descripcion,
                                      Caracteristicas = M.Especificaciones
                                  }).ToList();

                if (Lista.Count >= 1)
                {
                    foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                    {
                        Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                        DT = d;
                        if (d.MotivoBaja != null)
                        {
                            DT.EstadoVenta = "DE BAJA";
                        }
                        else if (d.Estado == true)
                        {
                            DT.EstadoVenta = "VENDIDO";
                        }
                        else
                        {
                            DT.EstadoVenta = "NO VENDIDO";
                        }

                        TblProductos _TblProductos = new TblProductos();

                        _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                        DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                        ListaDetalle.Add(DT);
                    }
                    return ListaDetalle;
                }

                return ListaDetalle;
            }
            catch
            {
                return ListaDetalle;
            }
        }
        //DarBaja 
        public Object DarBaja(int Id, string motivo)
        {
            _Detalle = new TblProductosAlmacenDet();

            _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x=>x.Id == Id);

            _Detalle.MotivoBaja = motivo;
            _Detalle.Estado = false;            
            _Detalle.FechaModifica = DateTime.Now;
            _Detalle.IdUsuarioModifica = 1;
            Model.SaveChanges();

            //sumamos a Almacen el producto que se da de baja
            ProductosAlmacenControllers PC = new ProductosAlmacenControllers();
            PC.ActualizarBodega("sumar");

            return true;
        }
        //Metodo para Actualizar
        public bool Actualizar(TblProductosAlmacenDet Entidad)
        {
            try
            {
                try
                {
                    //cargamos el producto que coinciden con el filtro.
                    _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == Entidad.Id);
                }
                catch
                {
                    _Detalle = new TblProductosAlmacenDet();
                }

                _Detalle.PrecioV = Entidad.PrecioV;
                _Detalle.FechaModifica = DateTime.Now;
                _Detalle.IdUsuarioModifica = 1;
                Model.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
        //ListarEntidad CodProd e IMEI
        public Entidad.ListaEntidad retornarImeiCodProd()
        {
            List<Entidad.ListaEntidad> _ListaEntidad = new List<Entidad.ListaEntidad>();

            var numProd = GetNumProd();
            var numImei = GetIMEI();

            try
            {
                Entidad.ListaEntidad E = new Entidad.ListaEntidad();
                for (int x = 0; x < 1; x++)
                {
                    
                    E.CodProd =Convert.ToString(numProd);
                    E.IMEI = Convert.ToString(numImei);
                }
                return E;
            }
            catch
            {
                return null;
            }
        }

    }
}
