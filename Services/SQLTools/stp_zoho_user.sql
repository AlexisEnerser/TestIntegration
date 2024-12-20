USE [Zoho_Enerser]
GO
/****** Object:  StoredProcedure [dbo].[stp_zoho_user]    Script Date: 6/13/2024 1:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************/

/*
SELECT TOP (1000) [id_user] -
      ,[username]
      ,[password]
      ,[employee_number]
      ,[date_creation]
      ,[id_user_type]
      ,[id_status]
      ,[id_business]
      ,[email]
      ,[is_premium]
      ,[name]
      ,[id_user_category]
  FROM [Zoho_Enerser].[dbo].[user]
*/

ALTER PROCEDURE [dbo].[stp_zoho_user]
(
	@method							VARCHAR(50),
	@userId							INT = NULL,
	@reportId						INT = NULL,
	@businessId						INT = NULL,
	@userName						VARCHAR(255) = NULL,
	@password						VARCHAR(255) = NULL,
	@employeeNumber					INT = NULL,
	@userType						INT = NULL,
	@email							VARCHAR(200) = NULL,
	@name							VARCHAR(255) = NULL,
	@userCategory					INT = NULL,
	@statusId						INT = NULL,
	@existUser						INT = NULL
)
--WITH ENCRYPTION
AS
SET NOCOUNT ON
	declare	@@sqlData nvarchar(4000)
--------------------------------------------------------------------------------------------------------
if @method = 'consultAllUsers'
begin
	SELECT
	@businessId = id_business
	FROM [Zoho_Enerser].[dbo].[user] 
	WHERE id_user = @userId

	SELECT u.[id_user]
      ,u.[username]
      ,u.[password]
      ,u.[employee_number]
      ,u.[date_creation]
      ,u.[id_user_type]
	  ,ut.[description] as 'user_type'
      ,u.[id_status]
	  ,s.[description] as 'status'
      ,u.[id_business]
	  ,b.[business_name]
      ,u.[email]
      ,u.[name]
      ,u.[id_user_category]
	  ,uc.[description] as 'user_category'
	FROM [Zoho_Enerser].[dbo].[user] u
	INNER JOIN [Zoho_Enerser].[dbo].[business] b ON b.[id_business] = u.[id_business]
	INNER JOIN [Zoho_Enerser].[dbo].[status] s ON s.[id_status] = u.[id_status]
	INNER JOIN [Zoho_Enerser].[dbo].[user_type] ut ON ut.id_user_type = u.id_user_type
	INNER JOIN [Zoho_Enerser].[dbo].[user_category] uc ON uc.id_user_category = u.id_user_category
	WHERE s.id_status_type = 1 -- estatus de usuarios
	AND u.id_business = @businessId
end
--------------------------------------------------------------------------------------------------------
if @method = 'createUser'
begin
	SELECT 
	@businessId = id_business
	FROM [user]
	WHERE id_user = @userId

	IF @email is not NULL
	BEGIN
		-- Valida que correo este disponible
		SELECT 
		@existUser = COUNT(id_user)
		FROM [user]
		WHERE [email] = @email;

		IF @existUser>0 BEGIN
			SELECT 
			-1 as 'code',
			'Correo ya utilizado por otro usuario' as 'message'
			RETURN;
		END
	END

	-- Valida que username este disponible
	SELECT 
	@existUser = COUNT(id_user)
	FROM [user]
	WHERE [username] = @userName;

	IF @existUser>0 BEGIN
		SELECT 
		-1 as 'code',
		'Nombre de usuario ya utilizado' as 'message'
		RETURN;
	END

	IF @employeeNumber is not NULL
	BEGIN
		-- Valida que número de empleado este disponible
		SELECT 
		@existUser = COUNT(id_user)
		FROM [user]
		WHERE [employee_number] = @employeeNumber;

		IF @existUser>0 BEGIN
			SELECT 
			-1 as 'code',
			'Numero de empleado ya utilizado' as 'message'
			RETURN;
		END
	END

	DECLARE @generated_keys_user table([Id] int)

	INSERT INTO [user](
	  [username]
      ,[password]
      ,[employee_number]
      ,[date_creation]
      ,[id_user_type]
      ,[id_status]
      ,[id_business]
      ,[email]
      ,[name]
      ,[id_user_category])
	OUTPUT INSERTED.id_user INTO @generated_keys_user
	VALUES (
		@userName
		,@password
		,@employeeNumber
		,GETDATE()
		,@userType
		,5
		,@businessId
		,@email
		,@name
		,@userCategory
	)

	SELECT @userId = id FROM @generated_keys_user
	
	INSERT INTO user_licenses([id_license],[id_user],[id_license_time])
	VALUES (2,@userId,2)

	SELECT 
	1 as 'code',
	'Success' as 'message'
end
--------------------------------------------------------------------------------------------------------
if @method = 'updateUser'
begin

	IF @password is null
	BEGIN
		SELECT
		@password = [password]
		FROM [user]
		WHERE [id_user] = @userId
	END

	UPDATE [user]
	SET [password] = @password
      ,[employee_number] = @employeeNumber
      ,[id_user_type] = @userType
      ,[email] = @email
      ,[name] = @name
      ,[id_user_category] = @userCategory
	  , [id_status] = @statusId
	WHERE [id_user] = @userId
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultAssignedReports'
begin
	SELECT
      r.*
	  ,rt.document_description as 'reportType'
	FROM [Zoho_Enerser].[dbo].[report_users] ru
	INNER JOIN [Zoho_Enerser].[dbo].[reports] r ON r.id_report = ru.id_report
	INNER JOIN [Zoho_Enerser].[dbo].[report_type] rt ON rt.id_report_type = r.id_report_type
	WHERE ru.id_user = @userId
	AND r.id_status = 1 -- activo para reportes
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultNOTAssignedReports'
begin
	SELECT 
		r.*
		,rt.document_description as 'reportType'
	FROM [Zoho_Enerser].[dbo].[reports] r
	INNER JOIN [Zoho_Enerser].[dbo].[report_type] rt ON rt.id_report_type = r.id_report_type
	WHERE  r.id_status = 1-- activo para reportes
	AND r.id_report NOT IN (
			SELECT 
				ru.id_report
			FROM [Zoho_Enerser].[dbo].[report_users] ru
			WHERE ru.id_user = @userId
		);
end
--------------------------------------------------------------------------------------------------------
if @method = 'clearReports'
begin
	DELETE FROM [Zoho_Enerser].[dbo].[report_users]
	WHERE id_user = @userId
end
--------------------------------------------------------------------------------------------------------
if @method = 'AddReport'
begin
	INSERT INTO [Zoho_Enerser].[dbo].[report_users](id_report,id_user)
	VALUES (@reportId, @userId)
end
--------------------------------------------------------------------------------------------------------
return
