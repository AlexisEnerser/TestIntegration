using System.Data;
using System.Data.SqlClient;
using enerser.analytics.Models;
using enerser.analytics.Models.Group;
using enerser.analytics.Models.Report;
using enerser.analytics.Models.Users;
using enerser.analytics.Utils;

namespace enerser.analytics.DataBase
{
    public class GroupDB
    {
        private readonly string _DataBaseConection;
        private readonly string _storeProcedure;
        public GroupDB(IConfiguration configuration)
        {
            _DataBaseConection = configuration["ProyectConfiguration:ZohoAnalitycs:db"]!;
            _storeProcedure = configuration["storeProcedure:stp_zoho_group"]!;
        }

        public GeneralResponse createGroup(Group data, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "createGroup");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@groupName", data.name);
                        command.Parameters.AddWithValue("@groupDescription", data.description);
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
        public GeneralResponse updateGroup(Group data, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "updateGroup");
                        command.Parameters.AddWithValue("@groupId", data.id);
                        command.Parameters.AddWithValue("@groupName", data.name);
                        command.Parameters.AddWithValue("@groupDescription", data.description);
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
        public GeneralResponse<List<Group>> consultAllGroups(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAllGroups");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<Group>> response = new GeneralResponse<List<Group>>() { code = 1, message = "success", data = new List<Group>() };
                            while (reader.Read())
                            {
                                response.data.Add(new Group()
                                {
                                    id = reader.GetValue("id_group", 0),
                                    name = reader.GetValue("group_name", string.Empty),
                                    description = reader.GetValue("group_description", string.Empty),
                                });
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<List<Group>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse<List<ReportResponseData>> consultGroupReports(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAssignedReports");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<ReportResponseData>> response = new GeneralResponse<List<ReportResponseData>>() { code = 1, message = "success", data = new List<ReportResponseData>() };
                            while (reader.Read())
                            {
                                response.data.Add(new ReportResponseData(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<List<ReportResponseData>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse<List<ReportResponseData>> consultGroupNoReports(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultNOTAssignedReports");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<ReportResponseData>> response = new GeneralResponse<List<ReportResponseData>>() { code = 1, message = "success", data = new List<ReportResponseData>() };
                            while (reader.Read())
                            {
                                response.data.Add(new ReportResponseData(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<List<ReportResponseData>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse clearReports(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "clearReports");
                        command.Parameters.AddWithValue("@groupId", groupId);
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
        public GeneralResponse addReport(int groupId, int reportId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "AddReport");
                        command.Parameters.AddWithValue("@groupId", groupId);
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
        public GeneralResponse<List<User>> consultGroupUsers(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAssignedUsers");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<User>> response = new GeneralResponse<List<User>>() { code = 1, message = "success", data = new List<User>() };
                            while (reader.Read())
                            {
                                response.data.Add(new User(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<List<User>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse<List<User>> consultGroupNoUsers(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultNOTAssignedUsers");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<User>> response = new GeneralResponse<List<User>>() { code = 1, message = "success", data = new List<User>() };
                            while (reader.Read())
                            {
                                response.data.Add(new User(reader));
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {

                    connection.Close();
                    return new GeneralResponse<List<User>>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse clearUsers(int groupId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "clearUsers");
                        command.Parameters.AddWithValue("@groupId", groupId);
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
        public GeneralResponse addUser(int groupId, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "AddUser");
                        command.Parameters.AddWithValue("@groupId", groupId);
                        command.Parameters.AddWithValue("@userId", userId);
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
    }
}
