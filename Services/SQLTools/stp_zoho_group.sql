USE [Zoho_Enerser]
GO
/****** Object:  StoredProcedure [dbo].[stp_zoho_group]    Script Date: 6/13/2024 9:18:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************/
ALTER PROCEDURE [dbo].[stp_zoho_group]
(
	@method							VARCHAR(50),
	@userId							int = NULL,
	@groupId						int = NULL,
	@reportId						int = NULL,
	@businessId						int = NULL,
	@groupName						VARCHAR(255) = NULL,
	@groupDescription				VARCHAR(255) = NULL
)
--WITH ENCRYPTION
AS
SET NOCOUNT ON
	declare	@@sqlData nvarchar(4000)
--------------------------------------------------------------------------------------------------------
if @method = 'consultAllGroups'
begin
	SELECT 
		g.*
	FROM [Zoho_Enerser].[dbo].[group] g
	INNER JOIN [Zoho_Enerser].[dbo].[user] u on u.id_business = g.id_business
	WHERE u.id_user = @userId
end
--------------------------------------------------------------------------------------------------------
if @method = 'createGroup'
begin
	SELECT 
	@businessId = id_business
	FROM [user]
	WHERE id_user = @userId

	INSERT INTO [group]([group_name],[group_description],[id_business])
	VALUES (@groupName, @groupDescription, @businessId)

end
--------------------------------------------------------------------------------------------------------
if @method = 'updateGroup'
begin

	UPDATE [group]
	SET [group_name] = @groupName
	, [group_description] = @groupDescription
	WHERE [id_group] = @groupId
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultAssignedReports'
begin
	SELECT
      r.*
	  ,rt.document_description as 'reportType'
	FROM [Zoho_Enerser].[dbo].[report_groups] rg
	INNER JOIN [Zoho_Enerser].[dbo].[reports] r ON r.id_report = rg.id_report
	INNER JOIN [Zoho_Enerser].[dbo].[report_type] rt ON rt.id_report_type = r.id_report_type
	WHERE rg.id_group = @groupId
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
				rg.id_report
			FROM [Zoho_Enerser].[dbo].[report_groups] rg
			WHERE rg.id_group = @groupId
		);
end
--------------------------------------------------------------------------------------------------------
if @method = 'clearReports'
begin
	DELETE FROM [Zoho_Enerser].[dbo].[report_groups]
	WHERE id_group = @groupId
end
--------------------------------------------------------------------------------------------------------
if @method = 'AddReport'
begin
	INSERT INTO [Zoho_Enerser].[dbo].[report_groups](id_report,id_group)
	VALUES (@reportId, @groupId)
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultAssignedUsers'
begin
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
	FROM [Zoho_Enerser].[dbo].[user_groups] ug
	INNER JOIN [Zoho_Enerser].[dbo].[user] u ON u.id_user = ug.id_user
	INNER JOIN [Zoho_Enerser].[dbo].[business] b ON b.[id_business] = u.[id_business]
	INNER JOIN [Zoho_Enerser].[dbo].[status] s ON s.[id_status] = u.[id_status]
	INNER JOIN [Zoho_Enerser].[dbo].[user_type] ut ON ut.id_user_type = u.id_user_type
	INNER JOIN [Zoho_Enerser].[dbo].[user_category] uc ON uc.id_user_category = u.id_user_category
	WHERE s.id_status = 5-- estatus de usuarios
	AND ug.id_group = @groupId
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultNOTAssignedUsers'
begin
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
	WHERE s.id_status = 5 -- estatus de usuarios
	AND u.id_user NOT IN (
			SELECT 
				ug.id_user
			FROM [Zoho_Enerser].[dbo].[user_groups] ug
			WHERE ug.id_group = @groupId
		);
end
--------------------------------------------------------------------------------------------------------
if @method = 'clearUsers'
begin
	DELETE FROM [Zoho_Enerser].[dbo].[user_groups]
	WHERE id_group = @groupId
end
--------------------------------------------------------------------------------------------------------
if @method = 'AddUser'
begin
	INSERT INTO [Zoho_Enerser].[dbo].[user_groups](id_user,id_group)
	VALUES (@userId, @groupId)
end
--------------------------------------------------------------------------------------------------------
return
