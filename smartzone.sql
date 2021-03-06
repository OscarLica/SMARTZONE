USE [master]
GO
/****** Object:  Database [BDSMARTZONE]    Script Date: 24/01/2021 9:51:30 ******/
CREATE DATABASE [BDSMARTZONE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BDSMARTZONE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BDSMARTZONE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BDSMARTZONE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BDSMARTZONE_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BDSMARTZONE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BDSMARTZONE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BDSMARTZONE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET ARITHABORT OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BDSMARTZONE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BDSMARTZONE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BDSMARTZONE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BDSMARTZONE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET RECOVERY FULL 
GO
ALTER DATABASE [BDSMARTZONE] SET  MULTI_USER 
GO
ALTER DATABASE [BDSMARTZONE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BDSMARTZONE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BDSMARTZONE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BDSMARTZONE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BDSMARTZONE] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BDSMARTZONE', N'ON'
GO
ALTER DATABASE [BDSMARTZONE] SET QUERY_STORE = OFF
GO
USE [BDSMARTZONE]
GO
/****** Object:  Schema [ALM]    Script Date: 24/01/2021 9:51:30 ******/
CREATE SCHEMA [ALM]
GO
/****** Object:  Schema [CAT]    Script Date: 24/01/2021 9:51:30 ******/
CREATE SCHEMA [CAT]
GO
/****** Object:  Schema [FAC]    Script Date: 24/01/2021 9:51:30 ******/
CREATE SCHEMA [FAC]
GO
/****** Object:  Schema [SEG]    Script Date: 24/01/2021 9:51:30 ******/
CREATE SCHEMA [SEG]
GO
/****** Object:  Table [ALM].[TblAlmacen]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALM].[TblAlmacen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[CodBodega] [nvarchar](15) NOT NULL,
	[Capacidad] [int] NOT NULL,
	[Disponible] [int] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblAlmacen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ALM].[TblProductosAlmacen]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALM].[TblProductosAlmacen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[NumRecibo] [nvarchar](50) NOT NULL,
	[SubTotal] [decimal](18, 2) NULL,
	[Iva] [decimal](18, 2) NULL,
	[ExcentoIva] [bit] NULL,
	[Total] [decimal](18, 2) NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblProductosAlmacen_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ALM].[TblProductosAlmacenDet]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ALM].[TblProductosAlmacenDet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProductosAlmacen] [int] NOT NULL,
	[IdModelo] [int] NOT NULL,
	[CodProducto] [nvarchar](50) NULL,
	[Serie] [nvarchar](50) NULL,
	[IMEI] [nvarchar](50) NULL,
	[Estado] [bit] NOT NULL,
	[PrecioC] [int] NOT NULL,
	[PrecioV] [int] NULL,
	[CodFactura] [nvarchar](50) NULL,
	[FechaBaja] [datetime] NULL,
	[MotivoBaja] [nvarchar](50) NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblProductosAlmacen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblCategorias]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblCategorias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblCategorias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblGama]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblGama](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblGama] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblMarca]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblMarca](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblMarca] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblModelo]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblModelo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProducto] [int] NOT NULL,
	[IdGama] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[Especificaciones] [nvarchar](300) NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblModelo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblMoneda]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblMoneda](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[Simbolo] [nvarchar](5) NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblMoneda] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblProductos]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblProductos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAlmacen] [int] NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[IdMarca] [int] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblProductos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CAT].[TblProveedores]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CAT].[TblProveedores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[RUC] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](25) NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblProveedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [FAC].[DetalleCompra]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[DetalleCompra](
	[IdDetalleCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdCompra] [int] NOT NULL,
	[IdProducto] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [FAC].[DetalleVenta]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[DetalleVenta](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[Idventa] [int] NOT NULL,
	[IdProducto] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [FAC].[TblCompras]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[TblCompras](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[NoFactura] [varchar](100) NULL,
	[FechaCompra] [datetime] NOT NULL,
	[Iva] [decimal](5, 2) NULL,
	[Total] [decimal](5, 2) NULL,
	[SubTotal] [decimal](5, 2) NULL,
	[IdProveedor] [int] NOT NULL,
	[Anulada] [bit] NULL,
	[MotivoAnulada] [nvarchar](max) NULL,
	[FechaAnulada] [datetime] NULL,
	[IdUsuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [FAC].[TblDetalleFactura]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[TblDetalleFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdFactura] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Descuento] [int] NOT NULL,
	[PrecioxUnd] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[GarantiaDias] [int] NULL,
	[FechaVenceGarantia] [datetime] NULL,
 CONSTRAINT [PK_TblDetalleFactura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [FAC].[TblFactura]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[TblFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdMoneda] [int] NOT NULL,
	[CodFactura] [nvarchar](50) NOT NULL,
	[DatosCliente] [nvarchar](150) NULL,
	[Estado] [nvarchar](30) NOT NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
	[Iva] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[Efectivo] [decimal](18, 2) NULL,
	[Vuelto] [decimal](18, 2) NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblFactura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [FAC].[TblMaestra]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[TblMaestra](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDetalleFactura] [int] NOT NULL,
	[IdDetalleAlmacen] [int] NOT NULL,
	[IdFactura] [int] NOT NULL,
 CONSTRAINT [PK_TblMaestra] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [FAC].[TblVentas]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FAC].[TblVentas](
	[Idventa] [int] IDENTITY(1,1) NOT NULL,
	[NoFactura] [varchar](100) NULL,
	[FechaVenta] [datetime] NOT NULL,
	[Iva] [decimal](5, 2) NULL,
	[Total] [decimal](5, 2) NULL,
	[SubTotal] [decimal](5, 2) NULL,
	[Cliente] [int] NOT NULL,
	[Anulada] [bit] NULL,
	[MotivoAnulada] [nvarchar](max) NULL,
	[FechaAnulada] [datetime] NULL,
	[IdUsuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Idventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [SEG].[TblConfiguracion]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEG].[TblConfiguracion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpresa] [nvarchar](50) NOT NULL,
	[RUC] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[Telefono] [nvarchar](15) NULL,
	[Logo] [varbinary](max) NULL,
	[IdUsurioCrea] [int] NOT NULL,
	[IdUsurioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblConfiguracion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [SEG].[TblEmpleado]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEG].[TblEmpleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PrimerNombre] [nvarchar](25) NOT NULL,
	[SegundoNombre] [nvarchar](25) NULL,
	[PrimerApellido] [nvarchar](25) NOT NULL,
	[SegundoApellido] [nvarchar](25) NULL,
	[Identificacion] [nvarchar](25) NOT NULL,
	[Direccion] [nvarchar](100) NOT NULL,
	[Celular] [nvarchar](25) NULL,
	[Notas] [nvarchar](25) NULL,
	[Estado] [bit] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblEmpleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SEG].[TblRol]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEG].[TblRol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblRol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SEG].[TblUserRol]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEG].[TblUserRol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[IdRol] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblUserRol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SEG].[TblUsuario]    Script Date: 24/01/2021 9:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEG].[TblUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[Session] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[Estado] [bit] NOT NULL,
	[IdUsuarioCrea] [int] NOT NULL,
	[IdUsuarioModifica] [int] NULL,
	[FechaCrea] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [PK_TblUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ALM].[TblProductosAlmacen]  WITH CHECK ADD  CONSTRAINT [FK_TblProductosAlmacen_TblProveedores] FOREIGN KEY([IdProveedor])
REFERENCES [CAT].[TblProveedores] ([Id])
GO
ALTER TABLE [ALM].[TblProductosAlmacen] CHECK CONSTRAINT [FK_TblProductosAlmacen_TblProveedores]
GO
ALTER TABLE [ALM].[TblProductosAlmacenDet]  WITH CHECK ADD  CONSTRAINT [FK_TblProductosAlmacenDet_TblModelo] FOREIGN KEY([IdModelo])
REFERENCES [CAT].[TblModelo] ([Id])
GO
ALTER TABLE [ALM].[TblProductosAlmacenDet] CHECK CONSTRAINT [FK_TblProductosAlmacenDet_TblModelo]
GO
ALTER TABLE [ALM].[TblProductosAlmacenDet]  WITH CHECK ADD  CONSTRAINT [FK_TblProductosAlmacenDet_TblProductosAlmacen] FOREIGN KEY([IdProductosAlmacen])
REFERENCES [ALM].[TblProductosAlmacen] ([Id])
GO
ALTER TABLE [ALM].[TblProductosAlmacenDet] CHECK CONSTRAINT [FK_TblProductosAlmacenDet_TblProductosAlmacen]
GO
ALTER TABLE [CAT].[TblModelo]  WITH CHECK ADD  CONSTRAINT [FK_TblModelo_TblGama] FOREIGN KEY([IdGama])
REFERENCES [CAT].[TblGama] ([Id])
GO
ALTER TABLE [CAT].[TblModelo] CHECK CONSTRAINT [FK_TblModelo_TblGama]
GO
ALTER TABLE [CAT].[TblModelo]  WITH CHECK ADD  CONSTRAINT [FK_TblModelo_TblProductos] FOREIGN KEY([IdProducto])
REFERENCES [CAT].[TblProductos] ([Id])
GO
ALTER TABLE [CAT].[TblModelo] CHECK CONSTRAINT [FK_TblModelo_TblProductos]
GO
ALTER TABLE [CAT].[TblProductos]  WITH CHECK ADD  CONSTRAINT [FK_TblProductos_TblAlmacen] FOREIGN KEY([IdAlmacen])
REFERENCES [ALM].[TblAlmacen] ([Id])
GO
ALTER TABLE [CAT].[TblProductos] CHECK CONSTRAINT [FK_TblProductos_TblAlmacen]
GO
ALTER TABLE [CAT].[TblProductos]  WITH CHECK ADD  CONSTRAINT [FK_TblProductos_TblCategorias] FOREIGN KEY([IdCategoria])
REFERENCES [CAT].[TblCategorias] ([Id])
GO
ALTER TABLE [CAT].[TblProductos] CHECK CONSTRAINT [FK_TblProductos_TblCategorias]
GO
ALTER TABLE [CAT].[TblProductos]  WITH CHECK ADD  CONSTRAINT [FK_TblProductos_TblMarca] FOREIGN KEY([IdMarca])
REFERENCES [CAT].[TblMarca] ([Id])
GO
ALTER TABLE [CAT].[TblProductos] CHECK CONSTRAINT [FK_TblProductos_TblMarca]
GO
ALTER TABLE [FAC].[DetalleCompra]  WITH CHECK ADD  CONSTRAINT [FKDetCompra] FOREIGN KEY([IdCompra])
REFERENCES [FAC].[TblCompras] ([IdCompra])
GO
ALTER TABLE [FAC].[DetalleCompra] CHECK CONSTRAINT [FKDetCompra]
GO
ALTER TABLE [FAC].[DetalleVenta]  WITH CHECK ADD  CONSTRAINT [FKDetVentas] FOREIGN KEY([Idventa])
REFERENCES [FAC].[TblVentas] ([Idventa])
GO
ALTER TABLE [FAC].[DetalleVenta] CHECK CONSTRAINT [FKDetVentas]
GO
ALTER TABLE [FAC].[TblDetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_TblDetalleFactura_TblFactura] FOREIGN KEY([IdFactura])
REFERENCES [FAC].[TblFactura] ([Id])
GO
ALTER TABLE [FAC].[TblDetalleFactura] CHECK CONSTRAINT [FK_TblDetalleFactura_TblFactura]
GO
ALTER TABLE [FAC].[TblFactura]  WITH CHECK ADD  CONSTRAINT [FK_TblFactura_TblMoneda] FOREIGN KEY([IdMoneda])
REFERENCES [CAT].[TblMoneda] ([Id])
GO
ALTER TABLE [FAC].[TblFactura] CHECK CONSTRAINT [FK_TblFactura_TblMoneda]
GO
ALTER TABLE [SEG].[TblUserRol]  WITH CHECK ADD  CONSTRAINT [FK_TblUserRol_TblRol] FOREIGN KEY([IdRol])
REFERENCES [SEG].[TblRol] ([Id])
GO
ALTER TABLE [SEG].[TblUserRol] CHECK CONSTRAINT [FK_TblUserRol_TblRol]
GO
ALTER TABLE [SEG].[TblUserRol]  WITH CHECK ADD  CONSTRAINT [FK_TblUserRol_TblUsuario] FOREIGN KEY([IdUsuario])
REFERENCES [SEG].[TblUsuario] ([Id])
GO
ALTER TABLE [SEG].[TblUserRol] CHECK CONSTRAINT [FK_TblUserRol_TblUsuario]
GO
ALTER TABLE [SEG].[TblUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TblUsuario_TblEmpleado] FOREIGN KEY([IdEmpleado])
REFERENCES [SEG].[TblEmpleado] ([Id])
GO
ALTER TABLE [SEG].[TblUsuario] CHECK CONSTRAINT [FK_TblUsuario_TblEmpleado]
GO
USE [master]
GO
ALTER DATABASE [BDSMARTZONE] SET  READ_WRITE 
GO
