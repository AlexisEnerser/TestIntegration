using enerser.analytics.DataBase;
using enerser.analytics.JWT;
using enerser.analytics.Models;
using enerser.analytics.Models.Group;
using enerser.analytics.Models.Report;
using enerser.analytics.Models.Users;
using enerser.analytics.Utils;
using SendrigMailer;

namespace enerser.analytics.Services
{
    public class UserServices
    {
        private readonly UserDB _UserDB;
        private readonly JwtService _jwtService;

        public UserServices(UserDB UserDB, JwtService jwtService)
        {
            _UserDB = UserDB;
            _jwtService = jwtService;
        }

        public GeneralResponse makeLogin(string userName, string password, LoginComplement data)
        {
            if(string.IsNullOrWhiteSpace(data.platform)|| string.IsNullOrWhiteSpace(data.device))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Acceso fraudulento"
                };
            }
            GeneralResponse<UserInfoResponseData> response = ValidateUser(userName, password);
            if(response.code != 1)
            {
                return new GeneralResponse(){ 
                    code =response.code,
                    message = response.message
                };
            }

            data.userId = response.data!.userId.ToString();
            _UserDB.saveAccessRecord(data);
            
            return new GeneralResponse()
            {
                code = 1,
                message = _jwtService.GenerateToken(response.data)
            };
        }
        private GeneralResponse<UserInfoResponseData> ValidateUser(string userName, string password)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(userName))
                {
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = -1,
                        message = "Es necesario enviar su usuario"
                    };
                }

                if (string.IsNullOrWhiteSpace(password))
                {
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = -1,
                        message = "Es necesario enviar su contraseña"
                    };
                }


                GeneralResponse consultUserPass = _UserDB.consultEmployeePass(userName);
                if (consultUserPass.code != 1)
                {
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = consultUserPass.code,
                        message = "Usuario no registrado"
                    };
                }

                if (!consultUserPass.message.VerifyPassword(password))
                {
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = -1,
                        message = "Credenciales Incorrectas"
                    };
                }

                GeneralResponse<UserInfoResponseData> validateAccess = _UserDB.validateAccess(userName);
                if (validateAccess.code != 1)
                {
                    return new GeneralResponse<UserInfoResponseData>()
                    {
                        code = validateAccess.code,
                        message = validateAccess.message
                    };
                }

                return validateAccess;
            }
            catch (Exception ex)
            {
                return new GeneralResponse<UserInfoResponseData>()
                {
                    code = -1,
                    message = ex.Message
                };

            }
        }
        public async Task<GeneralResponse> userRecoveryPassword (string userName)
        {
            try
            {
                GeneralResponse consultUserEmail = _UserDB.consultEmployeeEmail(userName);
                if (consultUserEmail.code != 1)
                {
                    return new GeneralResponse()
                    {
                        code = consultUserEmail.code,
                        message = "Usuario no registrado"
                    };
                }
                string securePassword = "".GeneratePassword(8);
                string hashedPassword = securePassword.HashPassword();

                GeneralResponse updatePassword = _UserDB.recoveryPassword(userName, hashedPassword);
                if (updatePassword.code != 1)
                {
                    return new GeneralResponse()
                    {
                        code = updatePassword.code,
                        message = "Lo sentimos hubo error"
                    };
                }

                await SendRecoveryEmail(consultUserEmail.message, securePassword);
                return consultUserEmail;
            }
            catch (Exception ex)
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = ex.Message
                };

            }

        }
        public GeneralResponse<List<User>> consultAllUsers(int userId)
        {
            return _UserDB.consultAllUsers(userId);
        }
        public GeneralResponse createUser(AdminUserCreateRequest request, int userId)
        {
            if (string.IsNullOrWhiteSpace(request.user_name))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un nombre de usuario"
                };
            }
            if (string.IsNullOrWhiteSpace(request.name))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un nombre"
                };
            }
            if (string.IsNullOrWhiteSpace(request.password))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar una contraseña"
                };
            }
            if (request.password.Length<8)
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "La contraseña debe se mayor o igual a 8 caracteres"
                };
            }
            request.password = request.password.HashPassword();
            if (request.id_user_type < 0)
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un tipo de usuario"
                };
            }
            if (request.id_user_category < 0)
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar una categoria de usuario"
                };
            }
            if (!string.IsNullOrWhiteSpace(request.email) && !request.email.IsValidEmail())
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "El correo enviado no es válido"
                };            
            }
            return _UserDB.createUser(request, userId);
        }
        public GeneralResponse updateUser(AdminUserUpdateRequest request)
        {
            if (!string.IsNullOrWhiteSpace(request.password))
            {
                request.password = request.password.HashPassword();
            }
            return _UserDB.updateUser(request);
        }
        public GeneralResponse<List<ReportResponseData>> consultUserReports(int userId)
        {
            return _UserDB.consultUserReports(userId);
        }
        public GeneralResponse<List<ReportResponseData>> consultUserNoReports(int userId)
        {
            return _UserDB.consultUserNoReports(userId);
        }
        public GeneralResponse editUserReports(AddGroupReportRequest data)
        {
            GeneralResponse response = _UserDB.clearReports(data.id);
            if (response.code < 0)
            {
                return response;
            }

            foreach (int item in data.reports)
            {
                _UserDB.addReport(data.id, item);
            }

            return response;
        }
        private async Task SendRecoveryEmail(string email, string password)
        {
            string htmlBody;
            using (var reader = new StreamReader("Templates/emailTemplate.html"))
            {
                htmlBody = await reader.ReadToEndAsync();
            }
            htmlBody = htmlBody.Replace("{Code}", password);
            Mailer mailer = new Mailer();
            await mailer.Send(
                 new List<string>() { email }
                 , "Recuperación de contraseña"
                 , "Zoho Enerser"
                 , htmlBody
            );
        }
    }
}
