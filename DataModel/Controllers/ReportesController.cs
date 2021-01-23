using DataModel.Entidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.Controllers
{
    public class ReportesController
    {
        public BDSMARTZONEEntities _Context;
        public ReportesController()
        {
            _Context = new BDSMARTZONEEntities();
        }
        public ReportResponse GenerateReport(int IdTipoReporte)
        {
            switch (IdTipoReporte)
            {
                case 1:
                    return new ReportResponse { Path = "ReportCompras.rdlc", Datos = ReporteCompras() };
                case 2:
                    return new ReportResponse { Path = "ReportVentas.rdlc", Datos = ReporteVentas() };
                case 3:
                    return new ReportResponse { Path = "ReporteProductosBodega.rdlc", Datos = new ProductosAlmacenControllers().ReporteProductosAlmacen() };
                case 4:
                    return new ReportResponse { Path = "ReporteProductoGarantia.rdlc", Datos = new FacturaControllers().ProducosGarantia() };
            }
            return new ReportResponse();
        }


        public List<ReporteCompras> ReporteCompras()
        {
            var result = (from pa in _Context.TblProductosAlmacen
                          join pr in _Context.TblProveedores on pa.IdProveedor equals pr.Id
                          select new ReporteCompras
                          {
                              FechaCrea = pa.FechaCrea,
                              Iva = pa.Iva ?? default,
                              Proveedor = pr.Descripcion,
                              Recibo = pa.NumRecibo,
                              SubTotal = pa.SubTotal ?? default,
                              Total = pa.Total ?? default
                          }).ToList();
            return result;
        }

        public List<ReporteVentas> ReporteVentas()
        {
            var result = (from pa in _Context.TblFactura
                          select new ReporteVentas
                          {
                              CodFactura = pa.CodFactura,
                              Total = pa.Total,
                              SubTotal = pa.SubTotal,
                              DatosCliente = pa.DatosCliente,
                              FechaCrea = pa.FechaCrea,
                              Iva = pa.Iva
                          }).ToList();
            return result;
        }
    }
}
