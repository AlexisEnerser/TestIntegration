USE [Zoho_Enerser]
GO
/****** Object:  StoredProcedure [dbo].[stp_zoho_report]    Script Date: 8/8/2024 3:28:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************/
ALTER PROCEDURE [dbo].[stp_zoho_report]
(
	@method							VARCHAR(50),
	@userId							int = NULL,
	@businessId						int = NULL,
	@groupId						int = NULL,
	@reportId						int = NULL,
	@reportName						VARCHAR(255) = NULL,
	@reportURL						VARCHAR(255) = NULL,
	@reportTypeId					int = NULL,
	@statusId						int = NULL
)
--WITH ENCRYPTION
AS
SET NOCOUNT ON
	declare	@@sqlData nvarchar(4000)

if @method = 'consultReportsOfUser'
begin
	--Consult reports of the user
	SELECT 
		r.*,
		rt.document_description as 'reportType'
	FROM reports r
	INNER JOIN [report_type] rt on rt.id_report_type = r.id_report_type
	INNER JOIN [report_users] ru on ru.id_report = r.id_report
	WHERE ru.id_user = @userId
	AND r.id_status = 1 -- active status
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultGroupsOfUser'
begin
	--Consult groups of user
	SELECT
		g.*
	FROM [group] g
	INNER JOIN [user_groups] ug ON ug.id_group = g.id_group
	WHERE ug.id_user = @userId
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultReportsOfaGroup'
begin
	-- Consult reports of groups
	SELECT 
		r.*,
		rt.document_description as 'reportType'
	FROM reports r
	INNER JOIN [report_type] rt on rt.id_report_type = r.id_report_type
	INNER JOIN [report_groups] rg on rg.id_report = r.id_report
	WHERE rg.id_group = @groupId
	AND r.id_status = 1 -- active status
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultFavoriteReports'
begin
	--Consult favorite reports
	SELECT
		r.*,
		rt.document_description as 'reportType'
	FROM reports r
	INNER JOIN [report_type] rt on rt.id_report_type = r.id_report_type
	INNER JOIN report_favorite rf on rf.id_report = r.id_report
	WHERE rf.id_user = @userId
	AND r.id_status = 1 -- active status
end
--------------------------------------------------------------------------------------------------------
if @method = 'setFavoriteReports'
begin
	--insert favorite reports
	IF NOT EXISTS(SELECT 1 FROM [report_favorite] WHERE [id_report] = @reportId AND [id_user] = @userId)
	BEGIN
		INSERT INTO [report_favorite] ([id_report],[id_user])
		VALUES (@reportId,@userId)
	END
end
--------------------------------------------------------------------------------------------------------
if @method = 'daleteFavoriteReports'
begin
	--delete favorite reports
	DELETE FROM [report_favorite]
	WHERE [id_report] = @reportId
	AND [id_user] = @userId
end
--------------------------------------------------------------------------------------------------------
if @method = 'consultAllReports'
begin
	SELECT 
		r.*,
		rt.document_description as 'reportType', 
		s.[description] as 'status'
	FROM reports r
	INNER JOIN [report_type] rt on rt.id_report_type = r.id_report_type
	INNER JOIN [status] s ON r.id_status = s.id_status
end
--------------------------------------------------------------------------------------------------------
if @method = 'createReport'
begin
	SELECT 
	@businessId = id_business
	FROM [user]
	WHERE id_user = @userId

	INSERT INTO [reports]([report_name],[report_access_url],[id_report_type],[date_creation],[id_status],[id_user],[id_business])
	VALUES (@reportName,@reportURL,@reportTypeId,GETDATE(),1,@userId,@businessId)

end
--------------------------------------------------------------------------------------------------------
if @method = 'updateReport'
begin

	UPDATE [reports]
	SET [report_name] = @reportName
	, [report_access_url] = @reportURL
	, [id_report_type] = @reportTypeId
	, [date_update] = GETDATE()
	, [id_status] = @statusId
	WHERE [id_report] = @reportId
end
--------------------------------------------------------------------------------------------------------
if @method = 'saveReportRecord'
begin
	INSERT INTO [opened_report_record] ([id_user],[id_report],[date])
	VALUES (@userId,@reportId,GETDATE())
end
--------------------------------------------------------------------------------------------------------
return