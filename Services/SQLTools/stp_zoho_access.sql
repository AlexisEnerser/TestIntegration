USE [Zoho_Enerser]
GO
/****** Object:  StoredProcedure [dbo].[stp_zoho_access]    Script Date: 8/6/2024 12:34:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************/
ALTER PROCEDURE [dbo].[stp_zoho_access]
(
	@method							VARCHAR(50),
	@userName						VARCHAR(600) = NULL,
	@password						VARCHAR(600)= NULL,
	@userId							int = NULL,
	@groupId						int = NULL,
	@accessDate						datetime = null,
	@platform						varchar(100) = null,
	@ipAddress						varchar(60) = null,
	@device							varchar(600)= null
)
--WITH ENCRYPTION
AS
SET NOCOUNT ON
	declare	@@sqlData nvarchar(4000)
	
--------------------------------------------------------------------------------------------------------
if @method = 'validateAccess' 
begin
	select 
	   u.id_user
	  ,u.[name]
	  ,u.[username]
	  ,u.[password]
	  ,u.[email] 
	  ,u.[id_user_type]
	  ,ut.[description] as 'user_type'
	  ,u.[id_status]
	  ,s.[description] as 'status'
	  ,u.[id_business]
	  ,b.[business_name]
	  ,CASE l.[mobile_access]
		WHEN 0
			THEN l.[mobile_access]
		WHEN 1
			THEN l.[mobile_access]
		ELSE
			1
		END as 'mobile_access'
	  ,CASE l.[mobile_access]
		WHEN 0
			THEN l.[mobile_access]
		WHEN 1
			THEN l.[mobile_access]
		ELSE
			1
		END as 'is_premium'
	   ,u.id_user_category
	   ,uc.[description] as 'user_category'
	  from [user] u 
	  INNER JOIN business b on u.[id_business] = b.[id_business]
	  INNER JOIN user_type ut on u.[id_user_type] = ut.[id_user_type]
	  INNER JOIN [status] s on s.id_status = u.id_status
	  LEFT JOIN [user_licenses] ul on ul.[id_user] = u.id_user
	  LEFT JOIN [licenses] l on l.[id_license] = ul.[id_license]
	  LEFT JOIN [user_category] uc on u.[id_user_category] = uc.id_user_category
	  WHERE [username] = @userName
	  AND u.id_status = 5 --usuario activo
end

--------------------------------------------------------------------------------------------------------
if @method = 'updatePassword'
begin
	update [user]
	set [Password] = @password
	where [username] = @userName
end
--------------------------------------------------------------------------------------------------------
if @method = 'saveAccessRecord'
begin
	INSERT INTO [access_record] ([id_user],[access_date],[platform],[ipAddress],[device])
	VALUES (@userId,@accessDate,@platform,@ipAddress,@device)
end
--------------------------------------------------------------------------------------------------------
return
