if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Keywords_Files]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Keywords] DROP CONSTRAINT FK_Keywords_Files
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Files_Peers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Files] DROP CONSTRAINT FK_Files_Peers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Keywords_Peers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Keywords] DROP CONSTRAINT FK_Keywords_Peers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddFile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddFile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddKeyword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddKeyword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddPeer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddPeer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteAll]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteFiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteFiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeletePeerAndFiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeletePeerAndFiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RefreshPeer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[RefreshPeer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Files]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Files]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Keywords]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Keywords]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Peers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Peers]
GO

CREATE TABLE [dbo].[Files] (
	[ID] [uniqueidentifier] NOT NULL ,
	[PeerID] [uniqueidentifier] NOT NULL ,
	[FileName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileCreated] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Keywords] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[FileID] [uniqueidentifier] NOT NULL ,
	[PeerID] [uniqueidentifier] NOT NULL ,
	[Keyword] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Peers] (
	[ID] [uniqueidentifier] NOT NULL ,
	[IP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Port] [smallint] NULL ,
	[LastUpdate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure AddFile
(
    @ID		uniqueidentifier,
    @PeerID	uniqueidentifier,
    @FileName	nvarchar(50),
    @FileCreated	datetime
)
AS

INSERT INTO Files
(
    [ID], PeerID, [FileName], FileCreated
)

VALUES
(
    @ID, @PeerID, @FileName, @FileCreated
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure AddKeyword
(
    @FileID	uniqueidentifier,
    @PeerID	uniqueidentifier,
    @Keyword	nvarchar(50)
)
AS

INSERT INTO Keywords
(
    FileID, PeerID, Keyword
)

VALUES
(
    @FileID, @PeerID, @Keyword
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure AddPeer
(
    @ID 	  uniqueidentifier,
    @IP 	  nvarchar(15),
    @Port smallint
)
AS

INSERT INTO Peers
(
    [ID], IP, Port, LastUpdate
)

VALUES
(
    @ID, @IP, @Port, GETDATE()
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure DeleteAll

AS

DELETE FROM Keywords
DELETE FROM Files
DELETE FROM Peers
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure DeleteFiles
(
    @ID		uniqueidentifier
)
AS

DELETE FROM Files WHERE PeerID = @ID
DELETE FROM Keywords WHERE PeerID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure DeletePeerAndFiles
(
    @ID		uniqueidentifier
)
AS

DELETE FROM Files WHERE PeerID = @ID
DELETE FROM Peers WHERE [ID] = @ID
DELETE FROM Keywords WHERE PeerID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure RefreshPeer
(
    @ID 	  uniqueidentifier
)
AS

UPDATE Peers SET LastUpdate=GETDATE() WHERE [ID]=@ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

