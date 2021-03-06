USE [master]
GO
/****** Object:  Database [Shop]    Script Date: 3/24/2020 11:44:10 PM ******/
CREATE DATABASE [Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Shop', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Shop.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Shop_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Shop_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Shop] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Shop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Shop] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Shop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Shop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Shop]
GO
/****** Object:  Table [dbo].[detail_1]    Script Date: 3/24/2020 11:44:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_1](
	[u_Id] [int] IDENTITY(1,1) NOT NULL,
	[u_Name] [varchar](255) NOT NULL,
	[u_Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[u_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detail_2]    Script Date: 3/24/2020 11:44:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_2](
	[u_Id] [int] IDENTITY(1,1) NOT NULL,
	[u_Name] [varchar](255) NOT NULL,
	[u_Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[u_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[detail_1] ON 

INSERT [dbo].[detail_1] ([u_Id], [u_Name], [u_Age]) VALUES (1, N'areeb', 20)
INSERT [dbo].[detail_1] ([u_Id], [u_Name], [u_Age]) VALUES (2, N'mishal', 14)
SET IDENTITY_INSERT [dbo].[detail_1] OFF
SET IDENTITY_INSERT [dbo].[detail_2] ON 

INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (1, N'atif', 23)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (2, N'asif', 24)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (3, N'roshan', 55)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (4, N'zubaida', 64)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (5, N'haris', 17)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (6, N'bisma', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (7, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (8, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (9, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (10, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (11, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (12, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (13, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (14, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (15, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (16, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (17, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (18, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (19, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (20, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (21, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (22, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (23, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (24, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (25, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (26, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (27, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (28, N'mishal', 14)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (29, N'areeb', 20)
INSERT [dbo].[detail_2] ([u_Id], [u_Name], [u_Age]) VALUES (30, N'mishal', 14)
SET IDENTITY_INSERT [dbo].[detail_2] OFF
USE [master]
GO
ALTER DATABASE [Shop] SET  READ_WRITE 
GO
