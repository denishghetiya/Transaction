USE [master]
GO
/****** Object:  Database [Transaction]    Script Date: 05-10-2026 16:09:13 ******/
CREATE DATABASE [Transaction]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Transaction', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER1\MSSQL\DATA\Transaction.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Transaction_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER1\MSSQL\DATA\Transaction_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Transaction] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Transaction].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Transaction] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Transaction] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Transaction] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Transaction] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Transaction] SET ARITHABORT OFF 
GO
ALTER DATABASE [Transaction] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Transaction] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Transaction] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Transaction] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Transaction] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Transaction] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Transaction] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Transaction] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Transaction] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Transaction] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Transaction] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Transaction] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Transaction] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Transaction] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Transaction] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Transaction] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Transaction] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Transaction] SET RECOVERY FULL 
GO
ALTER DATABASE [Transaction] SET  MULTI_USER 
GO
ALTER DATABASE [Transaction] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Transaction] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Transaction] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Transaction] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Transaction] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Transaction] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Transaction', N'ON'
GO
ALTER DATABASE [Transaction] SET QUERY_STORE = ON
GO
ALTER DATABASE [Transaction] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Transaction]
GO
/****** Object:  Table [dbo].[CurrencyTypes]    Script Date: 05-10-2026 16:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyTypes](
	[CurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyCode] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 05-10-2026 16:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CurrencyID] [int] NOT NULL,
	[Balance] [decimal](18, 9) NOT NULL,
	[TransferAmount] [decimal](18, 9) NOT NULL,
	[TransactionType] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05-10-2026 16:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wallets]    Script Date: 05-10-2026 16:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallets](
	[WalletID] [int] IDENTITY(1,1) NOT NULL,
	[WalletCode] [uniqueidentifier] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurrencyID] [int] NOT NULL,
	[Balance] [decimal](18, 9) NOT NULL,
 CONSTRAINT [PK_Wallets] PRIMARY KEY CLUSTERED 
(
	[WalletID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CurrencyTypes] ON 
GO
INSERT [dbo].[CurrencyTypes] ([CurrencyID], [CurrencyCode]) VALUES (1, N'INR')
GO
INSERT [dbo].[CurrencyTypes] ([CurrencyID], [CurrencyCode]) VALUES (2, N'USD')
GO
SET IDENTITY_INSERT [dbo].[CurrencyTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Transactions] ON 
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (1, 1, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(1000.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (2, 1, 2, CAST(2000.000000000 AS Decimal(18, 9)), CAST(2000.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (3, 2, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(1000.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (4, 2, 2, CAST(2000.000000000 AS Decimal(18, 9)), CAST(2000.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (5, 2, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Debit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (6, 2, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (7, 2, 1, CAST(900.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Debit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (8, 1, 1, CAST(1100.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Credit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (9, 1, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Debit')
GO
INSERT [dbo].[Transactions] ([TransactionID], [UserID], [CurrencyID], [Balance], [TransferAmount], [TransactionType]) VALUES (10, 2, 1, CAST(1000.000000000 AS Decimal(18, 9)), CAST(100.000000000 AS Decimal(18, 9)), N'Credit')
GO
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [Username], [Email], [Password]) VALUES (1, N'user1', N'user1@gmail.com', N'user1')
GO
INSERT [dbo].[Users] ([UserID], [Username], [Email], [Password]) VALUES (2, N'user2', N'user2@gmail.com', N'user2')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Wallets] ON 
GO
INSERT [dbo].[Wallets] ([WalletID], [WalletCode], [UserID], [CurrencyID], [Balance]) VALUES (1, N'16031ad5-7b68-426c-aa9d-96aa1a15a3d3', 1, 1, CAST(1000.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[Wallets] ([WalletID], [WalletCode], [UserID], [CurrencyID], [Balance]) VALUES (2, N'1207b9ed-b163-4ae2-97a3-504ee630f6f5', 1, 2, CAST(2000.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[Wallets] ([WalletID], [WalletCode], [UserID], [CurrencyID], [Balance]) VALUES (3, N'f937c32c-28c0-451e-9dcd-f054043fcfb6', 2, 1, CAST(1000.000000000 AS Decimal(18, 9)))
GO
INSERT [dbo].[Wallets] ([WalletID], [WalletCode], [UserID], [CurrencyID], [Balance]) VALUES (4, N'7ed69184-e746-4d13-96de-b5511ce215f6', 2, 2, CAST(2000.000000000 AS Decimal(18, 9)))
GO
SET IDENTITY_INSERT [dbo].[Wallets] OFF
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transaction_Balance]  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transaction_TransferAmount]  DEFAULT ((0)) FOR [TransferAmount]
GO
ALTER TABLE [dbo].[Wallets] ADD  CONSTRAINT [DF_Wallets_WalletCode]  DEFAULT (newid()) FOR [WalletCode]
GO
ALTER TABLE [dbo].[Wallets] ADD  CONSTRAINT [DF_Wallets_Balance]  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_CurrencyID_CurrencyTypes_CurrencyID] FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[CurrencyTypes] ([CurrencyID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_CurrencyID_CurrencyTypes_CurrencyID]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_UserID_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_UserID_Users_UserID]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_CurrencyID_CurrencyTypes_CurrencyID] FOREIGN KEY([CurrencyID])
REFERENCES [dbo].[CurrencyTypes] ([CurrencyID])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_CurrencyID_CurrencyTypes_CurrencyID]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_UserID_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_UserID_Users_UserID]
GO
USE [master]
GO
ALTER DATABASE [Transaction] SET  READ_WRITE 
GO
