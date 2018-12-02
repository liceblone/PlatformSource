use salesUserData
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[T506]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[T506]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[T516]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[T516]
GO
 
--sp_help T506

CREATE TABLE [dbo].[T506] (
	[F01] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL default newid(),
	[F02] [varchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[F03] [char] (1)  COLLATE Chinese_PRC_CI_AS NULL  default 0 ,
	[F04] [varchar] (500) COLLATE Chinese_PRC_CI_AS NULL ,
	[F05] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F06] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F07] [int]   NULL default 10 ,
	[F08] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL default 'ËÎÌו',
	[F09] [bit] NULL default 1 ,
	[F10] [bit] NULL ,
	[F11] [bit] NULL ,
	[F12] [int] NULL ,
	[F13] [int] NULL ,
	[F14] [int] NULL ,
	[F15] [int] NULL ,
	[F16] [int] NULL ,
	[F17] [int] NULL ,
	[F18] [bit] NULL default 1 ,
	[F19] [int] NULL ,
	[F200] [datetime] NULL default  getdate()  ,
	[F20] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[F21] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[F22] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[FLeftMargin] [int] NULL default 5,
	[FRightMargin] [int] NULL default 5,
	[FTopMargin] [int] NULL default 5,
	[FBtmMargin] [int] NULL default 5,
	[FRptWidth] [int] NULL default 290,
	[FRptHeight] [int] NULL default 210,
	[FHasVline] [bit] NULL default 1,
	[FIsPortrait] [bit] NULL default 1,
	[FTitleFontName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL default  'ËÎÌו' ,
	[FTitleFontSize] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL default  18,
	[FHasPageNumber] [bit] NULL default 1 ,
	[FHasPrintTime] [bit] NULL default 1,
	[FFreezeBtmPnlPosition] [bit] NULL default 0 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[T516] (
	[F01] [int] IDENTITY (1, 1) NOT NULL ,
	[F02] [varchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,
	[F03] [int] NULL ,
	[F04] [int] NULL ,
	[F05] [bit] NULL ,
	[F06] [bit] NULL ,
	[F07] [bit] NULL ,
	[F08] [bit] NULL ,
	[F09] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F10] [bit] NULL ,
	[F11] [varchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,
	[F12] [int] NULL ,
	[F13] [char] (1) COLLATE Chinese_PRC_CI_AS NULL ,
	[F14] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F15] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F16] [char] (1) COLLATE Chinese_PRC_CI_AS NULL ,
	[F17] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F18] [int] NULL ,
	[F19] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F20] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F21] [int] NULL ,
	[F22] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[F23] [int] NULL ,
	[F24] [int] NULL ,
	[F200] [datetime] NULL ,
	[F27] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[F28] [int] NULL ,
	[F29] [int] NULL 
) ON [PRIMARY]
GO 



if   exists(select * from salesSys.dbo.sysobjects where name ='T506')
begin
 
   insert into  T506
   select *  from salesSys.dbo.T506
 
   drop table salesSys.dbo.T506
end
 
go

if   exists( select * from salesSys.dbo.sysobjects where name ='T516' )
begin
 set IDENTITY_INSERT dbo.T516 on

   insert   into  dbo.T516 
   (F01,F02,F03,F04,F05,F06,F07,F08,F09,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F200,F27,F28,F29)
   select F01,F02,F03,F04,F05,F06,F07,F08,F09,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F200,F27,F28,F29 from salesSys.dbo.T516

 set IDENTITY_INSERT dbo.T516 off

    drop table salesSys.dbo.T516
end
 