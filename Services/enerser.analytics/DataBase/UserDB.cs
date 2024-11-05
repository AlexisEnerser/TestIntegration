using System.Data.SqlClient;
using enerser.analytics.Models;
using enerser.analytics.Models.Users;
using enerser.analytics.Utils;
using enerser.analytics.Models.Report;
using System.Data;

namespace enerser.analytics.DataBase
{
    public class UserDB
    {
        private readonly string _DataBaseConection;
        private readonly string _storeProcedureAccess;
        private readonly string _storeProcedureUser;
        public UserDB(IConfiguration configuration)
        {
            _DataBaseConection = configuration["ProyectConfiguration:ZohoAnalitycs:db"]!;
            _storeProcedureAccess = configuration["storeProcedure:stp_zoho_access"]!;
            _storeProcedureUser = configuration["storeProcedure:stp_zoho_user"]!;
        }

        public GeneralResponse consultEmployeePass(string userName)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureAccess, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "validateAccess");
                        command.Parameters.AddWithValue("@userName", userName);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse response = new GeneralResponse() { code = -2 };
                            while (reader.Read())
                            {
                                response.message = reader.GetValue("password", string.Empty);
                                response.code = string.IsNullOrWhiteSpace(response.message) ? -2 : 1;
                            }
                            return response;
                        }
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
        public GeneralResponse consultEmployeeEmail(string userName)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureAccess, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "validateAccess");
                        command.Parameters.AddWithValue("@userName", userName);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse response = new GeneralResponse() { code = -2 };
                            while (reader.Read())
                            {
                                response.message = reader.GetValue("email", string.Empty);
                                response.code = string.IsNullOrWhiteSpace(response.message) ? -2 : 1;
                            }
                            return response;
                        }
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
        public GeneralResponse<UserInfoResponseData> validateAccess(string userName)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureAccess, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "validateAccess");
                        command.Parameters.AddWithValue("@userName", userName);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<UserInfoResponseData> response = new GeneralResponse<UserInfoResponseData>() { code = -2 , data = new UserInfoResponseData(), message = "" };
                            while (reader.Read())
                            {
                                response.message = "success";
                                response.code = 1;
                                response.data.userId = reader.GetValue("id_user", 0);
                                response.data.username = reader.GetValue("username", string.Empty);
                                response.data.email = reader.GetValue("email", string.Empty);
                                response.data.userType = reader.GetValue("user_type", string.Empty);
                                response.data.status = reader.GetValue("status", string.Empty);
                                response.data.businessId = reader.GetValue("id_business", 0);
                                response.data.business = reader.GetValue("business_name", string.Empty);
                                response.data.mobileAccess = reader.GetValue("mobile_access", string.Empty);
                                response.data.userCategoryId = reader.GetValue("id_user_category", 0);
                                response.data.userCategory = reader.GetValue("user_category", string.Empty);
                                response.data.name = reader.GetValue("name", string.Empty);
                            }
                            return response;
                        }
                    }
                }
                catch (Exception ex)
                {
                    connection.Close();
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = -1,
                        message = ex.Message
                    };
                }
            }
        }
        public GeneralResponse recoveryPassword(string userName, string password)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureAccess, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "updatePassword");
                        command.Parameters.AddWithValue("@userName", userName);
                        command.Parameters.AddWithValue("@password", password);
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
        public GeneralResponse saveAccessRecord(LoginComplement data)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureAccess, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "saveAccessRecord");
                        command.Parameters.AddWithValue("@userId", data.userId);
                        command.Parameters.AddWithValue("@accessDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                        command.Parameters.AddWithValue("@platform", data.platform);
                        command.Parameters.AddWithValue("@ipAddress", data.ipAddress);
                        command.Parameters.AddWithValue("@device", data.device);
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
        public GeneralResponse<List<User>> consultAllUsers(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAllUsers");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse<List<User>> response = new GeneralResponse<List<User>>() { code = 1, data = new List<User>() };
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
        public GeneralResponse createUser(AdminUserCreateRequest request, int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "createUser");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@userName", request.user_name);
                        command.Parameters.AddWithValue("@password", request.password);
                        command.Parameters.AddWithNullableValue("@employeeNumber", request.employee_number);
                        command.Parameters.AddWithValue("@userType", request.id_user_type);
                        command.Parameters.AddWithNullableValue("@email", request.email);
                        command.Parameters.AddWithValue("@name", request.name);
                        command.Parameters.AddWithValue("@userCategory", request.id_user_category);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            GeneralResponse response = new GeneralResponse();
                            while (reader.Read())
                            {
                                response.message = reader.GetValue("message", string.Empty);
                                response.code = reader.GetValue("code", 0);
                            }
                            return response;
                        }
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
        public GeneralResponse updateUser(AdminUserUpdateRequest request)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "updateUser");
                        command.Parameters.AddWithValue("@userId", request.id);
                        command.Parameters.AddWithNullableValue("@password", request.password);
                        command.Parameters.AddWithNullableValue("@employeeNumber", request.employee_number);
                        command.Parameters.AddWithValue("@userType", request.id_user_type);
                        command.Parameters.AddWithNullableValue("@email", request.email);
                        command.Parameters.AddWithValue("@name", request.name);
                        command.Parameters.AddWithValue("@userCategory", request.id_user_category);
                        command.Parameters.AddWithValue("@statusId", request.id_status);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            return new GeneralResponse()
                            {
                                code = 1,
                            };
                        }
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
        public GeneralResponse<List<ReportResponseData>> consultUserReports(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultAssignedReports");
                        command.Parameters.AddWithValue("@userId", userId);
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
        public GeneralResponse<List<ReportResponseData>> consultUserNoReports(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "consultNOTAssignedReports");
                        command.Parameters.AddWithValue("@userId", userId);
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
        public GeneralResponse clearReports(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "clearReports");
                        command.Parameters.AddWithValue("@userId", userId);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return  new GeneralResponse() { code = 1, message = "success" };
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
        public GeneralResponse addReport(int userId, int reportId)
        {
            using (SqlConnection connection = new SqlConnection(_DataBaseConection))
            {
                try
                {
                    using (SqlCommand command = new SqlCommand(_storeProcedureUser, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@method", "AddReport");
                        command.Parameters.AddWithValue("@userId", userId);
                        command.Parameters.AddWithValue("@reportId", reportId);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                        return new GeneralResponse() { code = 1, message = "success" };
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