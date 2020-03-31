USE [master]
GO
/****** Object:  Database [db2]    Script Date: 3/29/2020 5:18:14 PM ******/
CREATE DATABASE [db2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db2', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\db2.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db2_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\db2_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db2] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db2] SET ARITHABORT OFF 
GO
ALTER DATABASE [db2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db2] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [db2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db2] SET  MULTI_USER 
GO
ALTER DATABASE [db2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db2]
GO
/****** Object:  Table [dbo].[Detail_2]    Script Date: 3/29/2020 5:18:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detail_2](
	[u_Id] [int] IDENTITY(1,1) NOT NULL,
	[u_Name] [varchar](255) NOT NULL,
	[u_Age] [int] NULL,
	[u_Code] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Detail_2] PRIMARY KEY CLUSTERED 
(
	[u_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Detail_2] ADD  CONSTRAINT [DF_Detail_2_u_Code]  DEFAULT ('EA') FOR [u_Code]
GO
USE [master]
GO
ALTER DATABASE [db2] SET  READ_WRITE 
GO
