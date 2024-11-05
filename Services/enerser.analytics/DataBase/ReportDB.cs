using System.Data;
using System.Data.SqlClient;
using enerser.analytics.Models;
using enerser.analytics.Models.Report;
using enerser.analytics.Utils;

namespace enerser.analytics.DataBase
{
    public class ReportDB
    {
        private readonly string _DataBaseConection;
        private readonly string _storeProcedure;
        public ReportDB(IConfiguration configuration)
        {
            _DataBaseConection = configuration["ProyectConfiguration:ZohoAnalitycs:db"]!;
            _storeProcedure = configuration["storeProcedure:stp_zoho_report"]!;
        }

        public GeneralResponse createReport(AdminReportCreateRequest data, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "createReport");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@reportName", data.name);
                        command.Parameters.AddWithValue("@reportURL", data.url);
                        command.Parameters.AddWithValue("@reportTypeId", data.report_type_id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return new GeneralResponse()
                        {
                            code = 1,
                            message = "success"
                        };
                    }
                }
                catch (Exception ex)
                {

                    connection.Close();
                    return new GeneralResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse updateReport(AdminReportUpdateRequest data, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "updateReport");
                        command.Parameters.AddWithValue("@reportId", data.id);
                        command.Parameters.AddWithValue("@reportName", data.name);
                        command.Parameters.AddWithValue("@reportURL", data.url);
                        command.Parameters.AddWithValue("@reportTypeId", data.report_type_id);
                        command.Parameters.AddWithValue("@statusId", data.status_id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return new GeneralResponse()
                        {
                            code = 1,
                            message = "success"
                        };
                    }
                }
                catch (Exception ex)
                {

                    connection.Close();
                    return new GeneralResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse<List<Report>> consultAllReports()
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAllReports");
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<Report>> response = new GeneralResponse<List<Report>>() { code = 1, message = "success", data = new List<Report>() };
                            while (reader.Read())
                            {
                                response.data.Add(new Report()
                                {
                                    name = reader.GetValue("report_name", string.Empty),
                                    id = reader.GetValue("id_report", 0),
                                    report_type = reader.GetValue("reportType", string.Empty),
                                    report_type_id = reader.GetValue("id_report_type", 0),
                                    url = reader.GetValue("report_access_url", string.Empty),
                                    status_id = reader.GetValue("id_status", 0),
                                    status = reader.GetValue("status", string.Empty),
                                });
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<List<Report>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public ReportResponse consultReportsOfUser(string userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultReportsOfUser");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            ReportResponse response = new ReportResponse() { code = 1, message = "success" };
                            while (reader.Read())
                            {
                                response.myReports.Add(new ReportResponseData(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new ReportResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public ReportResponse consultGroupsOfUser(string userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultGroupsOfUser");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            ReportResponse response = new ReportResponse() { code = 1,message ="success" };
                            while (reader.Read())
                            {
                                UserGroup groupTemporal = new UserGroup()
                                {
                                    groupId = reader.GetValue("id_group", 0),
                                    group = reader.GetValue("group_name", string.Empty)
                                };
                                ReportResponse temporal = consultReportsOfaGroup(groupTemporal.groupId);
                                groupTemporal.report = temporal.myReports;
                                response.groupReports.Add(groupTemporal);
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new ReportResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        private ReportResponse consultReportsOfaGroup(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultReportsOfaGroup");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            ReportResponse response = new ReportResponse() { code = 1, message = "success" };
                            while (reader.Read())
                            {
                                response.myReports.Add(new ReportResponseData(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new ReportResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public ReportResponse consultFavoriteReports(string userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultFavoriteReports");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            ReportResponse response = new ReportResponse() { code = 1, message = "success" };
                            while (reader.Read())
                            {
                                ReportResponseData report = new ReportResponseData(reader);
                                report.isFavorite = true;
                                response.myReports.Add(report);
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new ReportResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse setFavoriteReports(string userId, string reportId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "setFavoriteReports");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@reportId", reportId);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return new GeneralResponse()
                        {
                            code = 1,
                            message = "success"
                        };
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse deleteFavoriteReports(string userId, string reportId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "daleteFavoriteReports");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@reportId", reportId);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return new GeneralResponse()
                        {
                            code = 1,
                            message = "success"
                        };
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        } 
        public void saveRecord(int userId, int reportId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "saveReportRecord");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@reportId", reportId);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                catch{
                    connection.Close();
                }
            }
        }
    }
}
