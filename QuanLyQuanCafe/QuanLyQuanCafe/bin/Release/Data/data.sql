USE [master]
GO
/****** Object:  Database [QuanLyQuanCaFe]    Script Date: 7/11/2018 10:34:35 PM ******/
CREATE DATABASE [QuanLyQuanCaFe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCaFe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCaFe.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyQuanCaFe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCaFe_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyQuanCaFe] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCaFe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCaFe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCaFe] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCaFe', N'ON'
GO
USE [QuanLyQuanCaFe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[userName] [nvarchar](100) NOT NULL,
	[displayName] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[passWord] [nvarchar](1000) NOT NULL DEFAULT ((0)),
	[type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datecheckin] [date] NOT NULL DEFAULT (getdate()),
	[datecheckout] [date] NULL,
	[idtable] [int] NOT NULL,
	[status] [int] NOT NULL DEFAULT ((0)),
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idbill] [int] NOT NULL,
	[idfood] [int] NOT NULL,
	[count] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Food]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[idcategory] [int] NOT NULL,
	[price] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[status] [nvarchar](100) NOT NULL DEFAULT (N'Bàn trống'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([userName], [displayName], [passWord], [type]) VALUES (N'ANHKIET', N'ANH KIỆT', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([userName], [displayName], [passWord], [type]) VALUES (N'HOA', N'HOA', N'1962026656160185351301320480154111117132155', 0)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2018-07-10' AS Date), CAST(N'2018-07-10' AS Date), 8, 1, 20, 232000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2018-07-10' AS Date), CAST(N'2018-07-10' AS Date), 2, 1, 10, 45000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 2, 1, 0, 7000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2018-07-11' AS Date), NULL, 3, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 7, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 6, 1, 0, 650000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 14, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 12, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 6, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 11, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 15, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 10, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 6, 1, 0, 26000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 11, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 11, 1, 0, 100000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (69, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 14, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [datecheckin], [datecheckout], [idtable], [status], [discount], [totalPrice]) VALUES (70, CAST(N'2018-07-11' AS Date), CAST(N'2018-07-11' AS Date), 16, 1, 0, 150000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (45, 53, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (46, 53, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (47, 54, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (54, 59, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (55, 59, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (57, 56, 13, 2)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (58, 55, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (59, 58, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (60, 60, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (61, 61, 1, 5)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (62, 62, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (63, 63, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (64, 64, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (65, 65, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (66, 66, 13, 2)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (67, 66, 14, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (68, 67, 3, 2)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (69, 68, 3, 2)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (70, 69, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idbill], [idfood], [count]) VALUES (71, 70, 4, 2)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (1, N'Mực một nắng nướng sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (2, N'Nghêu hấp xã', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (3, N'Dú dê nướng sữa', 2, 50000)
INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (4, N'Heo rừng nướng muối ớt', 3, 75000)
INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (13, N'Coca-cola', 4, 7000)
INSERT [dbo].[Food] ([id], [name], [idcategory], [price]) VALUES (14, N'Cà phê', 4, 12000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nước')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 10', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 11', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 12', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 13', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 14', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 15', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 16', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 17', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 18', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 19', N'Bàn trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Bàn 20', N'Bàn trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idtable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idbill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idfood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idcategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
BEGIN 
	SELECT * FROM dbo.Account WHERE userName = @userName 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetBillByDate]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetBillByDate]
@datecheckin date, @datecheckout date
AS 
BEGIN
	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], b.datecheckin AS [Ngày vào], b.datecheckout AS [Ngày ra], b.discount AS [Giảm giá]
	FROM dbo.Bill AS b, dbo.TableFood AS t
	WHERE datecheckin >= @datecheckin AND datecheckout <= @datecheckout AND b.status = 1
	AND t.id = b.idtable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetBillByDateAndPage]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetBillByDateAndPage]
@datecheckin date, @datecheckout DATE, @page INT
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows * @page
	DECLARE @exceptRow INT = (@page - 1) * @pageRows
	 
	;WITH BillShow as (SELECT b.id, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], b.datecheckin AS [Ngày vào], b.datecheckout AS [Ngày ra], b.discount AS [Giảm giá]
	FROM dbo.Bill AS b, dbo.TableFood AS t
	WHERE datecheckin >= @datecheckin AND datecheckout <= @datecheckout AND b.status = 1
	AND t.id = b.idtable)
	
	SELECT TOP (@pageRows) * FROM BillShow WHERE BillShow.id NOT IN
	(SELECT TOP (@exceptRow) id FROM BillShow)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetNumBillByDate]
@datecheckin date, @datecheckout date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b, dbo.TableFood AS t
	WHERE datecheckin >= @datecheckin AND datecheckout <= @datecheckout AND b.status = 1
	AND t.id = b.idtable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable int
AS
BEGIN
	INSERT INTO dbo.Bill
	        ( datecheckin ,
	          datecheckout ,
	          idtable ,
	          status,
			  discount
	        )
	VALUES  ( GETDATE() , -- datecheckin - date
	          NULL , -- datecheckout - date
	          @idTable , -- idtable - int
	          0  ,-- status - int
			  0
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	
	DECLARE @isExitsBillInfo int;
	DECLARE @foodCount int = 1;

	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN 
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idfood = @idFood
		ELSE 
			DELETE dbo.BillInfo WHERE idbill = @idBill AND idfood = @idFood
	END 
	ELSE
	BEGIN 
		INSERT INTO dbo.BillInfo
				( idbill, idfood, count )
		VALUES  ( @idBill, -- idbill - int
				 @idFood, -- idfood - int
				@count  -- count - int
				)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN 
	SELECT * FROM dbo.Account WHERE userName = @userName AND passWord = @passWord
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableFood SET status = N'Bàn trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableFood SET status = N'Bàn trống' WHERE id = @idTable1
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 7/11/2018 10:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- Update thông tin cá nhân
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN 
	DECLARE @isRightPass INT 
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE userName = @userName AND passWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@password = NULL OR @newPassword = '')
		BEGIN 
			UPDATE dbo.Account SET displayName = @displayName WHERE userName = @userName
		END 
		ELSE
			UPDATE dbo.Account SET displayName = @displayName, passWord = @newPassword WHERE userName = @userName
	END
END 

GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCaFe] SET  READ_WRITE 
GO
