using DataModel.Entidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class ProductosAlmacenControllers
    {
        TblProductosAlmacen ValidadEntidad = new TblProductosAlmacen();
        List<Entidad.EntidadProductoAlmacenDet> LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();

        public List<ReportProductosAlmancen> ReporteProductosAlmacen()
        {
            var query = (from al in Model.TblProductosAlmacen
                         join pad in Model.TblProductosAlmacenDet on al.Id equals pad.IdProductosAlmacen
                         join modelo in Model.TblModelo on pad.IdModelo equals modelo.Id
                         join producto in Model.TblProductos on modelo.IdProducto equals producto.Id
                         join mar in Model.TblMarca on producto.IdMarca equals mar.Id
                         join cat in Model.TblCategorias on producto.IdCategoria equals cat.Id
                         group new { al, cat, modelo, mar } by new { al.Id, idcat = cat.Id, idmol = modelo.Id, idmar = mar.Id, cat.Descripcion, mdes = modelo.Descripcion, marDes = mar.Descripcion } into gr
                         select new ReportProductosAlmancen
                         {
                             IdAlmacen = gr.Key.Id,
                             Producto = gr.Key.Descripcion + " " + gr.Key.mdes + " " + gr.Key.marDes,
                             Total = gr.Count()
                         }).ToList();

            return query;
        }
        //Funcion para calcular el consecutivo de N° Recibo
        public Object GetNumRecibo()
        {
            int valor = 500000000; //valor por defecto

            try
            {
                TblProductosAlmacen _TblProductosAlmacen = new TblProductosAlmacen();

                var recibo = Model.TblProductosAlmacen.OrderByDescending(x => x.Id).First().NumRecibo;

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
        //Metodo para Guardar MaestroDetalle
        public int GuardarMaestroDetalle(TblProductosAlmacen _TblProductosAlmacen, TblProductosAlmacenDet _TblProductosAlmacenDet)
        {
            try
            {
                ValidadEntidad = new TblProductosAlmacen();
                int IdProductosAlmacen = 0;
                decimal iva = 0;
                decimal Total = 0;
                decimal SubTotal = 0;

                try
                {
                    ValidadEntidad = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == _TblProductosAlmacen.Id);
                }
                catch
                {
                    ValidadEntidad = new TblProductosAlmacen();
                }

                if (ValidadEntidad is null) //se agrega solamente la primera vez
                {
                    TblProductosAlmacen _Maestro = new TblProductosAlmacen();
                    _Maestro.IdProveedor = _TblProductosAlmacen.IdProveedor;
                    _Maestro.NumRecibo = _TblProductosAlmacen.NumRecibo;
                    _Maestro.SubTotal = _TblProductosAlmacenDet.PrecioC;
                    if (_TblProductosAlmacen.ExcentoIva == true) //tiene que pagar iva
                    {
                        iva = Convert.ToDecimal(_TblProductosAlmacenDet.PrecioC * 0.15);
                        Total = Convert.ToDecimal(_TblProductosAlmacenDet.PrecioC + iva);

                        _Maestro.Iva = iva;// _TblProductosAlmacen.Iva;
                        _Maestro.Total = Total;
                    }
                    else
                    {
                        _Maestro.Iva = iva;
                        _Maestro.Total = _TblProductosAlmacenDet.PrecioC;
                    }
                    _Maestro.ExcentoIva = _TblProductosAlmacen.ExcentoIva;
                    _Maestro.FechaCrea = DateTime.Now;
                    _Maestro.IdUsuarioCrea = 1;

                    Model.TblProductosAlmacen.Add(_Maestro);
                    Model.SaveChanges();
                }

                //Calculamos el iva, Total y SubTotal y actualizamos dichos registros en el Maestro


                //obtenemos el ultimo ID de producto
                if (ValidadEntidad is null)
                {
                    IdProductosAlmacen = Model.TblProductosAlmacen.OrderByDescending(x => x.Id).FirstOrDefault().Id;
                }
                else
                {
                    TblProductosAlmacen _Maestro2 = new TblProductosAlmacen();
                    _Maestro2 = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == ValidadEntidad.Id);
                    IdProductosAlmacen = ValidadEntidad.Id;//id a retornar

                    if (_TblProductosAlmacen.ExcentoIva == true) //tiene que pagar iva
                    {
                        SubTotal = Convert.ToDecimal(ValidadEntidad.SubTotal + _TblProductosAlmacenDet.PrecioC);
                        iva = Convert.ToDecimal(SubTotal * Convert.ToDecimal(0.15));
                        Total = Convert.ToDecimal(SubTotal + iva);

                        _Maestro2.SubTotal = SubTotal;
                        _Maestro2.Iva = iva;
                        _Maestro2.Total = Total;
                    }
                    else
                    {
                        SubTotal = Convert.ToDecimal(ValidadEntidad.SubTotal + _TblProductosAlmacenDet.PrecioC);
                        _Maestro2.SubTotal = SubTotal;
                        _Maestro2.Iva = iva;
                        _Maestro2.Total = SubTotal;
                    }

                    _Maestro2.FechaModifica = DateTime.Now;
                    _Maestro2.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                }
                //guardamos el detalle
                TblProductosAlmacenDet _Detalle = new TblProductosAlmacenDet();
                _Detalle.IdProductosAlmacen = IdProductosAlmacen;
                _Detalle.IdModelo = _TblProductosAlmacenDet.IdModelo;
                _Detalle.CodProducto = _TblProductosAlmacenDet.CodProducto;
                _Detalle.Serie = _TblProductosAlmacenDet.Serie;
                _Detalle.IMEI = _TblProductosAlmacenDet.IMEI;
                _Detalle.Estado = true;
                _Detalle.PrecioC = _TblProductosAlmacenDet.PrecioC;

                _Detalle.FechaCrea = DateTime.Now;
                _Detalle.IdUsuarioCrea = 1;

                Model.TblProductosAlmacenDet.Add(_Detalle);
                Model.SaveChanges();

                ActualizarBodega("restar"); //restamos el espacio en bodega que se va agregar en la existencia durante este proceso.

                return IdProductosAlmacen; //true;
            }
            catch
            {
                return 0;
            }
        }

        public List<Entidad.EntidadProductoAlmacenDet> GetProductosAlmacenxparametro(string Parametro, int id)
        {
            var ListaDetalle = new List<Entidad.EntidadProductoAlmacenDet>();
            try
            {

                if (string.IsNullOrEmpty(Parametro))
                {
                    //buscar por parametro vacio
                    var todos = (from PA in Model.TblProductosAlmacenDet
                                 join M in Model.TblModelo on PA.IdModelo equals M.Id
                                 where PA.IdProductosAlmacen == id && !PA.Estado
                                 select new Entidad.EntidadProductoAlmacenDet
                                 {
                                     IDPRODUCTO = PA.IdProductosAlmacen,
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
                                   where PA.IdProductosAlmacen == id && PA.CodProducto.Contains(Parametro) && !PA.Estado
                                   select new Entidad.EntidadProductoAlmacenDet
                                   {
                                       IDPRODUCTO = PA.IdProductosAlmacen,
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

                if (CodProducto.Count >= 1)
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
                                  where PA.IdProductosAlmacen == id && PA.Serie.Contains(Parametro) && !PA.Estado
                                  select new Entidad.EntidadProductoAlmacenDet
                                  {
                                      IDPRODUCTO = PA.IdProductosAlmacen,
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
                             && !PA.Estado
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 IDPRODUCTO = PA.IdProductosAlmacen,
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
            catch (Exception e)
            {
                return ListaDetalle;
            }
        }
        public List<Entidad.EntidadProductoAlmacenDet> GetProductosAlmacenTaller(int id)
        {
            try
            {
                //int suma = CalcularPrecioCompra(id);
                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

                var Lista = (from PA in Model.TblProductosAlmacenDet
                             join M in Model.TblModelo on PA.IdModelo equals M.Id
                             where PA.IdProductosAlmacen == id && !PA.Estado
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 Id = PA.Id,
                                 IdModelo = PA.IdModelo,
                                 IDPRODUCTO = M.IdProducto,
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

                ValidadEntidad = new TblProductosAlmacen();

                ValidadEntidad = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == id);

                foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                {
                    Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                    DT = d;
                    DT.IdProductosAlmacen = ValidadEntidad.Id;
                    DT.SubTotal = Convert.ToString(ValidadEntidad.SubTotal);
                    DT.Iva = Convert.ToString(ValidadEntidad.Iva);
                    DT.Total = Convert.ToString(ValidadEntidad.Total);

                    TblProductosAlmacenDet Det = new TblProductosAlmacenDet();
                    Det = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);

                    if (Det.MotivoBaja != null)//d.MotivoBaja!= null)
                    {
                        DT.EstadoVenta = "DE BAJA";
                    }
                    else if (Det.Estado == true)//(d.Estado == true)
                    {
                        DT.EstadoVenta = "NO VENDIDO";
                    }
                    else
                    {
                        DT.EstadoVenta = "VENDIDO";
                    }
                    if (d.PrecioV is null)
                    {
                        d.PrecioV = 0;
                    }

                    TblProductos _TblProductos = new TblProductos();

                    _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                    DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                    LstProductos.Add(DT);
                }

                return LstProductos;
            }
            catch
            {
                return LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();
            }
        }
        //Metodo para Listar Todos los Elementos de ProductosAlmacen y su Detalle
        public List<Entidad.EntidadProductoAlmacenDet> GetProductosAlmacen(int id)
        {
            try
            {
                //int suma = CalcularPrecioCompra(id);
                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

                var Lista = (from PA in Model.TblProductosAlmacenDet
                             join M in Model.TblModelo on PA.IdModelo equals M.Id
                             where PA.IdProductosAlmacen == id && PA.Estado
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 Id = PA.Id,
                                 IdModelo = PA.IdModelo,
                                 IDPRODUCTO = M.IdProducto,
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

                ValidadEntidad = new TblProductosAlmacen();

                ValidadEntidad = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == id);

                foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                {
                    Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                    DT = d;
                    DT.IdProductosAlmacen = ValidadEntidad.Id;
                    DT.SubTotal = Convert.ToString(ValidadEntidad.SubTotal);
                    DT.Iva = Convert.ToString(ValidadEntidad.Iva);
                    DT.Total = Convert.ToString(ValidadEntidad.Total);

                    TblProductosAlmacenDet Det = new TblProductosAlmacenDet();
                    Det = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);

                    if (!string.IsNullOrEmpty(Det.MotivoBaja))//d.MotivoBaja!= null)
                    {
                        DT.EstadoVenta = "DE BAJA";
                    }
                    else if (Det.Estado == true)//(d.Estado == true)
                    {
                        DT.EstadoVenta = "NO VENDIDO";
                    }
                    else
                    {
                        DT.EstadoVenta = "VENDIDO";
                    }
                    if (d.PrecioV is null)
                    {
                        d.PrecioV = 0;
                    }

                    TblProductos _TblProductos = new TblProductos();

                    _TblProductos = Model.TblProductos.FirstOrDefault(x => x.Id == d.IDPRODUCTO);


                    DT.NOMREPRODUCTO = _TblProductos.TblCategorias.Descripcion + ' ' + _TblProductos.TblMarca.Descripcion;

                    LstProductos.Add(DT);
                }

                return LstProductos;
            }
            catch
            {
                return LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();
            }
        }
        //ValidarSerieImei
        public bool ValidarSerieImei(string paramSerie, string paramImei)
        {
            try
            {
                //validamos la serie
                var Serie = from C in Model.TblProductosAlmacenDet
                            where C.Serie == paramSerie
                            select new { C.Id };

                int valorS = Serie.Count();

                if (valorS >= 1)
                {
                    return true;
                }

                //validamos el imei
                var Imei = from C in Model.TblProductosAlmacenDet
                           where C.IMEI == paramImei
                           select new { C.Id };

                int valorI = Imei.Count();

                if (valorI >= 1)
                {
                    return true;
                }

                return false; //no existe serie ni imei
            }
            catch
            {
                return true;
            }
        }
        //Metodo para eliminar
        public bool EliminarDetalle(int iddetalle, int idmaestro)
        {
            try
            {
                ActualizarBodega("sumar"); //sumamos el espacio en bodega que se va eliminar en la existencia durante este proceso.

                //instanciamos las entidades
                TblProductosAlmacenDet Detalle = new TblProductosAlmacenDet();
                ValidadEntidad = new TblProductosAlmacen();
                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();
                TblProductosAlmacen _Maestro = new TblProductosAlmacen();

                int vPrecio = 0;

                //eliminamos el registro
                Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == iddetalle);
                vPrecio = Detalle.PrecioC;
                Model.TblProductosAlmacenDet.Remove(Detalle);
                Model.SaveChanges();

                //cargamos el Maestro
                ValidadEntidad = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == idmaestro);


                if (ValidadEntidad.ExcentoIva == true) //recalculamos el iva
                {
                    decimal resta = Convert.ToDecimal(ValidadEntidad.SubTotal) - Convert.ToDecimal(vPrecio);
                    decimal iva = Convert.ToDecimal(resta) * Convert.ToDecimal(0.15);
                    decimal Total = Convert.ToDecimal(resta + iva);

                    ValidadEntidad.SubTotal = resta;
                    ValidadEntidad.Iva = iva;
                    ValidadEntidad.Total = Total;
                    ValidadEntidad.FechaModifica = DateTime.Now;
                    ValidadEntidad.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                }
                else //recalculamos los valores
                {
                    decimal resta = Convert.ToDecimal(ValidadEntidad.SubTotal) - Convert.ToDecimal(vPrecio);

                    ValidadEntidad.SubTotal = resta;
                    ValidadEntidad.Total = resta;
                    ValidadEntidad.FechaModifica = DateTime.Now;
                    ValidadEntidad.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        //Actualizamos el espacio disponible en Bodega
        public Object ActualizarBodega(string bandera)
        {
            try
            {
                int operacion = 0;

                //int parametro = Lista.Count();
                TblAlmacen _Cat = Model.TblAlmacen.FirstOrDefault(x => x.Id == 1);

                if (bandera == "restar")
                {
                    operacion = _Cat.Disponible - 1;
                }
                else if (bandera == "sumar")
                {
                    operacion = _Cat.Disponible + 1;
                }
                else
                {
                    operacion = _Cat.Disponible + 1;
                }

                _Cat.Disponible = operacion;
                _Cat.FechaModifica = DateTime.Now;
                _Cat.IdUsuarioModifica = 1;
                Model.SaveChanges();
                return true;

            }
            catch (Exception)
            {
                throw;
            }
        }
        //Metodo para eliminar MaestroDetalle
        public bool EliminarMaestroDetalle(int id)
        {
            try
            {
                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

                var Lista = (from PA in Model.TblProductosAlmacenDet
                             where PA.IdProductosAlmacen == id
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 Id = PA.Id
                             }).ToList();

                int contador = Lista.Count();

                ActualizarBodega2(contador); //sumamos los espacio en bodega que se habian usado durante este proceso creado.

                //eliminarmos el detalle
                foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                {
                    TblProductosAlmacenDet _Detalle = new TblProductosAlmacenDet();
                    _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);
                    Model.TblProductosAlmacenDet.Remove(_Detalle);
                    Model.SaveChanges();
                }
                //eliminamos el maestro 
                ValidadEntidad = new TblProductosAlmacen();
                ValidadEntidad = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == id);
                Model.TblProductosAlmacen.Remove(ValidadEntidad);
                Model.SaveChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        //Actualizamos el espacio disponible en Bodega, se usa cuando cancelamos un proceso
        public Object ActualizarBodega2(int parametro)
        {
            try
            {
                TblAlmacen _Cat = Model.TblAlmacen.FirstOrDefault(x => x.Id == 1);
                int resta = _Cat.Disponible + parametro;

                _Cat.Disponible = resta;
                _Cat.FechaModifica = DateTime.Now;
                _Cat.IdUsuarioModifica = 1;
                Model.SaveChanges();
                return true;

            }
            catch (Exception)
            {
                throw;
            }
        }

        //Funcion para calcular cuantos productos hay en existencia
        public int Existencia(int param, bool estado = true)
        {
            int _TblProductosAlmacen = 0;
            return _TblProductosAlmacen = Model.TblProductosAlmacenDet.Where(x => x.IdProductosAlmacen == param && x.Estado == estado).Count();
        }
        //Lista los productosalmacen, se usa en el mainproductos
        public List<Entidad.EntidadProductosAlmacen> GetProductos()
        {
            try
            {
                List<Entidad.EntidadProductosAlmacen> ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();

                var Lista = (from PA in Model.TblProductosAlmacen
                             join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                             select new Entidad.EntidadProductosAlmacen
                             {
                                 Id = PA.Id,
                                 IdProveedor = P.Id,
                                 Proveedor = P.Descripcion,
                                 NumRecibo = PA.NumRecibo,
                                 ExcentoIva = PA.ExcentoIva
                             }).ToList();

                foreach (Entidad.EntidadProductosAlmacen d in Lista)
                {
                    Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                    DT = d;
                    DT.CantExistencia = Existencia(d.Id);

                    if (d.ExcentoIva == true)
                    {
                        DT.Excento = "NO EXCENTO";
                    }
                    else
                    {
                        DT.Excento = "EXCENTO";
                    }

                    ListaMaestro.Add(DT);
                }

                return ListaMaestro;
            }
            catch
            {
                return null;
            }
        }
        public List<Entidad.EntidadProductosAlmacen> GetProductosTaller()
        {
            try
            {
                List<Entidad.EntidadProductosAlmacen> ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();

                var Lista = (from PA in Model.TblProductosAlmacen
                             let det = (from pad in Model.TblProductosAlmacenDet
                                        where pad.IdProductosAlmacen == PA.Id && !pad.Estado
                                        select pad)
                             join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                             where det.Any()
                             select new Entidad.EntidadProductosAlmacen
                             {
                                 Id = PA.Id,
                                 IdProveedor = P.Id,
                                 Proveedor = P.Descripcion,
                                 NumRecibo = PA.NumRecibo,
                                 ExcentoIva = PA.ExcentoIva
                             }).ToList();

                foreach (Entidad.EntidadProductosAlmacen d in Lista)
                {
                    Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                    DT = d;
                    DT.CantExistencia = Existencia(d.Id, false);

                    if (d.ExcentoIva == true)
                    {
                        DT.Excento = "NO EXCENTO";
                    }
                    else
                    {
                        DT.Excento = "EXCENTO";
                    }

                    ListaMaestro.Add(DT);
                }

                return ListaMaestro;
            }
            catch
            {
                return null;
            }
        }
        //Lista los productosalmacen por filtro, se usa en el mainproductos
        public List<Entidad.EntidadProductosAlmacen> GetProductosAlmacenxNombre(string Producto)
        {
            try
            {
                List<Entidad.EntidadProductosAlmacen> ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();

                try
                {
                    //Buscar por Proveedor
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        where P.Descripcion.Contains(Producto)
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                try
                {

                    //Buscar por NumeroRecibo
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        where PA.NumRecibo.Contains(Producto)
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                try
                {

                    //Buscar por Excento
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                return ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
            }
            catch
            {
                return null;
            }
        }

        public List<Entidad.EntidadProductosAlmacen> GetProductosAlmacenxNombreTaller(string Producto)
        {
            try
            {
                List<Entidad.EntidadProductosAlmacen> ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();

                try
                {
                    //Buscar por Proveedor
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        let det = (from pad in Model.TblProductosAlmacenDet
                                                   where
          pad.IdProductosAlmacen == PA.Id && !pad.Estado
                                                   select pad)
                                        where P.Descripcion.Contains(Producto) && det.Any()
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                try
                {

                    //Buscar por NumeroRecibo
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        where PA.NumRecibo.Contains(Producto)
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                try
                {

                    //Buscar por Excento
                    var PorProveedor = (from PA in Model.TblProductosAlmacen
                                        join P in Model.TblProveedores on PA.IdProveedor equals P.Id
                                        select new Entidad.EntidadProductosAlmacen
                                        {
                                            Id = PA.Id,
                                            IdProveedor = P.Id,
                                            Proveedor = P.Descripcion,
                                            NumRecibo = PA.NumRecibo
                                        }).ToList();

                    if (PorProveedor.Count >= 1)
                    {
                        foreach (Entidad.EntidadProductosAlmacen d in PorProveedor)
                        {
                            Entidad.EntidadProductosAlmacen DT = new Entidad.EntidadProductosAlmacen();
                            DT = d;
                            DT.CantExistencia = Existencia(d.Id);

                            if (d.ExcentoIva == true)
                            {
                                DT.Excento = "EXCENTO";
                            }
                            else
                            {
                                DT.Excento = "NO EXCENTO";
                            }

                            ListaMaestro.Add(DT);
                        }

                        return ListaMaestro;
                    }
                }
                catch
                {
                    ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
                }

                return ListaMaestro = new List<Entidad.EntidadProductosAlmacen>();
            }
            catch
            {
                return null;
            }
        }

        public bool LiberarProducto(int IdProducto)
        {

            var producto = Model.TblProductosAlmacenDet.Find(IdProducto);
            producto.Estado = true;
            producto.MotivoBaja = string.Empty;
            producto.FechaBaja = null;
            Model.SaveChanges();

            return true;
        }

        public bool EnviarTallerProducto(int IdProducto, string motivo)
        {

            var producto = Model.TblProductosAlmacenDet.Find(IdProducto);
            producto.Estado = false;
            producto.MotivoBaja = motivo;
            producto.FechaBaja = DateTime.Now;
            Model.SaveChanges();

            return true;
        }

        //Metodo para Guardar
        //public int Guardar(TblProductosAlmacen Entidad)
        //{
        //    try
        //    {
        //        TblProductosAlmacen _Cat = new TblProductosAlmacen();
        //        //_Cat.IdProducto = Entidad.IdProducto;
        //        //_Cat.IdMarca = Entidad.IdMarca;
        //        //_Cat.Serie = Entidad.Serie;
        //        //_Cat.Modelo = Entidad.Modelo;
        //        //_Cat.IMEI = Entidad.IMEI;
        //        //_Cat.Descripcion = Entidad.Descripcion;
        //        //_Cat.Estado = true;
        //        //_Cat.PrecioC = Entidad.PrecioC;
        //        //_Cat.PrecioV = Entidad.PrecioV;
        //        //_Cat.FechaAlta = DateTime.Now;

        //        _Cat.FechaCrea = DateTime.Now;
        //        _Cat.IdUsuarioCrea = 1;

        //        Model.TblProductosAlmacen.Add(_Cat);
        //        Model.SaveChanges();

        //        //return Entidad.IdProducto;
        //    }
        //    catch
        //    {
        //        return 0;
        //    }
        //}

        //Metodo para Modificar
        public int Modificar(TblProductosAlmacen Entidad)
        {
            try
            {
                //obtenemos el ultimo ID de producto
                //int idProducto = Model.TblProductos.OrderByDescending(x => x.Id).FirstOrDefault().Id;

                TblProductosAlmacen _Cat = new TblProductosAlmacen();
                _Cat = Model.TblProductosAlmacen.FirstOrDefault(x => x.Id == Entidad.Id);


                //_Cat.IdProducto = Entidad.IdProducto;
                //_Cat.IdMarca = Entidad.IdMarca;
                //_Cat.Serie = Entidad.Serie;
                //_Cat.Modelo = Entidad.Modelo;
                //_Cat.IMEI = Entidad.IMEI;
                //_Cat.Descripcion = Entidad.Descripcion;
                //_Cat.Estado = true;
                //_Cat.PrecioC = Entidad.PrecioC;
                //_Cat.PrecioV = Entidad.PrecioV;
                _Cat.FechaModifica = DateTime.Now;
                _Cat.IdUsuarioModifica = 1;

                Model.SaveChanges();

                return 0;//Entidad.IdProducto;

            }
            catch
            {
                return 0;
            }
        }

        public int CalcularPrecioCompra(int parametro)
        {
            try
            {
                int suma = 0;

                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

                var Lista = (from PA in Model.TblProductosAlmacen
                                 //where PA.IdProducto == parametro
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 //Id = PA.Id,
                                 //PrecioC = PA.PrecioC,
                             }).ToList();

                foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                {
                    Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                    DT = d;

                    suma = suma + DT.PrecioC;

                    LstProductos.Add(DT);
                }

                return suma;

            }
            catch
            {
                return 0;
            }
        }

        public bool actualizarPrecioProducto(int parametro)
        {
            try
            {
                int suma = 0;

                LstProductos = new List<Entidad.EntidadProductoAlmacenDet>();

                var Lista = (from PA in Model.TblProductosAlmacen
                                 //where PA.IdProducto == parametro
                             select new Entidad.EntidadProductoAlmacenDet
                             {
                                 //Id = PA.Id,
                                 //PrecioC = PA.PrecioC,
                             }).ToList();

                foreach (Entidad.EntidadProductoAlmacenDet d in Lista)
                {
                    Entidad.EntidadProductoAlmacenDet DT = new Entidad.EntidadProductoAlmacenDet();
                    DT = d;

                    suma = suma + DT.PrecioC;

                    LstProductos.Add(DT);
                }


                TblProductos _Cat = Model.TblProductos.FirstOrDefault(x => x.Id == parametro);

                //_Cat.PrecioCompra = Convert.ToDecimal(suma);
                _Cat.FechaModifica = DateTime.Now;
                _Cat.IdUsuarioModifica = 1;
                Model.SaveChanges();
                return true;

            }
            catch
            {
                return false;
            }
        }




    }
}
