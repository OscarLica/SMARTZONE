﻿//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataModel
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class BDSMARTZONEEntities : DbContext
    {
        public BDSMARTZONEEntities()
            : base("name=BDSMARTZONEEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<TblAlmacen> TblAlmacen { get; set; }
        public DbSet<TblProductosAlmacen> TblProductosAlmacen { get; set; }
        public DbSet<TblProductosAlmacenDet> TblProductosAlmacenDet { get; set; }
        public DbSet<TblCategorias> TblCategorias { get; set; }
        public DbSet<TblGama> TblGama { get; set; }
        public DbSet<TblMarca> TblMarca { get; set; }
        public DbSet<TblModelo> TblModelo { get; set; }
        public DbSet<TblMoneda> TblMoneda { get; set; }
        public DbSet<TblProductos> TblProductos { get; set; }
        public DbSet<TblProveedores> TblProveedores { get; set; }
        public DbSet<DetalleCompra> DetalleCompra { get; set; }
        public DbSet<DetalleVenta> DetalleVenta { get; set; }
        public DbSet<TblCompras> TblCompras { get; set; }
        public DbSet<TblDetalleFactura> TblDetalleFactura { get; set; }
        public DbSet<TblFactura> TblFactura { get; set; }
        public DbSet<TblMaestra> TblMaestra { get; set; }
        public DbSet<TblVentas> TblVentas { get; set; }
        public DbSet<TblConfiguracion> TblConfiguracion { get; set; }
        public DbSet<TblEmpleado> TblEmpleado { get; set; }
        public DbSet<TblRol> TblRol { get; set; }
        public DbSet<TblUserRol> TblUserRol { get; set; }
        public DbSet<TblUsuario> TblUsuario { get; set; }
    }
}
