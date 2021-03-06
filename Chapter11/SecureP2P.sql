if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Sessions_Peers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Sessions] DROP CONSTRAINT FK_Sessions_Peers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddPeer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddPeer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CreateSession]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CreateSession]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteSession]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteSession]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPeerAndSessionInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPeerAndSessionInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPeers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPeers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RefreshSession]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[RefreshSession]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Peers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Peers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sessions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sessions]
GO

CREATE TABLE [dbo].[Peers] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[EmailAddress] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[PublicKeyXML] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Sessions] (
	[ID] [uniqueidentifier] NOT NULL ,
	[LastUpdate] [datetime] NOT NULL ,
	[ObjRef] [varbinary] (1500) NOT NULL ,
	[PeerID] [int] NOT NULL 
) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure AddPeer
(
    @PublicKeyXml nvarchar(300),
    @EmailAddress nvarchar(50)
)
AS

INSERT INTO Peers
(
    PublicKeyXml, EmailAddress
)

VALUES
(
    @PublicKeyXml, @EmailAddress
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

CREATE Procedure CreateSession
(
    @ID uniqueidentifier,
    @EmailAddress nvarchar(50),
    @ObjRef varbinary(1500)
)
AS

DECLARE @PeerID int
SELECT @PeerID = ID FROM Peers WHERE EmailAddress = @EmailAddress

DELETE FROM Sessions WHERE PeerID=@PeerID

INSERT INTO Sessions
(
    ID, PeerID, LastUpdate, ObjRef
)

VALUES
(
    @ID, @PeerID, GETDATE(), @ObjRef
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

CREATE Procedure DeleteSession
(
    @ID		uniqueidentifier
)
AS

DELETE FROM Sessions WHERE ID = @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE GetPeerAndSessionInfo 
(
@EmailAddress nvarchar(50)
)
AS

SELECT TOP 1 * FROM Peers Left JOIN Sessions ON PeerID = Peers.ID Where EmailAddress = @EmailAddress ORDER BY LastUpdate DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE GetPeers

AS

SELECT EmailAddress FROM Sessions INNER JOIN Peers ON Peers.ID = PeerID WHERE DATEDIFF(MINUTE, LastUpdate, GETDATE()) < 3
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure RefreshSession
(
    @ID 	  uniqueidentifier
)
AS

UPDATE Sessions SET LastUpdate=GETDATE() WHERE [ID]=@ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

