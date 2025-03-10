USE [master]
GO
/****** Object:  Database [TestStore]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE DATABASE [TestStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestStore] SET  MULTI_USER 
GO
ALTER DATABASE [TestStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TestStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [TestStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TestStore]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productId] [int] IDENTITY(1,1) NOT NULL,
	[productName] [nvarchar](40) NOT NULL,
	[code] [nvarchar](10) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[unitprice] [money] NOT NULL,
	[stock] [int] NOT NULL,
	[categoryid] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewProducts]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ViewProducts] AS
	
	SELECT
	productId,
	productName,
	code,
	[description],
	unitprice,
	stock,
	CT.categoryId,
	CT.categoryName
	FROM Product AS PD
	INNER JOIN Category AS CT ON CT.categoryId = PD.categoryid

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customerId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[email] [nvarchar](40) NOT NULL,
	[address] [nvarchar](60) NOT NULL,
	[phone] [nvarchar](24) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[orderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [smallint] NOT NULL,
	[unitPrice] [money] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_orderId]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE CLUSTERED INDEX [IDX_orderId] ON [dbo].[OrderDetail]
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[orderid] [int] IDENTITY(1,1) NOT NULL,
	[customerId] [int] NOT NULL,
	[orderDate] [datetime] NOT NULL,
	[orderTotal] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[orderid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (9, N'Automotive')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (8, N'Beauty')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (4, N'Books')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (2, N'Clothing')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (1, N'Electronics')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (6, N'Furniture')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (10, N'Grocery')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (3, N'Home Appliances')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (7, N'Sports')
INSERT [dbo].[Category] ([categoryId], [categoryName]) VALUES (5, N'Toys')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (1, N'John Doe', N'johndoe@email.com', N'123 Main St, NY', N'123-456-7890')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (2, N'Jane Smith', N'janesmith@email.com', N'456 Elm St, CA', N'987-654-3210')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (3, N'Michael Brown', N'michaelb@email.com', N'789 Oak St, TX', N'555-123-4567')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (4, N'Emily Davis', N'emilyd@email.com', N'321 Pine St, FL', N'444-987-6543')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (5, N'Robert Wilson', N'robertw@email.com', N'654 Maple St, IL', N'222-333-4444')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (6, N'Laura Johnson', N'lauraj@email.com', N'987 Cedar St, WA', N'111-222-3333')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (7, N'David White', N'davidw@email.com', N'147 Birch St, NV', N'666-777-8888')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (8, N'Sophia Martinez', N'sophiam@email.com', N'258 Walnut St, CO', N'999-888-7777')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (9, N'James Anderson', N'jamesa@email.com', N'369 Palm St, AZ', N'333-222-1111')
INSERT [dbo].[Customer] ([customerId], [name], [email], [address], [phone]) VALUES (10, N'Olivia Harris', N'oliviah@email.com', N'852 Cherry St, OR', N'777-666-5555')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (1, N'Smartphone', N'SM001', N'Latest model smartphone', 699.9900, 25, 1)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (2, N'Laptop', N'LP002', N'15-inch gaming laptop', 1299.9900, 21, 1)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (3, N'Bluetooth Headphones', N'BT003', N'Wireless noise-canceling headphones', 199.9900, 80, 1)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (4, N'T-Shirt', N'TS004', N'Cotton round neck t-shirt', 19.9900, 100, 2)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (5, N'Jeans', N'JN005', N'Slim fit denim jeans', 49.9900, 60, 2)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (6, N'Refrigerator', N'RF006', N'Double-door refrigerator', 899.9900, 20, 3)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (7, N'Microwave Oven', N'MW007', N'800W digital microwave oven', 120.9900, 25, 3)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (8, N'Science Fiction Book', N'BK008', N'Bestselling sci-fi novel', 14.9900, 200, 4)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (9, N'Children''s Toy Car', N'TY009', N'Remote-controlled toy car', 34.9900, 150, 5)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (10, N'Dining Table', N'FT010', N'6-seater wooden dining table', 599.9900, 15, 6)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (11, N'Football', N'SP011', N'Official size football', 29.9900, 70, 7)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (12, N'Running Shoes', N'SP012', N'Lightweight running shoes', 79.9900, 40, 7)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (13, N'Face Cream', N'BT013', N'Hydrating face cream', 24.9900, 120, 8)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (14, N'Car Battery', N'AU014', N'12V high-performance battery', 199.9900, 50, 9)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (15, N'Cereal Box', N'GR015', N'Healthy breakfast cereal', 5.9900, 300, 10)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (16, N'LED TV', N'TV016', N'50-inch 4K UHD Smart TV', 699.9900, 40, 1)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (17, N'Leather Jacket', N'CJ017', N'Men''s leather biker jacket', 149.9900, 20, 2)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (18, N'Washing Machine', N'WM018', N'8kg front load washing machine', 499.9900, 10, 3)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (19, N'Board Game', N'BG019', N'Classic strategy board game', 39.9900, 60, 5)
INSERT [dbo].[Product] ([productId], [productName], [code], [description], [unitprice], [stock], [categoryid]) VALUES (20, N'Perfume', N'PF020', N'Luxury fragrance', 89.9900, 35, 8)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_categoryName]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE NONCLUSTERED INDEX [IDX_categoryName] ON [dbo].[Category]
(
	[categoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_name]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE NONCLUSTERED INDEX [IDX_name] ON [dbo].[Customer]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_OrderDetail]    Script Date: 2/27/2025 11:37:54 PM ******/
ALTER TABLE [dbo].[OrderDetail] ADD  CONSTRAINT [PK_OrderDetail] PRIMARY KEY NONCLUSTERED 
(
	[orderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_productId]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE NONCLUSTERED INDEX [IDX_productId] ON [dbo].[OrderDetail]
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_customerId]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE NONCLUSTERED INDEX [IDX_customerId] ON [dbo].[Orders]
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_categoryId]    Script Date: 2/27/2025 11:37:54 PM ******/
CREATE NONCLUSTERED INDEX [IDX_categoryId] ON [dbo].[Product]
(
	[categoryid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([orderId])
REFERENCES [dbo].[Orders] ([orderid])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([productId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customer] FOREIGN KEY([customerId])
REFERENCES [dbo].[Customer] ([customerId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customer]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([categoryid])
REFERENCES [dbo].[Category] ([categoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddOrderDetail]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--//-------------------------------------//
/*
	Name: Juan Carrasco.
	Date: 21/02/2025
	description: The check is made for stocks and get unitPrice, blocking the update and ensuring the execution of the block (ROWLOCK).
	If there is an error, a message is returned (specifying the severity) and the insertion is avoided.

*/
--//-----------------------------------//
CREATE PROCEDURE [dbo].[SP_AddOrderDetail]
	@OrderId INT,
	@ProductId INT,
	@Quantity INT
AS
BEGIN
	
	DECLARE @productStock int,
	@productUnitPrice money,
	@productName nvarchar(40)

	BEGIN TRANSACTION
    
    BEGIN TRY

		SELECT @productStock = stock,
		@productUnitPrice = unitprice,
		@productName = productName
		FROM Product WITH (ROWLOCK) 
		WHERE productId = @ProductId

		IF @productStock < @Quantity
        BEGIN
			--Juan Carrasco: ROLLBACK TRANSACTION before RAISERROR to ensure that the transaction closes correctly.
			ROLLBACK TRANSACTION;

            DECLARE @errorMessage NVARCHAR(100) = 
				FORMATMESSAGE(N'%s out of stock. %d units currently in stock', @productName, @productStock);

				RAISERROR (@errorMessage, 16, 1, @productName, @productStock);

			RETURN;
        END

        INSERT INTO OrderDetail(orderId, productId, quantity, unitPrice)
        VALUES (@OrderId, @ProductId, @Quantity, @productUnitPrice);

        UPDATE Product WITH (ROWLOCK)
        SET stock = stock - @Quantity
        WHERE productId = @ProductId;

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
		--Juan Carrasco: to avoid errors if there is no active transaction.
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; 
        THROW
    END CATCH	  

END
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateOrder]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--//-------------------------------------//
/*
	Name: Juan Carrasco.
	Date: 21/02/2025
	description: Create the order after products selected

*/
--//-----------------------------------//
CREATE PROCEDURE [dbo].[SP_CreateOrder]
	@CustomerId INT
AS
BEGIN

        INSERT INTO Orders(customerId, orderDate)
        VALUES (@CustomerId, GETDATE())
		
        SELECT SCOPE_IDENTITY() AS OrderId
        

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomers]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--//-------------------------------------//
/*
	Name: Juan Carrasco.
	Date: 22/02/2025
	description: Get the Customers.

*/
--//-----------------------------------//

CREATE PROCEDURE [dbo].[SP_GetCustomers]

AS
BEGIN
	SELECT 
		customerId,
		[name],
		[address],
		email,
		phone
		FROM Customer
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOrderById]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--//-------------------------------------//
/*
	Name: Juan Carrasco.
	Date: 22/02/2025
	description: Get the Order by Id.

*/
--//-----------------------------------//

CREATE PROCEDURE [dbo].[SP_GetOrderById]
@OrderId INT
AS
BEGIN
	SELECT 
		OD.orderid,
		OD.orderDate,
		OD.orderTotal,
		CT.customerId,
		CT.[name],
		CT.[address],
		CT.email,
		CT.phone
		FROM Orders AS OD
		INNER JOIN Customer AS CT ON CT.customerId = OD.customerId
		WHERE OD.orderid = @orderId;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProducts]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_GetProducts]

@offset int,
@pageSize int

AS
BEGIN

	SELECT
	PD.productId,
	PD.productName,
	PD.code,
	PD.[description],
	PD.unitprice,
	PD.stock,
	CT.categoryId,
	CT.categoryName
	FROM Product AS PD
	INNER JOIN Category AS CT ON CT.categoryId = PD.categoryid
	ORDER BY PD.productId
	OFFSET ISNULL(@offset, 0) ROWS FETCH NEXT ISNULL(@pageSize, 10) ROWS ONLY;

END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateOrderTotal]    Script Date: 2/27/2025 11:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--//-------------------------------------//
/*
	Name: Juan Carrasco.
	Date: 21/02/2025
	description: The total value of the order is being inserted, updating the orderTotal column.

*/
--//-----------------------------------//
CREATE PROCEDURE [dbo].[SP_UpdateOrderTotal]
	@OrderId INT
AS
BEGIN

	BEGIN TRANSACTION
    
    BEGIN TRY

		UPDATE Orders 
		SET orderTotal = (
			SELECT ISNULL(SUM(unitprice * quantity), 0) 
			FROM OrderDetail
			WHERE orderId = @OrderId
		)
		WHERE orderid = @OrderId;
        
		COMMIT TRANSACTION;	

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH	  

END
GO
USE [master]
GO
ALTER DATABASE [TestStore] SET  READ_WRITE 
GO
