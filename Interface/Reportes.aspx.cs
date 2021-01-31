using DataModel;
using DataModel.Controllers;
using DataModel.Entidad;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Interface
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static Object GenerarReporte(int IdTipoReporte)
        {

            ReportesController ServiceReporte = new ReportesController();

            Warning[] warnings;
            string[] streamids;
            string mimeType;
            string encoding;
            string filenameExtension;

            var result = ServiceReporte.GenerateReport(IdTipoReporte);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = result.Path;
            ReportDataSource ds = new ReportDataSource("DataSet1", result.Datos);
            localReport.DataSources.Add(ds);

            byte[] bytes = localReport.Render("PDF", null, out mimeType, out filenameExtension, out encoding, out streamids, out warnings);
            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);

            return base64String;
        }

        public List<ReporteCompras> ReporteCompras() {
            ReportesController ServiceReporte = new ReportesController();
            return ServiceReporte.ReporteCompras();
        }
        public List<ReporteVentas> ReporteVentas()
        {
            ReportesController ServiceReporte = new ReportesController();
            return ServiceReporte.ReporteVentas();
        }
        public List<ProductosMasVendidos> ReporteProdMasVendidos()
        {
            FacturaControllers ServiceReporte = new FacturaControllers();
            return ServiceReporte.ProducosMasVendidos();
        }
    }
}