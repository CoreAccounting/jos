USE [master]
GO
/****** Object:  Database [dsfsdfsdfds]    Script Date: 11/25/2019 9:55:51 PM ******/
CREATE DATABASE [dsfsdfsdfds]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TemplateProject', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dsfsdfsdfds.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TemplateProject_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dsfsdfsdfds_log.ldf' , SIZE = 3136KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dsfsdfsdfds] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dsfsdfsdfds].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dsfsdfsdfds] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET ARITHABORT OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dsfsdfsdfds] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dsfsdfsdfds] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dsfsdfsdfds] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dsfsdfsdfds] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET RECOVERY FULL 
GO
ALTER DATABASE [dsfsdfsdfds] SET  MULTI_USER 
GO
ALTER DATABASE [dsfsdfsdfds] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dsfsdfsdfds] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dsfsdfsdfds] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dsfsdfsdfds] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dsfsdfsdfds] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dsfsdfsdfds', N'ON'
GO
ALTER DATABASE [dsfsdfsdfds] SET QUERY_STORE = OFF
GO
USE [dsfsdfsdfds]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnSplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END
GO
/****** Object:  Table [dbo].[MGroupUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MGroupUser](
	[GroupUserID] [int] IDENTITY(1,1) NOT NULL,
	[GroupUserName] [varchar](50) NOT NULL,
	[IsSuperAdmin] [bit] NOT NULL,
	[GroupCode] [varchar](5) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserCreated] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_MGroupUser] PRIMARY KEY CLUSTERED 
(
	[GroupUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MGroupUserMenu]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MGroupUserMenu](
	[GroupUserMenuID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[MenuID] [int] NOT NULL,
	[AllowCreate] [bit] NOT NULL,
	[AllowRead] [bit] NOT NULL,
	[AllowUpdate] [bit] NOT NULL,
	[AllowDelete] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserCreated] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_MGroupUserMenu] PRIMARY KEY CLUSTERED 
(
	[GroupUserMenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MMenu]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MMenu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[ParentMenuID] [int] NULL,
	[MenuName] [varchar](50) NOT NULL,
	[Modul] [varchar](50) NOT NULL,
	[IconFA] [varchar](50) NULL,
	[IsMenu] [bit] NOT NULL,
	[PageUrl] [varchar](150) NULL,
	[IsDeleted] [bit] NOT NULL,
	[OrderPage] [int] NULL,
	[UserCreated] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_MMenu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[OfficialName] [varchar](255) NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](255) NULL,
	[Nik] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserCreated] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_MUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MUserGroup]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MUserGroup](
	[UserGroupID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[GroupUserID] [int] NOT NULL,
	[UserCreated] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[UserModified] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_MUserGroup] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MGroupUser] ADD  CONSTRAINT [DF_MGroupUser_IsSuperAdmin]  DEFAULT ((0)) FOR [IsSuperAdmin]
GO
ALTER TABLE [dbo].[MGroupUser] ADD  CONSTRAINT [DF_MGroupUser_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MGroupUserMenu] ADD  CONSTRAINT [DF_MGroupUserMenu_AllowCreate]  DEFAULT ((0)) FOR [AllowCreate]
GO
ALTER TABLE [dbo].[MGroupUserMenu] ADD  CONSTRAINT [DF_MGroupUserMenu_AllowRead]  DEFAULT ((0)) FOR [AllowRead]
GO
ALTER TABLE [dbo].[MGroupUserMenu] ADD  CONSTRAINT [DF_MGroupUserMenu_AllowUpdate]  DEFAULT ((0)) FOR [AllowUpdate]
GO
ALTER TABLE [dbo].[MGroupUserMenu] ADD  CONSTRAINT [DF_MGroupUserMenu_AllowDelete]  DEFAULT ((0)) FOR [AllowDelete]
GO
ALTER TABLE [dbo].[MGroupUserMenu] ADD  CONSTRAINT [DF_MGroupUserMenu_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MMenu] ADD  CONSTRAINT [DF_MMenu_IsMenu]  DEFAULT ((0)) FOR [IsMenu]
GO
ALTER TABLE [dbo].[MMenu] ADD  CONSTRAINT [DF_MMenu_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[sp_CUD_MGroupUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CUD_MGroupUser]
	@GroupUserID int = 0,
	@GroupCode varchar(50) = null,
	@GroupUserName as varchar(255) = null,
	@IsSuperadmin as bit = null,
	@UserCreated varchar(50) = null,
	@UserModified varchar(50) = null,
	@Mode varchar(1),
	@id_out int output
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
		declare @err_validation varchar(max) = ''
		
		IF @Mode = 'c'
		BEGIN
			if exists(select 1 from MGroupUser where GroupUserName = @GroupUserName and IsDeleted = 0)
			begin
				set @err_validation = 'Name ' + @GroupUserName + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			if exists(select 1 from MGroupUser where GroupCode = @GroupCode and IsDeleted = 0)
			begin
				set @err_validation = 'Group Code ' + @GroupCode + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			INSERT INTO [dbo].[MGroupUser]
				   ([GroupUserName]
				   ,[GroupCode]
				   ,[IsSuperAdmin]
				   ,[IsDeleted]
				   ,[UserCreated]
				   ,[DateCreated])
			 VALUES
				   (@GroupUserName
				   ,@GroupCode
				   , @IsSuperadmin
				   , 0
				   , @UserCreated
				   , GETDATE())

			set @id_out = SCOPE_IDENTITY() 
		END
		ELSE if @Mode = 'u'
		BEGIN
			if not exists(select 1 from MGroupUser where GroupUserID = @GroupUserID and IsSuperAdmin = 0)
			begin
				set @err_validation = 'Data not found!'
				RAISERROR(@err_validation, 16, 1)
			end

			if exists(select 1 from MGroupUser where GroupUserName = @GroupUserName and IsDeleted = 0 and GroupUserID <> @GroupUserID)
			begin
				set @err_validation = 'Name ' + @GroupUserName + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			if exists(select 1 from MGroupUser where GroupCode = @GroupCode and IsDeleted = 0 and GroupUserID <> @GroupUserID)
			begin
				set @err_validation = 'Group Code ' + @GroupCode + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			UPDATE [dbo].[MGroupUser]
			SET [GroupUserName] = @GroupUserName
				,[UserModified] = @UserModified
				,[DateModified] = GETDATE()
				,[GroupCode] = @GroupCode
				,[IsSuperAdmin] = @IsSuperadmin
			WHERE GroupUserID = @GroupUserID
		END
		ELSE IF @Mode = 'd'
		BEGIN
			if not exists(select 1 from MGroupUser where GroupUserID = @GroupUserID)
			begin
				set @err_validation = 'Data not found!'
				RAISERROR(@err_validation, 16, 1)
			end

			UPDATE MGroupUser
			SET 
				[IsDeleted] = 1
				,[UserModified] = @UserModified
				,[DateModified] = GETDATE()
			 WHERE GroupUserID = @GroupUserID

			 delete from MUserGroup where GroupUserID = @GroupUserID
			 delete from MGroupUserMenu where GroupID = @GroupUserID

			 set @id_out = @GroupUserID
		END
		ELSE
		BEGIN
			RAISERROR('Mode not defined', 16, 1)
		END
		
		select cast(1 as bit) issuccess, '' msg, '' err_msg
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET NOCOUNT OFF;
		select cast(0 as bit) issuccess, '' msg, ERROR_MESSAGE() err_msg
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CUD_MGroupUserMenu]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CUD_MGroupUserMenu]
	@GroupUserMenuID int = 0,
	@GroupID int = null,
	@MenuID int = null,
	@AllowCreate bit = 0,
	@AllowRead bit = 0,
    @AllowUpdate bit = 0,
    @AllowDelete bit = 0,
	@IsDeleted as bit = null,
	@UserCreated varchar(50) = null,
	@DateCreated varchar(100) = null,
	@UserModified varchar(50) = null,
	@DateModified varchar(100) = null,
	@Mode varchar(1),
	@id_out int output
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
		declare @err_validation varchar(max) = ''
		
		IF @Mode = 'c'
		BEGIN
			if exists(select 1 from MGroupUserMenu where GroupID = @GroupID and MenuID = @MenuID and IsDeleted = 0)
			begin
				set @err_validation = 'Group and Menu already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			INSERT INTO [dbo].[MGroupUserMenu]
				([GroupID]
				,[MenuID]
				,[AllowCreate]
				,[AllowRead]
				,[AllowUpdate]
				,[AllowDelete]
				,[IsDeleted]
				,[UserCreated]
				,[DateCreated])
			 VALUES
				(@GroupID,
				@MenuID,
				@AllowCreate,
				@AllowRead,
				@AllowUpdate,
				@AllowDelete,
				0,
				@UserCreated,
				GETDATE())

			set @id_out = SCOPE_IDENTITY() 
		END
		ELSE if @Mode = 'u'
		BEGIN
			if exists(select 1 from MGroupUserMenu where GroupID = @GroupID and MenuID = @MenuID and IsDeleted = 0 and GroupUserMenuID <> @GroupUserMenuID)
			begin
				set @err_validation = 'Group and Menu already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			UPDATE [dbo].[MGroupUserMenu]
			SET [GroupID] = @GroupID
				,[MenuID] = @MenuID
				,[AllowCreate] = @AllowCreate
				,[AllowRead] = @AllowRead
				,[AllowUpdate] = @AllowUpdate
				,[AllowDelete] = @AllowDelete
				,[UserModified] = @UserModified
				,[DateModified] = GETDATE()
			WHERE 
				GroupUserMenuID = @GroupUserMenuID
			set @id_out = @GroupUserMenuID
		END
		ELSE IF @Mode = 'd'
		BEGIN
			if not exists(select 1 from MGroupUserMenu where IsDeleted = 0 and GroupUserMenuID = @GroupUserMenuID)
			begin
				set @err_validation = 'Data not found!'
				RAISERROR(@err_validation, 16, 1)
			end

			--UPDATE [dbo].[MGroupUserMenu]
			--SET 
			--	[IsDeleted] = 1
			--	,[UserModified] = @UserModified
			--	,[DateModified] = GETDATE()
			-- WHERE GroupUserMenuID = @GroupUserMenuID
			delete [dbo].[MGroupUserMenu]
			 WHERE GroupUserMenuID = @GroupUserMenuID
			 set @id_out = @GroupUserMenuID
		END
		ELSE
		BEGIN
			RAISERROR('Mode not defined', 16, 1)
		END
		
		select cast(1 as bit) issuccess, '' msg, '' err_msg
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET NOCOUNT OFF;
		select cast(0 as bit) issuccess, '' msg, ERROR_MESSAGE() err_msg
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CUD_MUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CUD_MUser]
	@UserID int = 0,
	@OfficialName as varchar(255),
	@UserName as varchar(50),
	@Password as varchar(255) = null,
	@Nik as varchar(15),
	@Email as varchar(50),
	@IsDeleted as bit = null,
	@UserCreated varchar(50) = null,
	@DateCreated varchar(100) = null,
	@UserModified varchar(50) = null,
	@DateModified varchar(100) = null,
	@GroupUserID varchar(100) = null,
	@Mode varchar(1),
	@id_out int output
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
		declare @err_validation varchar(max) = ''
		
		IF @Mode = 'c'
		BEGIN
			if exists(select 1 from MUser where Nik = @Nik and IsDeleted = 0)
			begin
				set @err_validation = 'Nik ' + @Nik + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end
		
			if exists(select 1 from MUser where Email = @Email and IsDeleted = 0)
			begin
				set @err_validation = 'Email ' + @Email + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end
		
			if exists(select 1 from MUser where UserName = @UserName and IsDeleted = 0)
			begin
				set @err_validation = 'Username ' + @UserName + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			if @GroupUserID = '' or @GroupUserID is null
			begin
				set @err_validation = 'Group user wajib diisi!'
				RAISERROR(@err_validation, 16, 1)
			end

			INSERT INTO [dbo].[MUser]
				([OfficialName]
				,[UserName]
				,[Password]
				,[Nik]
				,[Email]
				,[IsDeleted]
				,[UserCreated]
				,[DateCreated])
			 VALUES
				(@OfficialName
				,@UserName
				,@Password
				,@Nik
				,@Email
				,0
				,@UserCreated
				,GETDATE())

			set @id_out = SCOPE_IDENTITY() 

			delete from MUserGroup where UserID = @id_out
			
			INSERT INTO [dbo].[MUserGroup]
				([UserID]
				,[GroupUserID]
				,[UserCreated]
				,[DateCreated])
			select 
			@id_out, splitdata, @UserCreated, GETDATE()
			from dbo.fnSplitString(@GroupUserID, ',')
		END
		ELSE if @Mode = 'u'
		BEGIN
			if exists(select 1 from MUser where Nik = @Nik AND UserID <> @UserID and IsDeleted = 0)
			begin
				set @err_validation = 'Nik ' + @Nik + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end
		
			if exists(select 1 from MUser where Email = @Email AND UserID <> @UserID and IsDeleted = 0)
			begin
				set @err_validation = 'Email ' + @Email + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end
		
			if exists(select 1 from MUser where UserName = @UserName AND UserID <> @UserID and IsDeleted = 0)
			begin
				set @err_validation = 'Username ' + @UserName + ' already exists!'
				RAISERROR(@err_validation, 16, 1)
			end

			if @GroupUserID = '' or @GroupUserID is null
			begin
				set @err_validation = 'Group user wajib diisi!'
				RAISERROR(@err_validation, 16, 1)
			end

			UPDATE [dbo].[MUser]
			SET 
				[OfficialName] = @OfficialName
				,[Nik] = @Nik
				,[Email] = @Email
				,[IsDeleted] = 0
				,[UserModified] = @UserModified
				,[DateModified] = GETDATE()
			WHERE UserID = @UserID

			delete from MUserGroup where UserID = @UserID
			
			INSERT INTO [dbo].[MUserGroup]
				([UserID]
				,[GroupUserID]
				,[UserCreated]
				,[DateCreated])
			select 
			@UserID, splitdata, @UserCreated, GETDATE()
			from dbo.fnSplitString(@GroupUserID, ',')
		END
		ELSE IF @Mode = 'd'
		BEGIN
			if not exists(select 1 from MUser where UserID = @UserID)
			begin
				set @err_validation = 'Data not found!'
				RAISERROR(@err_validation, 16, 1)
			end

			UPDATE [dbo].[MUser]
			SET 
				[IsDeleted] = 1
				,[UserModified] = @UserModified
				,[DateModified] = GETDATE()
			 WHERE UserID = @UserID
			 set @id_out = @UserID
		END
		ELSE
		BEGIN
			RAISERROR('Mode not defined', 16, 1)
		END
		
		select cast(1 as bit) issuccess, '' msg, '' err_msg
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET NOCOUNT OFF;
		select cast(0 as bit) issuccess, '' msg, ERROR_MESSAGE() err_msg
		ROLLBACK TRANSACTION
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_AccessByModulUserID]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_AccessByModulUserID]
	@Modul as varchar(50) = '',
	@UserID as int,
	@ListGroup as varchar(50) = ''
AS
BEGIN
	select 
	a.GroupUserMenuID
	,a.GroupID
	,a.MenuID
	,a.AllowCreate
	,a.AllowRead
	,a.AllowUpdate
	,a.AllowDelete
	,a.IsDeleted
	,a.UserCreated
	,a.DateCreated
	,a.UserModified
	,a.DateModified
	from MGroupUserMenu a with(nolock)
	inner join MMenu b with(nolock) on a.MenuID = b.MenuID
	inner join dbo.fnSplitString(@ListGroup, ',') c on a.GroupID = c.splitdata
	where a.IsDeleted = 0 and b.IsDeleted = 0
	and b.Modul = @Modul
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MenuByUserID]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MenuByUserID]
	@UserID as int
AS
BEGIN
	select 
	distinct
	a.[MenuID]
    , a.[ParentMenuID]
    , a.[MenuName]
    , a.[Modul]
    , a.[IconFA]
    , a.[IsMenu]
    , a.[PageUrl]
    , a.[IsDeleted]
    , a.[OrderPage]
    , a.[UserCreated]
    , a.[DateCreated]
    , a.[UserModified]
    , a.[DateModified]
	from 
	MMenu a with(nolock) 
	inner join MGroupUserMenu b with(nolock)  on a.MenuID = b.MenuID
	inner join MGroupUser c with(nolock)  on b.GroupID = c.GroupUserID
	inner join MUserGroup d with(nolock)  on b.GroupID = d.GroupUserID
	where d.UserID = @UserID and b.AllowRead = 1 and a.IsMenu = 1
	and a.IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MGroupUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MGroupUser]
	@GroupUserID int = null,
	@GroupUserName varchar(150) = null,
	@GroupCode varchar(50) = null
AS
BEGIN
	SELECT 
		[GroupUserID]
		,[GroupCode]
		,[GroupUserName]
		,[IsSuperAdmin]
		,[IsDeleted]
		,[UserCreated]
		,[DateCreated]
		,[UserModified]
		,[DateModified]
	FROM [MGroupUser]
	where (GroupUserID = @GroupUserID OR @GroupUserID is null)
	AND (@GroupUserName IS NULL OR GroupUserName LIKE '%'+@GroupUserName + '%')
	and (@GroupCode is null OR GroupCode = @GroupCode)
	and IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MGroupUserByUserID]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MGroupUserByUserID]
	@UserID as int
AS
BEGIN
	select 
	a.UserGroupID
	,b.GroupUserID
	,b.GroupUserName
	,b.IsDeleted
	,b.UserCreated
	,b.DateCreated
	,b.UserModified
	,b.DateModified
	from MUserGroup a with(nolock) 
	inner join MGroupUser b with(nolock)  on a.GroupUserID = b.GroupUserID
	where a.UserID = @UserID and b.IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MGroupUserByUserName]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MGroupUserByUserName]
	@UserName as varchar(150)
AS
BEGIN
	select 
	us.UserID
	, us.Email
	, us.Nik
	, us.OfficialName
	, us.UserName
	, us.Password
	, b.GroupUserID
	, b.GroupUserName
	, b.IsSuperAdmin
	, b.GroupCode
	from 
	MUser us with(nolock) 
	left join MUserGroup a with(nolock)  on us.UserID = a.UserID
	left join MGroupUser b with(nolock)  on a.GroupUserID = b.GroupUserID and b.IsDeleted = 0
	where us.UserName = @UserName and us.IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MGroupUserMenu]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MGroupUserMenu]
	@GroupUserMenuID as int = null,
	@GroupID as int = null,
	@GroupUserName as varchar(50) = null,
	@MenuID as int = null,
	@MenuName as varchar(50) = null
AS
BEGIN
SELECT
	a.GroupUserMenuID, a.GroupID, b.GroupUserName, a.MenuID, c.MenuName, c.OrderPage
	, c.IsMenu, c.PageUrl, d.OrderPage AS OrderPageParent, c.ParentMenuID, d.MenuName AS ParentMenuName
	, a.AllowCreate, a.AllowRead, a.AllowUpdate, a.AllowDelete
	, a.IsDeleted
	, a.UserCreated, a.DateCreated, a.UserModified, a.DateModified
FROM
	dbo.MGroupUserMenu AS a with(nolock)  INNER JOIN
	dbo.MGroupUser AS b with(nolock)  ON a.GroupID = b.GroupUserID INNER JOIN
	dbo.MMenu AS c with(nolock)  ON a.MenuID = c.MenuID LEFT OUTER JOIN
	dbo.MMenu AS d with(nolock)  ON c.ParentMenuID = d.MenuID
WHERE
	(a.IsDeleted = 0) AND (b.IsDeleted = 0) AND (c.IsDeleted = 0)
	AND (@GroupUserMenuID is null OR a.GroupUserMenuID = @GroupUserMenuID)
	AND (@GroupID is null OR a.GroupID = @GroupID)
	AND (@GroupUserName is null OR GroupUserName LIKE '%' + @GroupUserName + '%')
	AND (@MenuID is null OR a.MenuID = @MenuID)
	AND (@MenuName is null OR c.MenuName LIKE '%' + @MenuName + '%')
order by d.MenuName, c.MenuName, b.GroupUserName
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MGroupUserMenuPaging]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MGroupUserMenuPaging]
	@GroupUserMenuID as int = null,
	@GroupID as int = null,
	@GroupUserName as varchar(50) = null,
	@MenuID as int = null,
	@MenuName as varchar(50) = null
	, @PageSize as int = 10
	, @PageNumber as int = 1
	, @OrderBy as varchar(50) = 'OfficialName'
	, @Sort as varchar(10) = 'asc'
AS
BEGIN
SELECT
	a.GroupUserMenuID, a.GroupID, b.GroupUserName, a.MenuID, c.MenuName, c.OrderPage
	, c.IsMenu, c.PageUrl, d.OrderPage AS OrderPageParent, c.ParentMenuID, d.MenuName AS ParentMenuName
	, a.AllowCreate, a.AllowRead, a.AllowUpdate, a.AllowDelete
	, a.IsDeleted
	, a.UserCreated, a.DateCreated, a.UserModified, a.DateModified
	, COUNT(*) OVER(PARTITION BY 1) as TotalRows
FROM
	dbo.MGroupUserMenu AS a with(nolock)  INNER JOIN
	dbo.MGroupUser AS b with(nolock)  ON a.GroupID = b.GroupUserID INNER JOIN
	dbo.MMenu AS c with(nolock)  ON a.MenuID = c.MenuID LEFT OUTER JOIN
	dbo.MMenu AS d with(nolock)  ON c.ParentMenuID = d.MenuID
WHERE
	(a.IsDeleted = 0) AND (b.IsDeleted = 0) AND (c.IsDeleted = 0)
	AND (@GroupUserMenuID is null OR a.GroupUserMenuID = @GroupUserMenuID)
	AND (@GroupID is null OR a.GroupID = @GroupID)
	AND (@GroupUserName is null OR GroupUserName LIKE '%' + @GroupUserName + '%')
	AND (@MenuID is null OR a.MenuID = @MenuID)
	AND (@MenuName is null OR c.MenuName LIKE '%' + @MenuName + '%')
--order by 
--CASE @Sort
--        WHEN 'ASC' THEN
--            CASE @OrderBy
--                WHEN 'GroupUserName' THEN GroupUserName
--                WHEN 'ParentMenuName' THEN d.MenuName
--                WHEN 'MenuName' THEN c.MenuName
--                WHEN 'AllowCreate' THEN AllowCreate
--				WHEN 'AllowRead' THEN AllowRead
--				WHEN 'AllowUpdate' THEN AllowUpdate
--				WHEN 'AllowDelete' THEN AllowDelete
--                ELSE GroupUserName
--            END
--        ELSE '1'
--    END ASC,
--    CASE @Sort
--        WHEN 'DESC' THEN
--            CASE @OrderBy
--                WHEN 'GroupUserName' THEN GroupUserName
--                WHEN 'ParentMenuName' THEN d.MenuName
--                WHEN 'MenuName' THEN c.MenuName
--                WHEN 'AllowCreate' THEN AllowCreate
--				WHEN 'AllowRead' THEN AllowRead
--				WHEN 'AllowUpdate' THEN AllowUpdate
--				WHEN 'AllowDelete' THEN AllowDelete
--                ELSE GroupUserName
--            END
--        ELSE '1'
--    END DESC
order by GroupUserName
OFFSET @PageSize * (@PageNumber - 1) ROWS
FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MMenu]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MMenu]
	@MenuID int = null,
	@ParentMenuID int = null,
	@MenuName varchar(50) = null,
	@Modul varchar(50) = null,
	@IsMenu bit = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT 
		[MenuID]
		,[ParentMenuID]
		,[MenuName]
		,[Modul]
		,[IconFA]
		,[IsMenu]
		,[PageUrl]
		,[IsDeleted]
		,[OrderPage]
		,[UserCreated]
		,[DateCreated]
		,[UserModified]
		,[DateModified]
	FROM [MMenu] with(nolock) 
	  where 
		(@MenuID IS NULL OR MenuID = @MenuID)
		AND (@ParentMenuID IS NULL OR ParentMenuID = @ParentMenuID)
		AND (@MenuName IS NULL OR MenuName LIKE '%'+@MenuName + '%')
		AND (@Modul IS NULL OR ParentMenuID = @Modul)
		AND (@IsMenu IS NULL OR IsMenu = @IsMenu)
		AND IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MUser]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MUser]
	@UserID as varchar(255) = null,
	@OfficialName as varchar(255) = null,
	@UserName as varchar(50) = null,
	@Nik as varchar(15) = null,
	@Email as varchar(50) = null,
	@IsDeleted as bit = null
AS
BEGIN
	select
	[UserID]
		,[OfficialName]
		,[UserName]
		,[Password]
		,[Nik]
		,[Email]
		,[IsDeleted]
		,[UserCreated]
		,[DateCreated]
		,[UserModified]
		,[DateModified]
	FROM [MUser] with(nolock) 
	where 
	(@UserID IS NULL OR UserID = @UserID)
	AND (@OfficialName IS NULL OR OfficialName LIKE '%' + @OfficialName + '%')
	AND (@UserName IS NULL OR UserName = @UserName)
	AND (@Nik IS NULL OR Nik = @Nik )
	AND (@Email IS NULL OR Email = @Email)
	AND (@IsDeleted IS NULL OR IsDeleted = @IsDeleted)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookup_MUserWithGroup]    Script Date: 11/25/2019 9:55:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lookup_MUserWithGroup]
	@UserID as varchar(255) = null,
	@OfficialName as varchar(255) = null,
	@UserName as varchar(50) = null,
	@Nik as varchar(15) = null,
	@Email as varchar(50) = null,
	@IsDeleted as bit = null
	, @PageSize as int = 10
	, @PageNumber as int = 1
	, @OrderBy as varchar(50) = 'OfficialName'
	, @Sort as varchar(10) = 'asc'
AS
BEGIN
	SELECT 
		--distinct
		a.[UserID]
		,a.[OfficialName]
		,a.[UserName]
		,a.[Password]
		,a.[Nik]
		,a.[Email]
		,a.[IsDeleted]
		,a.[UserCreated]
		,a.[DateCreated]
		,a.[UserModified]
		,a.[DateModified]
		,SUBSTRING(
		(
			SELECT ',' + cast(GU2.GroupUserID as varchar(10)) AS [text()]
			FROM MGroupUser GU2
			inner join MUserGroup UG2 on GU2.GroupUserID = UG2.GroupUserID
			WHERE ug2.UserID = a.UserID
			FOR XML PATH ('')
		), 2, 1000) [GroupUserID]
		,SUBSTRING(
		(
			SELECT ',' + GU2.GroupUserName AS [text()]
			FROM MGroupUser GU2
			inner join MUserGroup UG2 on GU2.GroupUserID = UG2.GroupUserID
			WHERE ug2.UserID = a.UserID
			FOR XML PATH ('')
		), 2, 1000) [GroupUserName]
		, COUNT(*) OVER(PARTITION BY 1) as TotalRows
	FROM [MUser] a with(nolock) 
	where 
	(@UserID IS NULL OR a.UserID = @UserID)
	AND (@OfficialName IS NULL OR OfficialName LIKE '%' + @OfficialName + '%')
	AND (@UserName IS NULL OR UserName LIKE '%' + @UserName + '%')
	AND (@Nik IS NULL OR Nik LIKE '%' + @Nik + '%')
	AND (@Email IS NULL OR Email LIKE '%' + @Email + '%')
	AND (@IsDeleted IS NULL OR IsDeleted = @IsDeleted)
	order by 
	CASE @Sort
          WHEN 'ASC' THEN
               CASE @OrderBy
                    WHEN 'OfficialName' THEN OfficialName
                    WHEN 'Nik' THEN Nik
                    WHEN 'UserName' THEN UserName
                    WHEN 'Email' THEN Email
                    ELSE OfficialName
               END
          ELSE '1'
     END ASC,
     CASE @Sort
          WHEN 'DESC' THEN
               CASE @OrderBy
                    WHEN 'OfficialName' THEN OfficialName
                    WHEN 'Nik' THEN Nik
                    WHEN 'UserName' THEN UserName
                    WHEN 'Email' THEN Email
                    ELSE OfficialName
               END
          ELSE '1'
     END DESC
    OFFSET @PageSize * (@PageNumber - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY OPTION (RECOMPILE);
END
GO
USE [master]
GO
ALTER DATABASE [dsfsdfsdfds] SET  READ_WRITE 
GO
