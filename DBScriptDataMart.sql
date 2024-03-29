/****** Object:  Database [DataMart]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE DATABASE [DataMart]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 20 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [DataMart] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [DataMart] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataMart] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataMart] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataMart] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataMart] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataMart] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataMart] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataMart] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataMart] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataMart] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataMart] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataMart] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataMart] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataMart] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [DataMart] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataMart] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [DataMart] SET  MULTI_USER 
GO
ALTER DATABASE [DataMart] SET ENCRYPTION ON
GO
ALTER DATABASE [DataMart] SET QUERY_STORE = ON
GO
ALTER DATABASE [DataMart] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Schema [dw]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE SCHEMA [dw]
GO
/****** Object:  Schema [tempstage]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE SCHEMA [tempstage]
GO
/****** Object:  Table [dw].[Brand]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[Brand](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dw].[FuelPrice]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[FuelPrice](
	[FuelPriceID] [int] IDENTITY(1,1) NOT NULL,
	[BrandID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
	[DateCreated] [numeric](18, 0) NOT NULL,
	[DateModified] [numeric](18, 0) NULL,
 CONSTRAINT [PK_FuelP] PRIMARY KEY NONCLUSTERED 
(
	[SiteID] ASC,
	[BrandID] ASC,
	[DateCreated] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_FuelPrice_FuelPriceID]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE CLUSTERED INDEX [IDX_FuelPrice_FuelPriceID] ON [dw].[FuelPrice]
(
	[FuelPriceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dw].[Site]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[Site](
	[SiteID] [int] IDENTITY(1,1) NOT NULL,
	[TradingName] [varchar](100) NULL,
	[Location] [varchar](100) NULL,
	[Address] [varchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[Latitude] [decimal](18, 6) NULL,
	[Longitude] [decimal](18, 6) NULL,
	[FullAddress]  AS (([Address]+'')+[Location]),
PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dw].[SiteFeatures]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dw].[SiteFeatures](
	[SiteFeatureID] [int] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[Site-Features] [varchar](400) NULL,
PRIMARY KEY CLUSTERED 
(
	[SiteFeatureID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [tempstage].[FuelPrices]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tempstage].[FuelPrices](
	[brand] [varchar](50) NULL,
	[date] [varchar](20) NULL,
	[price] [decimal](18, 2) NULL,
	[tradingName] [varchar](100) NULL,
	[location] [varchar](100) NULL,
	[address] [varchar](100) NULL,
	[phone] [varchar](50) NULL,
	[latitude] [decimal](18, 6) NULL,
	[Longitude] [decimal](18, 6) NULL,
	[SiteFeatures] [varchar](400) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_FuelPrice_BrandID]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE NONCLUSTERED INDEX [IDX_FuelPrice_BrandID] ON [dw].[FuelPrice]
(
	[BrandID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_FuelPrice_SiteID]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE NONCLUSTERED INDEX [IDX_FuelPrice_SiteID] ON [dw].[FuelPrice]
(
	[SiteID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_SiteFeature_SiteID]    Script Date: 3/26/2022 3:49:50 PM ******/
CREATE NONCLUSTERED INDEX [IDX_SiteFeature_SiteID] ON [dw].[SiteFeatures]
(
	[SiteID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dw].[FuelPrice]  WITH CHECK ADD FOREIGN KEY([BrandID])
REFERENCES [dw].[Brand] ([BrandID])
GO
ALTER TABLE [dw].[FuelPrice]  WITH CHECK ADD FOREIGN KEY([SiteID])
REFERENCES [dw].[Site] ([SiteID])
GO
ALTER TABLE [dw].[SiteFeatures]  WITH CHECK ADD FOREIGN KEY([SiteID])
REFERENCES [dw].[Site] ([SiteID])
GO
/****** Object:  StoredProcedure [dw].[etl_Fuelprice_attribute_insert]    Script Date: 3/26/2022 3:49:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dw].[etl_Fuelprice_attribute_insert]

AS

/* **********************************************************************************************
   Author : Vikram Singh
   creation date: 25-03-2022
   Desc:
   Source Table: [tempstage].[FuelPrices]
   
   Destination table: 
   1) dw.brand 
   2) dw.site
   3) dw.sitefeatures
   4) dw.fuelprice

   **********************************************************************************************
   sample
   ========
   exec [dw].[etl_Fuelprice_attribute_insert]

*/
BEGIN

/* **********************************************************************************************
TABLE NAME : dw.Brand
MERGE STATEMENT
 **********************************************************************************************
*/
 
MERGE [dw].[Brand] AS TARGET
USING
	(
	SELECT 
	DISTINCT BRAND 
	FROM [tempstage].[FuelPrices]
	) AS SOURCE

 ON SOURCE.BRAND=TARGET.BrandName

 WHEN MATCHED THEN
  
   UPDATE SET TARGET.BrandName=SOURCE.BRAND

 WHEN NOT MATCHED  THEN 

	INSERT([BrandName])

	VALUES(SOURCE.BRAND);
 
 
/* **********************************************************************************************
TABLE NAME : dw.Site
MERGE STATEMENT
 **********************************************************************************************
*/
 
MERGE [dw].[Site] AS TARGET
USING
	(
	SELECT 
		   [tradingName]
		  ,[location]
		  ,[address]
		  ,[phone]
		  ,[latitude]
		  ,[Longitude]
 
	FROM [tempstage].[FuelPrices]
	) AS SOURCE


	ON SOURCE.[tradingName]=TARGET.[tradingName]
	AND SOURCE.[location]  =TARGET.[location]
	AND SOURCE.[address]   =TARGET.[address]
	AND SOURCE.[latitude]  =TARGET.[latitude]
	AND SOURCE.[Longitude] =TARGET.[Longitude]
 
WHEN MATCHED THEN

	UPDATE SET TARGET.[tradingName]=SOURCE.[tradingName],
			   TARGET.[location]   =SOURCE.[location],
			   TARGET.[address]    =SOURCE.[address],
			   TARGET.[phone]      =SOURCE.[phone],
			   TARGET.[latitude]   =SOURCE.[latitude],
			   TARGET.[Longitude]  =SOURCE.[Longitude]

WHEN NOT MATCHED  THEN 

	INSERT([tradingName]
		  ,[location]
		  ,[address]
		  ,[phone]
		  ,[latitude]
		  ,[Longitude])

	VALUES(SOURCE.[tradingName]
		  ,SOURCE.[location]
		  ,SOURCE.[address]
		  ,SOURCE.[phone]
		  ,SOURCE.[latitude]
		  ,SOURCE.[Longitude]);


/* **********************************************************************************************
TABLE NAME : dw.SiteFeatures
MERGE STATEMENT
 **********************************************************************************************
*/
  

MERGE [dw].[SiteFeatures] AS TARGET
USING
	(
		SELECT  
		ST.SiteID,
	    PAR.[SiteFeatures]
	
		fROM [tempstage].[FuelPrices] PAR
		INNER JOIN dw.[Site] ST ON ST.TradingName= PAR.tradingname
			AND ST.[location] =PAR.[location]
			AND ST.[address]  =PAR.[address]
			AND ST.[latitude] =PAR.[latitude]
			AND ST.[Longitude]=PAR.[Longitude]
 
	) AS SOURCE

  ON SOURCE.SiteID=TARGET.SiteID
 
 WHEN MATCHED THEN

	UPDATE SET TARGET.[Site-Features]=SOURCE.[SiteFeatures]
          
  WHEN NOT MATCHED  THEN 

	INSERT(SiteID,
	       [Site-Features]
	       )

	VALUES(SOURCE.SiteID
		  ,SOURCE.[SiteFeatures]
		  );
 
 
/* **********************************************************************************************
TABLE NAME : dw.[FuelPrice]
MERGE STATEMENT 
 **********************************************************************************************
*/
 

MERGE [dw].[FuelPrice] AS TARGET
USING
(
	SELECT 
	BR.BrandID,
	ST.[SiteID],
	PAR.Price, 
	REPLACE(PAR.[date], '-', '') AS [date]

	FROM [tempstage].[FuelPrices] PAR
	INNER JOIN dw.Brand BR ON BR.BrandName=PAR.brand
	INNER JOIN dw.[Site] ST ON ST.TradingName= PAR.tradingname
		AND ST.[location] =PAR.[location]
		AND ST.[address]  =PAR.[address]
		AND ST.[latitude] =PAR.[latitude]
		AND ST.[Longitude]=PAR.[Longitude]

) AS SOURCE


	ON SOURCE.SiteID  =TARGET.SiteID
	AND SOURCE.brandid=TARGET.brandid
	AND SOURCE.[date]   =TARGET.datecreated
  
WHEN MATCHED THEN

	UPDATE SET TARGET.Price       =SOURCE.Price,
			   TARGET.datemodified=REPLACE(getdate(), '-', '')  

WHEN NOT MATCHED  THEN 

	INSERT([BrandID]
			   ,[SiteID]
			   ,[Price]
			   ,datecreated
			   ,datemodified
			 
	)

	VALUES(SOURCE.[BrandID]
		  ,SOURCE.[SiteID]
		  ,SOURCE.[Price]
		  ,REPLACE(SOURCE.[date], '-', '') 
		  ,REPLACE(SOURCE.[date], '-', '') 
		  );

END

GO
ALTER DATABASE [DataMart] SET  READ_WRITE 
GO
