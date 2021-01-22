using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class FacturaControllers
    {
        List<Entidad.EntidadFactura> LstFactura = new List<Entidad.EntidadFactura>();
        BDSMARTZONEEntities Model = new BDSMARTZONEEntities();
        TblFactura ValidadEntidad = new TblFactura();

        //Metodo para Listar Todos los Elementos de Productos
        public List<Entidad.EntidadFactura> ListarFacturas()
        {
            try
            {
                var Lista = (from F in Model.TblFactura
                             join M in Model.TblMoneda on F.IdMoneda equals M.Id
                             select new Entidad.EntidadFactura
                             {
                                 Id = F.Id,
                                 IdMoneda = M.Id,
                                 CodFactura = F.CodFactura,
                                 Moneda = M.Descripcion,
                                 DatosCliente = F.DatosCliente,
                                 Estado = F.Estado,
                                 SubTotal = F.SubTotal,
                                 Iva = F.Iva,
                                 Total = F.Total
                             }).ToList();

                return Lista;
            }
            catch
            {
                return LstFactura = new List<Entidad.EntidadFactura>();
            }
        }
        //Metodo para Listar la Factura por parametro
        public List<Entidad.EntidadFactura> ListarFacturasxParametro(string Parametro)
        {
            try
            {
                //si existe en codFactura
                LstFactura = new List<Entidad.EntidadFactura>();

                try
                {
                    LstFactura = (from F in Model.TblFactura
                                 join M in Model.TblMoneda on F.IdMoneda equals M.Id
                                 where F.CodFactura.Contains(Parametro)
                                 select new Entidad.EntidadFactura
                                 {
                                     Id = F.Id,
                                     IdMoneda = M.Id,
                                     CodFactura = F.CodFactura,
                                     Moneda = M.Descripcion,
                                     DatosCliente = F.DatosCliente,
                                     Estado = F.Estado,
                                     SubTotal = F.SubTotal,
                                     Iva = F.Iva,
                                     Total = F.Total
                                 }).ToList();

                    if (LstFactura.Count >= 1)
                    {
                        return LstFactura;
                    }
                }
                catch
                {
                    return LstFactura = new List<Entidad.EntidadFactura>();
                }
                //si existe en cliente
                try
                {
                    LstFactura = (from F in Model.TblFactura
                                 join M in Model.TblMoneda on F.IdMoneda equals M.Id
                                 where F.DatosCliente.Contains(Parametro)
                                 select new Entidad.EntidadFactura
                                 {
                                     Id = F.Id,
                                     IdMoneda = M.Id,
                                     CodFactura = F.CodFactura,
                                     Moneda = M.Descripcion,
                                     DatosCliente = F.DatosCliente,
                                     Estado = F.Estado,
                                     SubTotal = F.SubTotal,
                                     Iva = F.Iva,
                                     Total = F.Total
                                 }).ToList();

                    if (LstFactura.Count >= 1)
                    {
                        return LstFactura;
                    }
                }
                catch
                {
                    return LstFactura = new List<Entidad.EntidadFactura>();
                }

                //por estado
                try
                {
                    LstFactura = (from F in Model.TblFactura
                                 join M in Model.TblMoneda on F.IdMoneda equals M.Id
                                 where F.Estado.Contains(Parametro)
               
                  select new Entidad.EntidadFactura
                                 {
                                     Id = F.Id,
                                     IdMoneda = M.Id,
                                     CodFactura = F.CodFactura,
                                     Moneda = M.Descripcion,
                                     DatosCliente = F.DatosCliente,
                                     Estado = F.Estado,
                                     SubTotal = F.SubTotal,
                                     Iva = F.Iva,
                                     Total = F.Total
                                 }).ToList();

                    if (LstFactura.Count >= 1)
                    {
                        return LstFactura;
                    }
                }
                catch
                {
                    return LstFactura = new List<Entidad.EntidadFactura>();
                }

                //sino hay coincidencia retorna todos los valores
                try
                {
                    LstFactura = (from F in Model.TblFactura
                                  join M in Model.TblMoneda on F.IdMoneda equals M.Id
                                  select new Entidad.EntidadFactura
                                  {
                                      Id = F.Id,
                                      IdMoneda = M.Id,
                                      CodFactura = F.CodFactura,
                                      Moneda = M.Descripcion,
                                      DatosCliente = F.DatosCliente,
                                      Estado = F.Estado,
                                      SubTotal = F.SubTotal,
                                      Iva = F.Iva,
                                      Total = F.Total
                                  }).ToList();

                    return LstFactura;
                }
                catch
                {
                    return LstFactura = new List<Entidad.EntidadFactura>();
                }
            }
            catch
            {
                return LstFactura = new List<Entidad.EntidadFactura>();
            }
        }
        //Funcion para calcular el consecutivo de N° Factura
        public Object GetNumFac()
        {
            int valor = 120000000; //valor por defecto
            try
            {

                TblFactura _TblFactura = new TblFactura();

                var recibo = Model.TblFactura.OrderByDescending(x => x.Id).First().CodFactura;

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
        //ListarEntidad CodFac y Fecha
        public Entidad.ListaFacFecha retornarFechaCodProd()
        {
            List<Entidad.ListaFacFecha> _ListaFacFecha = new List<Entidad.ListaFacFecha>();

            var numFac = GetNumFac();

            try
            {
                Entidad.ListaFacFecha E = new Entidad.ListaFacFecha();
                for (int x = 0; x < 1; x++)
                {
                    E.CodFac = Convert.ToString(numFac);
                    E.FechaFac = DateTime.Now.ToString("dd/MM/yyyy");//DateTime.Now;
                }
                return E;
            }
            catch
            {
                return null;
            }
        }
        //Metodo para Listar Todos los Elementos de Modelo por IdProducto
        public List<Entidad.EntidadModelo> GetModelosxProducto(string parametro)
        {
            int idproducto = 0;
            List<Entidad.EntidadModelo> _Lista = new List<Entidad.EntidadModelo>();
            List<Entidad.EntidadLista> EL = new List<Entidad.EntidadLista>();

            EL = GetProductos3();//cargamos la lista de productos 
            //recorremos la lista de productos y obtenemos el q coincide con el filtro
            var Lista1 = (from a in EL where a.Descripcion == parametro
                          select new Entidad.EntidadLista
                          { Id = a.Id, Descripcion = a.Descripcion}).ToList();
            //obtenemos el id q usaremos en la siguiente query
            idproducto = Lista1.FirstOrDefault().Id;

            try
            {
                var Lista = (from A in Model.TblProductosAlmacenDet
                             join M in Model.TblModelo on A.IdModelo equals M.Id
                             join P in Model.TblProductos on M.IdProducto equals P.Id
                             where M.IdProducto == idproducto && A.Estado == true
                             select new Entidad.EntidadModelo
                             {
                                 Id = A.Id,
                                 IdProducto = M.IdProducto,
                                 Descripcion = M.Descripcion,
                                 Especificaciones = M.Especificaciones,
                                 IdCategoria = P.IdCategoria,
                                 IdModelo = A.IdModelo,
                                 Precio = A.PrecioV
                             }).ToList();

                foreach (Entidad.EntidadModelo d in Lista)
                {
                    Entidad.EntidadModelo DT = new Entidad.EntidadModelo();

                    if (_Lista.Count==0)
                    {
                        var Existencia = (from a in Lista
                                          where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                          select new Entidad.EntidadLista
                                          { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                        DT = d;
                        DT.cantidadExistencia = Existencia.Count();
                        _Lista.Add(DT);
                    }
                    else
                    {
                        var _Lista2 = (from a in _Lista
                                       where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                      select new Entidad.EntidadLista
                                      { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                        if (_Lista2.Count==0)
                        {
                            var Existencia = (from a in Lista
                                              where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                              select new Entidad.EntidadLista
                                              { Id = a.Id, Descripcion = a.Descripcion }).ToList();
                            DT = d;
                            DT.cantidadExistencia = Existencia.Count();
                            _Lista.Add(DT);
                        }
                    }
                }

                return _Lista;
            }
            catch
            {
                return null;
            }
        }
        //Metodo para Guardar MaestroDetalle
        public int GuardarMaestroDetalle(TblFactura _TblFactura, TblDetalleFactura _TblDetalleFactura, int IdProDet)
        {
            try
            {
                ValidadEntidad = new TblFactura();
                TblFactura _Maestro2 = new TblFactura();
                int IdFactura = 0;
                decimal iva = 0;
                decimal Total = 0;
                decimal SubTotal = 0;

                try
                {
                    ValidadEntidad = Model.TblFactura.FirstOrDefault(x => x.Id == _TblFactura.Id);
                }
                catch
                {
                    ValidadEntidad = new TblFactura();
                }

                if (ValidadEntidad is null) //se agrega solamente la primera vez
                {
                    TblFactura _Maestro = new TblFactura();
                    _Maestro.IdMoneda = 1;// _TblFactura.IdMoneda;
                    _Maestro.CodFactura = _TblFactura.CodFactura;
                    _Maestro.DatosCliente = _TblFactura.DatosCliente;
                    _Maestro.Estado = "Facturado";
                    _Maestro.SubTotal = 0;
                    _Maestro.Iva = 0;
                    _Maestro.Total = 0;
                    _Maestro.FechaCrea = DateTime.Now;
                    _Maestro.IdUsuarioCrea = 1;

                    Model.TblFactura.Add(_Maestro);
                    Model.SaveChanges();
                }

                //obtenemos el ID de la Factura que se usara en el DetalleFactura
                if (ValidadEntidad is null)
                {
                    IdFactura = Model.TblFactura.OrderByDescending(x => x.Id).FirstOrDefault().Id;
                }
                else
                {
                    IdFactura = ValidadEntidad.Id;//id a retornar
                }

                //guardamos el detalle
                TblDetalleFactura _Detalle = new TblDetalleFactura();
                _Detalle.IdFactura = IdFactura;
                _Detalle.Cantidad = _TblDetalleFactura.Cantidad;
                decimal ST = 0;
                if (_TblDetalleFactura.Cantidad !=1)
                {
                    ST = _TblDetalleFactura.PrecioxUnd * _TblDetalleFactura.Cantidad;
                }
                else
                {
                    ST = _TblDetalleFactura.PrecioxUnd;
                }

                //calculamos el total con descuento
                if (_TblDetalleFactura.Descuento != 0)
                {
                    string temp = "0." + _TblDetalleFactura.Descuento;
                    CultureInfo culture = new CultureInfo("en-US");
                    decimal result = Convert.ToDecimal(temp, culture);
                    decimal calculo = ST * Convert.ToDecimal(result);
                    decimal resta = ST - calculo;
                    _Detalle.Total = resta;
                }
                else
                {
                    _Detalle.Total = ST;
                }
                /**//////
                _Detalle.Descuento = _TblDetalleFactura.Descuento;
                _Detalle.PrecioxUnd = _TblDetalleFactura.PrecioxUnd;                
                _Detalle.GarantiaDias = _TblDetalleFactura.GarantiaDias;
                //calcular la fecha de vencimiento de la garantia
                DateTime nuevaFecha = DateTime.Now;
                nuevaFecha = nuevaFecha.AddDays(Convert.ToDouble(_TblDetalleFactura.GarantiaDias));
                _Detalle.FechaVenceGarantia = nuevaFecha;
                /******************/
                Model.TblDetalleFactura.Add(_Detalle);
                Model.SaveChanges();

                //Obtenemos la Factura que esta en uso
                _Maestro2 = new TblFactura();
                _Maestro2 = Model.TblFactura.FirstOrDefault(x => x.Id == IdFactura);
                //Calculamos el SubTotal, Iva y Total para Factura
                SubTotal = _Maestro2.SubTotal + _Detalle.Total;
                iva = Convert.ToDecimal(SubTotal * Convert.ToDecimal(0.15));
                Total = Convert.ToDecimal(SubTotal + iva);

                _Maestro2.SubTotal = SubTotal;
                _Maestro2.Iva = iva;
                _Maestro2.Total = Total;
                _Maestro2.FechaModifica = DateTime.Now;
                _Maestro2.IdUsuarioModifica = 1;
                Model.SaveChanges();

                /******************/

                //sumamos el espacio en bodega que se va facturar durante este proceso.
                ActualizarBodega("sumar", _TblDetalleFactura.Cantidad);
                //actualizamos los datos en detalleAlmacen
                bool update = Actualizar(_TblDetalleFactura.Cantidad, IdProDet, _TblFactura.CodFactura);

                return IdFactura;
            }
            catch
            {
                return 0;
            }
        }
        //Metodo para Listar Todos los Elementos de DetalleFactura
        public List<Entidad.EntidadFacturaDetalle> GetDetalleFactura(int idFactura)
        {
            List<Entidad.EntidadFacturaDetalle> _Lista = new List<Entidad.EntidadFacturaDetalle>();
            string Temporal = ""; //para capturar la fecha de vencimiento de la garantia
            try
            {
                int temp = 0;
                var Lista = (from F in Model.TblFactura
                             join D in Model.TblDetalleFactura on F.Id equals D.IdFactura                             
                             where F.Id == idFactura
                             select new Entidad.EntidadFacturaDetalle
                             {
                                 Id = D.Id,
                                 IdFactura = F.Id,
                                 Cantidad = D.Cantidad,
                                 Descuento = D.Descuento,
                                 GarantiaDias = D.GarantiaDias,
                                 Total = D.Total,
                                 PrecioxUnd = D.PrecioxUnd,
                                 SubTotal = F.SubTotal,
                                 Iva = F.Iva,
                                 Total2 = F.Total,
                                 CodFactura = F.CodFactura,
                                 Cliente = F.DatosCliente,
                                 FechaTemporal = F.FechaCrea,
                                 Estado = F.Estado,
                                 IdDetFactura = D.Id
                             }).ToList();

                foreach (Entidad.EntidadFacturaDetalle d in Lista)
                {
                    Entidad.EntidadFacturaDetalle DT = new Entidad.EntidadFacturaDetalle();

                    DT = d;
                    string concatenacion = "";
                    List<TblMaestra> _ListalMaestra = new List<TblMaestra>();
                    _ListalMaestra = Model.TblMaestra.Where(x => x.IdDetalleFactura == d.Id).ToList();
                    TblProductosAlmacenDet _Detalle = new TblProductosAlmacenDet();
                    int vId = _ListalMaestra.FirstOrDefault().IdDetalleAlmacen;
                    _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == vId);

                    TblModelo _Modelo = new TblModelo();
                    _Modelo = Model.TblModelo.FirstOrDefault(x => x.Id == _Detalle.IdModelo);

                    if (_Modelo.TblProductos.IdCategoria == 2)
                    {
                        if (_Modelo.TblProductos.TblMarca.Id == 6)
                        {
                            concatenacion = _Modelo.Descripcion;
                        }
                        else
                        {
                            concatenacion = _Modelo.Descripcion + ' ' + _Modelo.TblProductos.TblMarca.Descripcion;
                        }
                    }
                    else
                    {
                        DT.EnExistencia = 1;//cuanto es celular o tablet es unico, por el imei y serial
                        concatenacion = _Modelo.TblProductos.TblCategorias.Descripcion + ' ' + _Modelo.Descripcion + ' ' + _Modelo.TblProductos.TblMarca.Descripcion;
                    }
                    DT.Efectivo = d.Efectivo;
                    DT.Vuelto = d.Vuelto;
                    DT.Descripcion = concatenacion;
                    DT.IdModelo = _Detalle.IdModelo;
                    DT.IdCategoria = _Modelo.TblProductos.IdCategoria;
                    DT.IdProducto = _Modelo.TblProductos.Id;
                    // para capturar la fecha de vencimiento de la garantia
                    TblDetalleFactura Detalle = new TblDetalleFactura();
                    Detalle = Model.TblDetalleFactura.FirstOrDefault(x => x.Id == d.Id);

                    if (Detalle.GarantiaDias > temp)
                    {
                        temp = Convert.ToInt32(Detalle.GarantiaDias);
                        DT.FechaTemporal = Convert.ToDateTime(Detalle.FechaVenceGarantia);
                        DT.FechaFacturacion = DT.FechaTemporal.ToString("dd/MM/yyyy");
                        Temporal = DT.FechaFacturacion;
                    }
                    else
                    {
                        DT.FechaFacturacion = Temporal;
                    }

                    TblFactura Fac = new TblFactura();
                    Fac = Model.TblFactura.FirstOrDefault(x => x.Id == d.IdFactura);
                    DT.Efectivo = Convert.ToDecimal(Fac.Efectivo);
                    DT.Vuelto = Convert.ToDecimal(Fac.Vuelto);
                    //obtenemos cuantos registros hay en existencia
                    if(DT.EnExistencia!=1)
                    {
                        var Existencia = (from A in Model.TblProductosAlmacenDet
                                          join M in Model.TblModelo on A.IdModelo equals M.Id
                                          join P in Model.TblProductos on M.IdProducto equals P.Id
                                          where P.Id == d.IdProducto && M.Id == d.IdModelo && A.Estado == true
                                          select new Entidad.EntidadLista
                                          { Id = A.Id, Descripcion = M.Descripcion }).ToList();

                        if(Existencia.Count()==0)
                        {
                            DT.EnExistencia = d.Cantidad;
                        }
                        else
                        {
                            int cont = Existencia.Count();
                            DT.EnExistencia = d.Cantidad + cont;
                        }
                    }
                    //obtenemos el iddetallealmacen de tlbmaestra
                    TblMaestra _TM = new TblMaestra();
                    _TM = Model.TblMaestra.FirstOrDefault(x=>x.IdFactura == d.IdFactura && x.IdDetalleFactura == d.Id);
                    DT.IdDetalleProductosAlmacen = _TM.IdDetalleAlmacen;
                    //cargamos la descripcion del rpoducto para usarlo al momento de editar el registro
                    List<Entidad.EntidadLista> EL = new List<Entidad.EntidadLista>();
                    EL = GetProductos3(_Modelo.TblProductos.Id);
                    DT.DescProducto = EL.FirstOrDefault().Descripcion;
                    DT.DescModelo = _Modelo.Descripcion;
                    _Lista.Add(DT);
                }

                return _Lista;
            }
            catch
            {
                return null;
            }
        }
        //metodo para calcular cuantos articulos hay en existencia(tblProductosAlmacenDet)
        public int CalcularExistencia(int id)
        {
            var Query = from C in Model.TblProductosAlmacenDet
                        where C.IdModelo == id && C.Estado == true
                        select new { C.Id };
            return Query.ToList().Count;
        }
        //actualizamos la tabla TblProductosAlmacenDet
        public bool Actualizar(int cant, int id, string NFactura)
        {
            try
            {
                TblProductosAlmacenDet _Detalle = new TblProductosAlmacenDet();
                TblDetalleFactura DF = new TblDetalleFactura();
                DF = Model.TblDetalleFactura.OrderByDescending(x => x.Id).FirstOrDefault();

                if (cant == 1)
                {
                    try
                    {
                        //cargamos el producto que coinciden con el filtro.
                        _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == id);
                    }
                    catch
                    {
                        return false;
                    }

                    _Detalle.Estado = false;
                    _Detalle.CodFactura = NFactura;
                    _Detalle.FechaModifica = DateTime.Now;
                    _Detalle.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                    //return true;

                    TblMaestra _Maestro = new TblMaestra();
                    _Maestro.IdDetalleAlmacen = id;
                    _Maestro.IdDetalleFactura = DF.Id; //IdDetalleFactura;
                    _Maestro.IdFactura = DF.IdFactura;
                    Model.TblMaestra.Add(_Maestro);
                    Model.SaveChanges();
                    return true;

                }
                else
                {
                    try
                    {
                        //cargamos el producto que coinciden con el filtro.
                        _Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == id);
                        List<TblProductosAlmacenDet> Lista2 = new List<TblProductosAlmacenDet>();
                        Lista2 = Model.TblProductosAlmacenDet.Where(x => x.IdModelo == _Detalle.IdModelo && x.Estado == true).ToList();

                        foreach (TblProductosAlmacenDet d in Lista2.Take(cant))
                        {
                            TblProductosAlmacenDet DT = new TblProductosAlmacenDet();
                            DT = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);

                            DT.Estado = false;
                            DT.CodFactura = NFactura;
                            DT.FechaModifica = DateTime.Now;
                            DT.IdUsuarioModifica = 1;
                            Model.SaveChanges();

                            TblMaestra _Maestro = new TblMaestra();
                            _Maestro.IdDetalleAlmacen = d.Id;
                            _Maestro.IdDetalleFactura = DF.Id;
                            _Maestro.IdFactura = DF.IdFactura;
                            Model.TblMaestra.Add(_Maestro);
                            Model.SaveChanges();
                        }
                        return true;
                    }
                    catch
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
        //Actualizamos el espacio disponible en Bodega
        public Object ActualizarBodega(string bandera, int cantidad)
        {
            try
            {
                int operacion = 0;

                //int parametro = Lista.Count();
                TblAlmacen _Cat = Model.TblAlmacen.FirstOrDefault(x => x.Id == 1);

                if (bandera == "restar")
                {
                    operacion = _Cat.Disponible - cantidad;
                }
                else if (bandera == "sumar")
                {
                    operacion = _Cat.Disponible + cantidad;
                }
                else
                {
                    operacion = _Cat.Disponible + cantidad;
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
        //Metodo para eliminar
        public bool EliminarDetalle(int iddetalle, int idmaestro, int Cantidad)
        {
            try
            {
                ActualizarBodega("restar", Cantidad); //sumamos el espacio en bodega que se va eliminar en la existencia durante este proceso.

                //instanciamos las entidades
                TblDetalleFactura Detalle = new TblDetalleFactura();
                ValidadEntidad = new TblFactura();
                TblMaestra _Maestro = new TblMaestra();

                decimal vPrecio = 0;

                //eliminamos el detalle de factura
                Detalle = Model.TblDetalleFactura.FirstOrDefault(x => x.Id == iddetalle);
                vPrecio = Detalle.Total;
                Model.TblDetalleFactura.Remove(Detalle);
                Model.SaveChanges();
                //eliminamos el detalle de la tabla maestra
                _Maestro = Model.TblMaestra.FirstOrDefault(x => x.IdDetalleFactura == iddetalle);
                Model.TblMaestra.Remove(_Maestro);
                Model.SaveChanges();
                //volvemos a calcular los valores y cargamos la Factura
                ValidadEntidad = Model.TblFactura.FirstOrDefault(x => x.Id == idmaestro);

                decimal resta = Convert.ToDecimal(ValidadEntidad.SubTotal) - vPrecio;
                decimal iva = Convert.ToDecimal(resta) * Convert.ToDecimal(0.15);
                decimal Total = Convert.ToDecimal(resta + iva);

                ValidadEntidad.SubTotal = resta;
                ValidadEntidad.Iva = iva;
                ValidadEntidad.Total = Total;
                ValidadEntidad.FechaModifica = DateTime.Now;
                ValidadEntidad.IdUsuarioModifica = 1;
                Model.SaveChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }
        //Metodo para eliminar el cod fatura y estado al registro q se elimina del detallefactura
        public bool RevertirDetalleAlmacen(int iddetalleFactura)
        {
            try
            {
                List<TblMaestra> Lista = new List<TblMaestra>();
                Lista = Model.TblMaestra.Where(x => x.IdDetalleFactura == iddetalleFactura).ToList();

                foreach (TblMaestra d in Lista)
                {
                    TblProductosAlmacenDet DT = new TblProductosAlmacenDet();
                    DT = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.IdDetalleAlmacen);

                    DT.Estado = true;
                    DT.CodFactura = null;
                    DT.FechaModifica = DateTime.Now;
                    DT.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        //Metodo para eliminar MaestroDetalle
        public bool EliminarMaestroDetalle(int id)
        {
            try
            {
                List<TblDetalleFactura> ListaDetalle = new List<TblDetalleFactura>();
                ListaDetalle = Model.TblDetalleFactura.Where(x => x.IdFactura == id).ToList();
                int contador = 0;
                List<TblMaestra> ListaMaestra = new List<TblMaestra>();
                ListaMaestra = Model.TblMaestra.Where(x => x.IdFactura == id).ToList();

                foreach(TblMaestra d in ListaMaestra)
                {
                    //volvemos a su estado nuevo los articulos en AlmacenDetalle
                    TblProductosAlmacenDet DT = new TblProductosAlmacenDet();
                    DT = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.IdDetalleAlmacen);
                    DT.Estado = true;
                    DT.CodFactura = null;
                    DT.FechaModifica = DateTime.Now;
                    DT.IdUsuarioModifica = 1;
                    Model.SaveChanges();
                    //eliminamos el maestro 
                    TblMaestra _Maestra = new TblMaestra();
                    _Maestra = Model.TblMaestra.FirstOrDefault(x => x.Id == d.Id);
                    Model.TblMaestra.Remove(_Maestra);
                    Model.SaveChanges();
                }

                foreach (TblDetalleFactura d in ListaDetalle)
                {
                    //contador usado para sumar los espacios en bodega q se habian usado
                    contador = contador + d.Cantidad;
                    //eliminarmos el detalle
                    TblDetalleFactura _Detalle = new TblDetalleFactura();
                    _Detalle = Model.TblDetalleFactura.FirstOrDefault(x => x.Id == d.Id);
                    Model.TblDetalleFactura.Remove(_Detalle);
                    Model.SaveChanges();
                }

                ActualizarBodega("restar", contador); //sumamos los espacio en bodega que se habian usado durante este proceso creado.

                //eliminamos el maestro 
                ValidadEntidad = new TblFactura();
                ValidadEntidad = Model.TblFactura.FirstOrDefault(x => x.Id == id);
                Model.TblFactura.Remove(ValidadEntidad);
                Model.SaveChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }
        //usado en el boton de facturacion
        public  bool Facturar(int idFactura, string Efectivo, string Vuelto)
        {
            TblFactura _Factura = new TblFactura();
            _Factura = Model.TblFactura.FirstOrDefault(x=>x.Id == idFactura);
            _Factura.Efectivo = Convert.ToDecimal(Efectivo);
            _Factura.Vuelto = Convert.ToDecimal(Vuelto);
            _Factura.FechaModifica = DateTime.Now;
            Model.SaveChanges();
            return true;
        }
        //anular factura
        public int Anular(string CodFactura)
        {
            TblFactura _Factura = new TblFactura();
            _Factura = Model.TblFactura.FirstOrDefault(x => x.CodFactura == CodFactura);
            List<TblMaestra> ListaMaestra = new List<TblMaestra>();
            ListaMaestra = Model.TblMaestra.Where(x => x.IdFactura == _Factura.Id).ToList();
            _Factura.Estado = "Anulado";
            _Factura.FechaModifica = DateTime.Now;
            Model.SaveChanges();

            //for para anular
            foreach (TblMaestra d in ListaMaestra)
            {
                TblProductosAlmacenDet Detalle = new TblProductosAlmacenDet();
                Detalle = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.IdDetalleAlmacen);
                Detalle.MotivoBaja = "Anulado el dia " + DateTime.Now;
                Detalle.FechaModifica = DateTime.Now;
                Model.SaveChanges();
            }

            return _Factura.Id;
        }
        //Metodo para Listar en Facturacion
        public List<Entidad.EntidadLista> GetProductos3()
        {
            List<Entidad.EntidadLista> LFinal = new List<Entidad.EntidadLista>();
            try
            {                                
                var Lista = (from P in Model.TblProductos
                             join C in Model.TblCategorias on P.IdCategoria equals C.Id
                             join M in Model.TblMarca on P.IdMarca equals M.Id
                             select new Entidad.EntidadProducto
                             {
                                 Id = P.Id,
                                 Categoria = C.Descripcion,
                                 Marca = M.Descripcion
                             }).ToList();

                foreach (Entidad.EntidadProducto d in Lista)
                {
                    Entidad.EntidadLista DT = new Entidad.EntidadLista();

                    DT.Id = d.Id;
                    if (d.Marca == "N/A")
                    {
                        DT.Descripcion = d.Categoria;
                    }
                    else
                    {
                        DT.Descripcion = d.Categoria + ' ' + d.Marca;
                    }


                    LFinal.Add(DT);
                }

                return LFinal;
            }
            catch
            {
                return LFinal = new List<Entidad.EntidadLista>();
            }
        }
        //Metodo para Listar el Producto por parametro
        public List<Entidad.EntidadModelo> GetProductosxParametro(string Parametro, string IdProducto)
        {
            List<Entidad.EntidadModelo> LstModelos = new List<Entidad.EntidadModelo>();
            try
            {
                List<Entidad.EntidadModelo> _Lista = new List<Entidad.EntidadModelo>();

                if(string.IsNullOrEmpty(Parametro))
                {
                    //sino hay coincidencia se retorna todos
                    int idproducto = 0;
                    List<Entidad.EntidadLista> EL = new List<Entidad.EntidadLista>();

                    EL = GetProductos3();//cargamos la lista de productos 
                                         //recorremos la lista de productos y obtenemos el q coincide con el filtro
                    var Lista1 = (from a in EL
                                  where a.Descripcion == IdProducto
                                  select new Entidad.EntidadLista
                                  { Id = a.Id, Descripcion = a.Descripcion }).ToList();
                    //obtenemos el id q usaremos en la siguiente query
                    idproducto = Lista1.FirstOrDefault().Id;
                    try
                    {
                        var Lista = (from A in Model.TblProductosAlmacenDet
                                     join M in Model.TblModelo on A.IdModelo equals M.Id
                                     join P in Model.TblProductos on M.IdProducto equals P.Id
                                     where M.IdProducto == idproducto && A.Estado == true
                                     select new Entidad.EntidadModelo
                                     {
                                         Id = A.Id,
                                         IdProducto = M.IdProducto,
                                         Descripcion = M.Descripcion,
                                         Especificaciones = M.Especificaciones,
                                         IdCategoria = P.IdCategoria,
                                         IdModelo = A.IdModelo,
                                         Precio = A.PrecioV
                                     }).ToList();

                        foreach (Entidad.EntidadModelo d in Lista)
                        {
                            Entidad.EntidadModelo DT = new Entidad.EntidadModelo();

                            if (_Lista.Count == 0)
                            {
                                var Existencia = (from a in Lista
                                                  where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                  select new Entidad.EntidadLista
                                                  { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                DT = d;
                                DT.cantidadExistencia = Existencia.Count();
                                _Lista.Add(DT);
                            }
                            else
                            {
                                var _Lista2 = (from a in _Lista
                                               where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                               select new Entidad.EntidadLista
                                               { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                if (_Lista2.Count == 0)
                                {
                                    var Existencia = (from a in Lista
                                                      where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                      select new Entidad.EntidadLista
                                                      { Id = a.Id, Descripcion = a.Descripcion }).ToList();
                                    DT = d;
                                    DT.cantidadExistencia = Existencia.Count();
                                    _Lista.Add(DT);
                                }
                            }
                        }

                        return _Lista;
                    }
                    catch
                    {
                        LstModelos = new List<Entidad.EntidadModelo>();
                    }
                }
                else
                {
                    //si existe en Descripcion se retorta
                    try
                    {
                        var Lista = (from A in Model.TblProductosAlmacenDet
                                     join M in Model.TblModelo on A.IdModelo equals M.Id
                                     join P in Model.TblProductos on M.IdProducto equals P.Id
                                     where M.Descripcion.Contains(Parametro) && A.Estado == true
                                     select new Entidad.EntidadModelo
                                     {
                                         Id = A.Id,
                                         IdProducto = M.IdProducto,
                                         Descripcion = M.Descripcion,
                                         Especificaciones = M.Especificaciones,
                                         IdCategoria = P.IdCategoria,
                                         IdModelo = A.IdModelo,
                                         Precio = A.PrecioV
                                     }).ToList();
                        if (Lista.Count >= 1)
                        {
                            foreach (Entidad.EntidadModelo d in Lista)
                            {
                                Entidad.EntidadModelo DT = new Entidad.EntidadModelo();

                                if (_Lista.Count == 0)
                                {
                                    var Existencia = (from a in Lista
                                                      where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                      select new Entidad.EntidadLista
                                                      { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                    DT = d;
                                    DT.cantidadExistencia = Existencia.Count();
                                    _Lista.Add(DT);
                                }
                                else
                                {
                                    var _Lista2 = (from a in _Lista
                                                   where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                   select new Entidad.EntidadLista
                                                   { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                    if (_Lista2.Count == 0)
                                    {
                                        var Existencia = (from a in Lista
                                                          where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                          select new Entidad.EntidadLista
                                                          { Id = a.Id, Descripcion = a.Descripcion }).ToList();
                                        DT = d;
                                        DT.cantidadExistencia = Existencia.Count();
                                        _Lista.Add(DT);
                                    }
                                }
                            }
                            return _Lista;
                        }
                    }
                    catch
                    {
                        LstModelos = new List<Entidad.EntidadModelo>();
                    }
                    //si existe en Especificaciones se retorta
                    try
                    {
                        var Lista = (from A in Model.TblProductosAlmacenDet
                                     join M in Model.TblModelo on A.IdModelo equals M.Id
                                     join P in Model.TblProductos on M.IdProducto equals P.Id
                                     where M.Especificaciones.Contains(Parametro) && A.Estado == true
                                     select new Entidad.EntidadModelo
                                     {
                                         Id = A.Id,
                                         IdProducto = M.IdProducto,
                                         Descripcion = M.Descripcion,
                                         Especificaciones = M.Especificaciones,
                                         IdCategoria = P.IdCategoria,
                                         IdModelo = A.IdModelo,
                                         Precio = A.PrecioV
                                     }).ToList();
                        if (Lista.Count >= 1)
                        {
                            foreach (Entidad.EntidadModelo d in Lista)
                            {
                                Entidad.EntidadModelo DT = new Entidad.EntidadModelo();

                                if (_Lista.Count == 0)
                                {
                                    var Existencia = (from a in Lista
                                                      where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                      select new Entidad.EntidadLista
                                                      { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                    DT = d;
                                    DT.cantidadExistencia = Existencia.Count();
                                    _Lista.Add(DT);
                                }
                                else
                                {
                                    var _Lista2 = (from a in _Lista
                                                   where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                   select new Entidad.EntidadLista
                                                   { Id = a.Id, Descripcion = a.Descripcion }).ToList();

                                    if (_Lista2.Count == 0)
                                    {
                                        var Existencia = (from a in Lista
                                                          where a.IdProducto == d.IdProducto && a.IdModelo == d.IdModelo
                                                          select new Entidad.EntidadLista
                                                          { Id = a.Id, Descripcion = a.Descripcion }).ToList();
                                        DT = d;
                                        DT.cantidadExistencia = Existencia.Count();
                                        _Lista.Add(DT);
                                    }
                                }
                            }
                            return _Lista;
                        }
                    }
                    catch
                    {
                        LstModelos = new List<Entidad.EntidadModelo>();
                    }
                }             

                return LstModelos;
            }
            catch
            {
                return LstModelos = new List<Entidad.EntidadModelo>();
            }
        }
        //Metodo para Listar en Facturacion x Id
        public List<Entidad.EntidadLista> GetProductos3(int id)
        {
            List<Entidad.EntidadLista> LFinal = new List<Entidad.EntidadLista>();
            try
            {
                var Lista = (from P in Model.TblProductos
                             join C in Model.TblCategorias on P.IdCategoria equals C.Id
                             join M in Model.TblMarca on P.IdMarca equals M.Id
                             where P.Id == id
                             select new Entidad.EntidadProducto
                             {
                                 Id = P.Id,
                                 Categoria = C.Descripcion,
                                 Marca = M.Descripcion
                             }).ToList();

                foreach (Entidad.EntidadProducto d in Lista)
                {
                    Entidad.EntidadLista DT = new Entidad.EntidadLista();

                    DT.Id = d.Id;
                    if (d.Marca == "N/A")
                    {
                        DT.Descripcion = d.Categoria;
                    }
                    else
                    {
                        DT.Descripcion = d.Categoria + ' ' + d.Marca;
                    }

                    LFinal.Add(DT);
                }

                return LFinal;
            }
            catch
            {
                return LFinal = new List<Entidad.EntidadLista>();
            }
        }
        //Metodo para actualizar un detalle de la factura
        public int ActualizarDetalle(int IdCat, int IdDetalleFactura, int Cantidad, int Descuento, int IdModelo)
        {
            TblDetalleFactura tblDetalleFactura = new TblDetalleFactura();
            TblFactura tblFactura = new TblFactura();
            List<TblDetalleFactura> ListaDetalle = new List<TblDetalleFactura>();

            decimal iva = 0;
            decimal Total = 0;
            decimal SubTotal = 0;
            decimal ST = 0;
            var concat = "0.";

            tblDetalleFactura = Model.TblDetalleFactura.FirstOrDefault(x => x.Id == IdDetalleFactura);
            tblFactura = Model.TblFactura.FirstOrDefault(x => x.Id == tblDetalleFactura.IdFactura);

            if(Descuento!=0)
            {
                concat = "0." + Descuento;
            }

            if (IdCat == 2)//categorias
            {
                if(Cantidad != tblDetalleFactura.Cantidad) //si la cantidad es distinta a la cantidad existente
                {
                    if (Cantidad > tblDetalleFactura.Cantidad) // si la cantidad es mayor a existencia agregaremos los nuevos
                    {
                        int numsum = Cantidad - tblDetalleFactura.Cantidad;

                        //sumamos el espacio en bodega que se va facturar durante este proceso.
                        ActualizarBodega("sumar", numsum);

                        //cargamos el producto que coinciden con el filtro.
                        List<TblProductosAlmacenDet> Lista2 = new List<TblProductosAlmacenDet>();
                        Lista2 = Model.TblProductosAlmacenDet.Where(x => x.IdModelo == IdModelo && x.Estado == true).ToList();
                        
                        //actualizamos los datos en detalleAlmacen
                        foreach (TblProductosAlmacenDet d in Lista2.Take(numsum))
                        {
                            TblProductosAlmacenDet DT = new TblProductosAlmacenDet();
                            DT = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);

                            DT.Estado = false;
                            DT.CodFactura = tblFactura.CodFactura;
                            DT.FechaModifica = DateTime.Now;
                            DT.IdUsuarioModifica = 1;
                            Model.SaveChanges();

                            TblMaestra _Maestro = new TblMaestra();
                            _Maestro.IdDetalleAlmacen = d.Id;
                            _Maestro.IdDetalleFactura = IdDetalleFactura;
                            _Maestro.IdFactura = tblFactura.Id;
                            Model.TblMaestra.Add(_Maestro);
                            Model.SaveChanges();
                        }
                    }
                    else //si la cantidad es menor a la existencia eliminamos los restantes.
                    {
                        int numsum = tblDetalleFactura.Cantidad - Cantidad;

                        //restamos el espacio en bodega que se eliminaron durante este proceso.
                        ActualizarBodega("restar", numsum);

                        //cargamos el producto que coinciden con el filtro.
                        List<TblProductosAlmacenDet> Lista2 = new List<TblProductosAlmacenDet>();
                        Lista2 = Model.TblProductosAlmacenDet.Where(x => x.CodFactura == tblFactura.CodFactura).OrderByDescending(x=>x.Id).ToList();

                        //actualizamos los datos en detalleAlmacen
                        foreach (TblProductosAlmacenDet d in Lista2.Take(numsum))
                        {
                            TblProductosAlmacenDet DT = new TblProductosAlmacenDet();
                            DT = Model.TblProductosAlmacenDet.FirstOrDefault(x => x.Id == d.Id);

                            DT.Estado = true;
                            DT.CodFactura = "";
                            DT.FechaModifica = DateTime.Now;
                            DT.IdUsuarioModifica = 1;
                            Model.SaveChanges();

                            TblMaestra _Maestro = new TblMaestra();
                            _Maestro = Model.TblMaestra.FirstOrDefault(x=>x.IdDetalleAlmacen == d.Id);
                            Model.TblMaestra.Remove(_Maestro);
                            Model.SaveChanges();
                        }
                    }
                    //recalcular el descuento
                    if (Descuento == 0)
                    {
                        tblDetalleFactura.Total = tblDetalleFactura.PrecioxUnd * Cantidad;
                    }
                    else if (Descuento != 0)
                    {
                        ST = tblDetalleFactura.PrecioxUnd * Cantidad;
                        CultureInfo culture = new CultureInfo("en-US");
                        decimal result = Convert.ToDecimal(concat, culture);
                        decimal calculo = ST * Convert.ToDecimal(result);
                        decimal resta = ST - calculo;
                        tblDetalleFactura.Total = resta;
                    }
                    tblDetalleFactura.Cantidad = Cantidad;
                    tblDetalleFactura.Descuento = Descuento;
                    Model.SaveChanges();
                }
                else //si la cantidad es igual a la existente
                {
                    if(tblDetalleFactura.Descuento != Descuento)
                    {
                        if (Descuento == 0)
                        {
                            tblDetalleFactura.Total = tblDetalleFactura.PrecioxUnd * Cantidad;
                        }
                        else if (Descuento != 0)
                        {                            
                            ST = tblDetalleFactura.PrecioxUnd * Cantidad;
                            CultureInfo culture = new CultureInfo("en-US");
                            decimal result = Convert.ToDecimal(concat, culture);
                            decimal calculo = ST * Convert.ToDecimal(result);
                            decimal resta = ST - calculo;
                            tblDetalleFactura.Total = resta;
                        }
                        tblDetalleFactura.Descuento = Descuento;
                        Model.SaveChanges();
                    }
                }
            }
            else //celular o tablet
            {                
                if (tblDetalleFactura.Descuento != Descuento)
                {                    
                    //calculamos el total con descuento
                    if (Descuento != 0)
                    {
                        decimal calculo = tblDetalleFactura.PrecioxUnd * Convert.ToDecimal(concat);
                        decimal resta = tblDetalleFactura.PrecioxUnd - calculo;
                        tblDetalleFactura.Total = resta;
                    }
                    else
                    {
                        tblDetalleFactura.Total = tblDetalleFactura.PrecioxUnd;
                    }
                    tblDetalleFactura.Descuento = Descuento;
                    Model.SaveChanges();
                }
            }
            //Cargamos la lista de detalle
            ListaDetalle = Model.TblDetalleFactura.Where(x => x.IdFactura == tblFactura.Id).ToList();

            foreach (TblDetalleFactura d in ListaDetalle)
            {
                SubTotal = SubTotal + d.Total;
            }
            //actualizamos la factura iva, subtotal y total
            iva = Convert.ToDecimal(SubTotal * Convert.ToDecimal(0.15));
            Total = Convert.ToDecimal(SubTotal + iva);

            tblFactura.SubTotal = SubTotal;
            tblFactura.Iva = iva;
            tblFactura.Total = Total;
            tblFactura.FechaModifica = DateTime.Now;
            tblFactura.IdUsuarioModifica = 1;
            Model.SaveChanges();

            return tblFactura.Id;
        }

        //metodo para calcular cuantos articulos hay en existencia(tblProductosAlmacenDet)
        public int CalcularExistencia(int id, string CodFac)
        {
            var Query = from C in Model.TblProductosAlmacenDet
                        where C.IdModelo == id && C.Estado == true
                        select new { C.Id };
            var sum1= Query.ToList().Count;

            var Query2 = from C in Model.TblProductosAlmacenDet
                        where C.CodFactura == CodFac
                        select new { C.Id };
            var sum2 = Query.ToList().Count;

            return sum1 + sum2;
        }
    }
}
