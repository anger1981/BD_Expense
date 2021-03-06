USE [test]
GO
/****** Object:  Database [BD_ExpenseRelease]    Script Date: 05.06.2020 1:43:59 ******/
CREATE DATABASE [BD_ExpenseRelease]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_ExpenseRelease', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.HOMESCBD\MSSQL\DATA\BD_ExpenseRelease.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BD_ExpenseRelease_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.HOMESCBD\MSSQL\DATA\BD_ExpenseRelease_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BD_ExpenseRelease] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_ExpenseRelease].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BD_ExpenseRelease] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET ARITHABORT OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BD_ExpenseRelease] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BD_ExpenseRelease] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BD_ExpenseRelease] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BD_ExpenseRelease] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BD_ExpenseRelease] SET  MULTI_USER 
GO
ALTER DATABASE [BD_ExpenseRelease] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BD_ExpenseRelease] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BD_ExpenseRelease] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BD_ExpenseRelease] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BD_ExpenseRelease] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BD_ExpenseRelease]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Expense]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expense](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL CONSTRAINT [DF_Expense_Date]  DEFAULT (getdate()),
	[Client_ID] [int] NULL,
	[Total_Sum] [money] NOT NULL DEFAULT ((0.00)),
	[Time_Create] [datetime] NULL,
	[Spended] [bit] NOT NULL DEFAULT ((0)),
	[Time_Spend] [datetime] NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Expense_Spec]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expense_Spec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Expense_ID] [int] NOT NULL,
	[Product_ID] [int] NOT NULL,
	[Count] [int] NULL DEFAULT ((0)),
	[Price] [money] NULL DEFAULT ((0.00)),
	[Summa] [money] NULL DEFAULT ((0.00)),
 CONSTRAINT [PK_Expense_Spec] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_Espense_Spec_Product]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Espense_Spec_Product]
AS
SELECT        dbo.Expense_Spec.ID, dbo.Product.Name, dbo.Expense_Spec.Price, dbo.Expense_Spec.Count, dbo.Expense_Spec.Summa
FROM            dbo.Expense_Spec INNER JOIN
                         dbo.Product ON dbo.Expense_Spec.Product_ID = dbo.Product.ID

GO
/****** Object:  View [dbo].[View_Expense_Client]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Expense_Client]
AS
SELECT        dbo.Expense.ID, dbo.Client.Name, dbo.Expense.Date, dbo.Expense.Total_Sum, dbo.Expense.Spended, dbo.Expense.Time_Spend
FROM            dbo.Client RIGHT OUTER JOIN
                         dbo.Expense ON dbo.Client.ID = dbo.Expense.Client_ID

GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ID], [Name]) VALUES (1, N'Smith')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (2, N'Иванов')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (3, N'Петренко')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (5, N'Сидоренко')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (6, N'Black')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (7, N'Orange')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (10, N'Brown')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (12, N'Purple')
INSERT [dbo].[Client] ([ID], [Name]) VALUES (13, N'Васильев')
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[Expense] ON 

INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2032, CAST(N'2020-06-04 03:15:49.573' AS DateTime), 3, 0.0000, CAST(N'2020-06-04 03:15:49.573' AS DateTime), 1, CAST(N'2020-06-04 12:28:12.707' AS DateTime))
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2033, CAST(N'2020-06-04 03:15:51.230' AS DateTime), 3, 33.0000, CAST(N'2020-06-04 03:15:51.230' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2034, CAST(N'2020-06-04 03:15:56.203' AS DateTime), 5, 181.0000, CAST(N'2020-06-04 03:15:56.220' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2035, CAST(N'2020-06-04 03:15:59.593' AS DateTime), 7, 1134.0000, CAST(N'2020-06-04 03:15:59.593' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2036, CAST(N'2020-06-04 21:12:01.363' AS DateTime), 1, 0.0000, CAST(N'2020-06-04 21:12:01.413' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2038, CAST(N'2020-06-04 21:12:09.640' AS DateTime), 2, 0.0000, CAST(N'2020-06-04 21:12:09.643' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2039, CAST(N'2020-06-04 21:12:13.340' AS DateTime), 6, 83.0000, CAST(N'2020-06-04 21:12:13.343' AS DateTime), 1, CAST(N'2020-06-04 21:13:33.037' AS DateTime))
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2040, CAST(N'2020-06-04 21:12:16.830' AS DateTime), 6, 0.0000, CAST(N'2020-06-04 21:12:16.830' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2041, CAST(N'2020-06-04 21:12:20.400' AS DateTime), 7, 0.0000, CAST(N'2020-06-04 21:12:20.400' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2042, CAST(N'2020-06-04 21:12:23.180' AS DateTime), 10, 0.0000, CAST(N'2020-06-04 21:12:23.180' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2043, CAST(N'2020-06-04 21:12:27.660' AS DateTime), 12, 0.0000, CAST(N'2020-06-04 21:12:27.660' AS DateTime), 0, NULL)
INSERT [dbo].[Expense] ([ID], [Date], [Client_ID], [Total_Sum], [Time_Create], [Spended], [Time_Spend]) VALUES (2044, CAST(N'2020-06-04 21:12:30.723' AS DateTime), 13, 0.0000, CAST(N'2020-06-04 21:12:30.723' AS DateTime), 0, NULL)
SET IDENTITY_INSERT [dbo].[Expense] OFF
SET IDENTITY_INSERT [dbo].[Expense_Spec] ON 

INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3156, 2035, 2, 10, 5.0000, 50.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3161, 2034, 4, 5, 5.0000, 25.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3162, 2034, 5, 3, 3.0000, 9.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3163, 2034, 6, 8, 8.0000, 64.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3165, 2035, 3, 1, 1000.0000, 1000.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3166, 2035, 5, 5, 5.0000, 25.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3167, 2035, 6, 3, 3.0000, 9.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3168, 2035, 7, 1, 50.0000, 50.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3174, 2039, 7, 7, 7.0000, 49.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3175, 2038, 2, 0, 0.0000, 0.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3177, 2033, 1, 5, 5.0000, 25.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3179, 2033, 8, 8, 1.0000, 8.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3181, 2034, 4, 1, 5.0000, 5.0000)
INSERT [dbo].[Expense_Spec] ([ID], [Expense_ID], [Product_ID], [Count], [Price], [Summa]) VALUES (3182, 2034, 5, 1, 3.0000, 3.0000)
SET IDENTITY_INSERT [dbo].[Expense_Spec] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name]) VALUES (1, N'Брюки     ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (2, N'Футболка  ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (3, N'Автомобиль')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (4, N'Хлеб      ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (5, N'Аспирин   ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (6, N'Сахар     ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (7, N'Смартфон  ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (8, N'Носки     ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (9, N'Сосиски   ')
INSERT [dbo].[Product] ([ID], [Name]) VALUES (10, N'Стол      ')
SET IDENTITY_INSERT [dbo].[Product] OFF
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Client] FOREIGN KEY([Client_ID])
REFERENCES [dbo].[Client] ([ID])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Client]
GO
ALTER TABLE [dbo].[Expense_Spec]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Spec_Expense] FOREIGN KEY([Expense_ID])
REFERENCES [dbo].[Expense] ([ID])
GO
ALTER TABLE [dbo].[Expense_Spec] CHECK CONSTRAINT [FK_Expense_Spec_Expense]
GO
ALTER TABLE [dbo].[Expense_Spec]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Spec_Product] FOREIGN KEY([Product_ID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Expense_Spec] CHECK CONSTRAINT [FK_Expense_Spec_Product]
GO
/****** Object:  StoredProcedure [dbo].[sp_Upd_Total_Sum_Expense ]    Script Date: 05.06.2020 1:43:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ангерчик Андрей
-- Create date: 29.05.2020
-- =============================================
CREATE PROCEDURE [dbo].[sp_Upd_Total_Sum_Expense ](
	@Upd_expense_ID int -- ID расхода, сумму которого нужно пересчитать
	)
AS
SET NOCOUNT ON;
declare     @total_summ money
BEGIN TRY
   BEGIN TRANSACTION;

	set @total_summ = ISNULL(
	(select sum(es.Summa) 
	from Expense_Spec es 
	where es.Expense_ID = @Upd_expense_ID),
	0);

	 update Expense
	 set Total_Sum = @total_summ
	 where ID = @Upd_expense_ID

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
  -- Determine if an error occurred.
  IF @@TRANCOUNT > 0
     ROLLBACK

  DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return 
    -- error information about the original error that 
    -- caused execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Client', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Название' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Client', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Клиент' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Дата' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код клиента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Client_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Общая сумма' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Total_Sum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Когда создали расход' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Time_Create'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Признак проведения расхода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Spended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Когда провели расход' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense', @level2type=N'COLUMN',@level2name=N'Time_Spend'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Расход' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код  Расхода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'Expense_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код товара' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'Product_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Количество' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Цена' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Сумма' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec', @level2type=N'COLUMN',@level2name=N'Summa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Содержимое расхода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Expense_Spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Название' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Товар' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Expense_Spec"
            Begin Extent = 
               Top = 11
               Left = 357
               Bottom = 140
               Right = 531
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 2
               Left = 589
               Bottom = 97
               Right = 763
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3750
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Espense_Spec_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Espense_Spec_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 101
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Expense"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 135
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3030
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Expense_Client'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Expense_Client'
GO
USE [master]
GO
ALTER DATABASE [BD_ExpenseRelease] SET  READ_WRITE 
GO

USE [BD_ExpenseRelease]
GO

--/****** Object:  Trigger [AI_Expense]    Script Date: 05.06.2020 8:52:16 ******/
--DROP TRIGGER [dbo].[AI_Expense]
--GO

--/****** Object:  Trigger [AU_Expense]    Script Date: 05.06.2020 8:52:33 ******/
--DROP TRIGGER [dbo].[AU_Expense]
--GO

--/****** Object:  Trigger [IofD_Expense]    Script Date: 05.06.2020 8:52:51 ******/
--DROP TRIGGER [dbo].[IofD_Expense]
--GO

--/****** Object:  Trigger [IofU_Expense]    Script Date: 05.06.2020 8:53:10 ******/
--DROP TRIGGER [dbo].[IofU_Expense]
--GO

--/****** Object:  Trigger [IofD_Expense_Spec]    Script Date: 05.06.2020 8:53:23 ******/
--DROP TRIGGER [dbo].[IofD_Expense_Spec]
--GO

--/****** Object:  Trigger [IofI_Expense_Spec]    Script Date: 05.06.2020 8:53:42 ******/
--DROP TRIGGER [dbo].[IofI_Expense_Spec]
--GO

--/****** Object:  Trigger [IofU_Expense_Spec]    Script Date: 05.06.2020 8:53:55 ******/
--DROP TRIGGER [dbo].[IofU_Expense_Spec]
--GO


/*** Служит для задания времени создания расхода ***/

CREATE TRIGGER [dbo].[AI_Expense]
    ON [dbo].[Expense]
    AFTER INSERT
    AS

	SET NOCOUNT ON;

	declare     @id_exp  int

begin

	set @id_exp = (select ID from inserted)

	update Expense
	set 
	Expense.Time_Create = GETDATE()
	where ID = @id_exp 

end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для задания времени проведения расчета ***/

CREATE TRIGGER [dbo].[AU_Expense]
    ON [dbo].[Expense]
    AFTER UPDATE
    AS

	SET NOCOUNT ON;

	declare     @id_exp       int
	declare     @old_Spended  int
	declare     @new_Spended  int

begin

	set @id_exp      = (select ID      from inserted)
	set @new_Spended = (select Spended from inserted)
	set @old_Spended = (select Spended from deleted)

	if (@new_Spended <> @old_Spended) and (@new_Spended  = 1)
		begin
			update Expense
			set 
			Expense.Time_Spend = GETDATE()
			where ID = @id_exp 
		end

	if (@new_Spended <> @old_Spended) and (@new_Spended  = 0)
		begin
			update Expense
			set 
			Expense.Time_Spend = NULL
			where ID = @id_exp 
		end

end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для блокировки удаления проведенного расхода ***/

CREATE TRIGGER [dbo].[IofD_Expense]
    ON [dbo].[Expense]
    instead of delete
    AS

	SET NOCOUNT ON;

	declare     @id_exp  int
	declare     @Spended    bit
	declare     @message  nvarchar(128)

	Declare Delete_cursor Cursor
	  for select ID, Spended 
	    from deleted

begin

    Open Delete_cursor

	FETCH NEXT FROM Delete_cursor INTO
	  @id_exp, @Spended

	WHILE @@FETCH_STATUS = 0
    BEGIN

		if @Spended = 1
		begin
		  set @message = 'Расход с ID = ' + str(@id_exp,16,0) + ' проведен и не может быть удален';
		  ROLLBACK TRAN
		  RAISERROR (@message, 1, 1) 
		end
		else
		  begin

			delete from Expense_Spec
			where Expense_id = @id_exp		

			delete from Expense
			where id = @id_exp

		  end

		FETCH NEXT FROM Delete_cursor INTO
		  @id_exp, @Spended

	END

	CLOSE Delete_cursor;

    DEALLOCATE Delete_cursor;

end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для блокировки изменения проведенного расхода ***/

CREATE TRIGGER [dbo].[IofU_Expense]
    ON [dbo].[Expense]
    instead of update
    AS

	SET NOCOUNT ON;

	declare     @id_exp_old       int
	declare     @Spended_old      bit
	declare     @id_exp_new       int
	declare     @Spended_new      bit
	declare     @Date_new         datetime
	declare     @Client_ID_new    int
	declare     @Total_Sum_new    money
	declare     @Time_Create_new  datetime
	declare     @Time_Spend_new   datetime

	declare     @message      nvarchar(128)

	Declare Update_cursor Cursor
	  for select d.ID, d.Spended, i.ID, i.Spended, i.Date, i.Client_ID, i.Total_Sum, i.Time_Create, i.Time_Spend 
	    from deleted d 
		inner join
		inserted i on (d.ID = i.ID)

begin

	open Update_cursor

	FETCH NEXT FROM Update_cursor INTO
	  @id_exp_old ,@Spended_old, @id_exp_new, @Spended_new, @Date_new,
	  @Client_ID_new, @Total_Sum_new, @Time_Create_new, @Time_Spend_new

	WHILE @@FETCH_STATUS = 0
    BEGIN

		if (@Spended_old = 1) and (@Spended_new = 1)
		  begin
			set @message = 'Расход с ID = ' + str(@id_exp_old,16,0) + ' проведен и не может быть изменен';
			ROLLBACK TRAN
			RAISERROR (@message, 1, 1) 
		  end
		else      
		  begin

			if(Update(ID))
			  begin
				set @message = 'Поле ID изменять нельзя, так как оно автоинкрементируемое';
				ROLLBACK TRAN
				RAISERROR (@message, 2, 1)
			  end

			UPDATE [dbo].[Expense]
				SET  [Date]           = @Date_new
					,[Client_ID]      = @Client_ID_new
					,[Total_Sum]      = @Total_Sum_new
					,[Time_Create]    = @Time_Create_new
					,[Spended]        = @Spended_new
					,[Time_Spend]     = @Time_Spend_new
				WHERE ID = @id_exp_old

		  end

		FETCH NEXT FROM Update_cursor INTO
		  @id_exp_old ,@Spended_old, @id_exp_new, @Spended_new, @Date_new,
		  @Client_ID_new, @Total_Sum_new, @Time_Create_new, @Time_Spend_new

	END

	CLOSE Update_cursor;

    DEALLOCATE Update_cursor;

end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для блокировки удаления документов проведенного расхода ***/

CREATE TRIGGER [dbo].[IofD_Expense_Spec]
    ON [dbo].[Expense_Spec]
    INSTEAD OF Delete
    AS

	SET NOCOUNT ON;

	declare     @id_exp     int
	declare     @id_exp_s   int
	declare     @Spended    bit
	declare     @message    nvarchar(128)

	Declare Delete_cursor_es Cursor
	  for select ID, Expense_ID 
	    from deleted

begin

    Open Delete_cursor_es

	FETCH NEXT FROM Delete_cursor_es INTO
	  @id_exp_s, @id_exp

	WHILE @@FETCH_STATUS = 0
    BEGIN

		set @Spended = (select Spended 
						from Expense
						where ID = @id_exp)

		if @Spended = 1
		  begin

			set @message = 'Расход с ID = ' + str(@id_exp,16,0) + ' на который ссылается удаляемый документ с ID = ' 
						   + str(@id_exp_s,16,0) + ', проведен и не может быть изменен';

			ROLLBACK TRAN
			RAISERROR (@message, 1, 1) 
		  end
		else
		  begin
  		    Delete from Expense_Spec
		    where ID = @id_exp_s

		    Exec dbo.sp_Upd_Total_Sum_Expense @id_exp
		  end

		FETCH NEXT FROM Delete_cursor_es INTO
	      @id_exp_s, @id_exp

	END

	CLOSE Delete_cursor_es;

    DEALLOCATE Delete_cursor_es;

end


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для блокировки добавления документов в проведенный расход ***/

CREATE TRIGGER [dbo].[IofI_Expense_Spec]
    ON [dbo].[Expense_Spec]
    INSTEAD OF INSERT
    AS

	SET NOCOUNT ON;

	declare     @Spended    bit
	declare     @message  nvarchar(128)

	declare     @id_exp     int
	declare     @Product_ID int
	declare     @Count      int
	declare     @Price      money
	declare     @Summa      money


	Declare Insert_cursor_es Cursor
	  for select i.Expense_ID, i.Product_ID, i.Count, i.Price, i.Summa 
	    from inserted i

begin

	set @id_exp    = (select Expense_ID from inserted)

	open Insert_cursor_es

	FETCH NEXT FROM Insert_cursor_es INTO
	  @id_exp, @Product_ID, @Count, @Price, @Summa

	WHILE @@FETCH_STATUS = 0
    BEGIN

		set @Spended = (select Spended 
						from Expense
						where ID = @id_exp)

		if @Spended = 1
		  begin
			set @message = 'Расход с ID = ' + str(@id_exp,16,0) + ' на который ссылается добавляемый документ, проведен и не может быть изменен';
			ROLLBACK TRAN
			RAISERROR (@message, 1, 1) 
		  end
		else
		  begin

			set @Count = ISNULL(@Count, 0)
			set @Price = ISNULL(@Price, 0)

			set @Summa = @Price * @Count

			INSERT INTO [dbo].[Expense_Spec]
				   ([Expense_ID]
				   ,[Product_ID]
				   ,[Count]
				   ,[Price]
				   ,[Summa])
			VALUES(@id_exp, @Product_ID, @Count, @Price, @Summa)

			Exec dbo.sp_Upd_Total_Sum_Expense @id_exp

		  end

		FETCH NEXT FROM Insert_cursor_es INTO
		  @id_exp, @Product_ID, @Count, @Price, @Summa

	END

	CLOSE Insert_cursor_es;

    DEALLOCATE Insert_cursor_es;

end


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*** Служит для блокировки изменения документов проведенного расхода ***/

CREATE TRIGGER [dbo].[IofU_Expense_Spec]
    ON [dbo].[Expense_Spec]
    INSTEAD OF Update
    AS

	SET NOCOUNT ON;

	declare     @Spended_old    bit	
	declare     @Spended_new    bit	
	declare     @message        nvarchar(128)

	declare     @id_exp_s        int
	declare     @id_exp_old      int
	declare     @id_exp_new      int
	declare     @Product_ID_new  int
	declare     @Count_new       int
	declare     @Price_new       money
	declare     @Summa_new       money

	Declare Update_cursor_es Cursor
	  for select d.ID, d.Expense_ID, i.Expense_ID, i.Product_ID, i.Count, i.Price, i.Summa 
	    from deleted d 
		inner join
		inserted i on (d.ID = i.ID)

begin

	open Update_cursor_es

	FETCH NEXT FROM Update_cursor_es INTO
	  @id_exp_s, @id_exp_old, @id_exp_new, @Product_ID_new, @Count_new, @Price_new, @Summa_new

	WHILE @@FETCH_STATUS = 0
    BEGIN

		set @Spended_old = (select Spended 
						from Expense
						where ID = @id_exp_old)

		set @Spended_new = (select Spended 
						from Expense
						where ID = @id_exp_new)

		if (@Spended_old = 1)
		  begin

			set @message = 'Расход с ID = ' + str(@id_exp_old,16,0) + ' с которым связан изменяемый документ с ID = ' 
						   + str(@id_exp_s,16,0) + ', проведен и не может быть изменен';

			ROLLBACK TRAN
			RAISERROR (@message, 1, 1) 
		  end
		else if (@Spended_new = 1)
		  begin

			set @message = 'Расход с ID = ' + str(@id_exp_new,16,0) + ' к которому пытается привязаться изменяемый документ с ID = ' 
						   + str(@id_exp_s,16,0) + ', проведен и не может быть изменен';

			ROLLBACK TRAN
			RAISERROR (@message, 1, 1) 
		  end
		else
		  begin

			if(Update(ID))
				begin
				set @message = 'Поле ID изменять нельзя, так как оно автоинкрементируемое';
				ROLLBACK TRAN
				RAISERROR (@message, 2, 1)
				end

			set @Count_new = ISNULL(@Count_new, 0)
			set @Price_new = ISNULL(@Price_new, 0)

			set @Summa_new = @Price_new * @Count_new

			UPDATE [dbo].[Expense_Spec]
			   SET [Expense_ID] = @id_exp_new,
				   [Product_ID] =  @Product_ID_new,   
				   [Count] = @Count_new,
				   [Price] = @Price_new,
				   [Summa] = @Summa_new
			 WHERE ID = @id_exp_s

			 Exec dbo.sp_Upd_Total_Sum_Expense @id_exp_old

			 Exec dbo.sp_Upd_Total_Sum_Expense @id_exp_new

		  end

		FETCH NEXT FROM Update_cursor_es INTO
		  @id_exp_s, @id_exp_old, @id_exp_new, @Product_ID_new, @Count_new, @Price_new, @Summa_new

	END

	CLOSE Update_cursor_es;

    DEALLOCATE Update_cursor_es;

end
GO

