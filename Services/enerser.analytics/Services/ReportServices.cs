using enerser.analytics.DataBase;
using enerser.analytics.Models;
using enerser.analytics.Models.Report;
using enerser.analytics.Models.Users;

namespace enerser.analytics.Services
{
    public class ReportServices
    {
        private readonly ReportDB _ReportDB;
        public ReportServices(IConfiguration configuration, ReportDB ReportDB)
        {
            _ReportDB = ReportDB;
        }

        public GeneralResponse createReport(AdminReportCreateRequest data, int userId)
        {
            if (string.IsNullOrWhiteSpace(data.name))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un nombre de reporte"
                };
            }
            if (string.IsNullOrWhiteSpace(data.url))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar el url del reporte"
                };
            }
            if (data.report_type_id<0 || data.report_type_id>2)
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un tipo de reporte válido"
                };
            }
            return _ReportDB.createReport(data, userId);
        }

        public GeneralResponse updateReport(AdminReportUpdateRequest data, int userId)
        {
            return _ReportDB.updateReport(data, userId);
        }

        public GeneralResponse<List<Report>> consultAllReports()
        {
            return _ReportDB.consultAllReports();
        }

        public ReportResponse getUseReports(string userId, int userCategoryId, string userName)
        {
            ReportResponse response = new ReportResponse() { code = 1,message = "success" };

            ReportResponse favoriteReports = _ReportDB.consultFavoriteReports(userId);
            if (favoriteReports.code == 1)
            {
                response.favoriteReports = favoriteReports.myReports;
            }

            ReportResponse myReport = _ReportDB.consultReportsOfUser(userId);
            if(myReport.code == 1)
            {
                myReport.myReports = validateFavoriteReports(myReport.myReports, favoriteReports);
                response.myReports = myReport.myReports;
            }

            ReportResponse groupReports = _ReportDB.consultGroupsOfUser(userId);
            if (groupReports.code == 1)
            {
                for(int index =0;index< groupReports.groupReports.Count; index++)
                {
                    groupReports.groupReports[index].report = validateFavoriteReports(groupReports.groupReports[index].report, favoriteReports);
                }
                response.groupReports = groupReports.groupReports;
            }

            response.groupReports = ValidateGroupRules(response, userCategoryId, userName);
            for(int index= 0; index < response.groupReports.Count; index ++)
            {
                List<ReportResponseData> reports = response.groupReports[index].report;
                for(int indexF = 0; indexF< response.favoriteReports.Count; indexF++)
                {
                    ReportResponseData tempora = reports.Find((element) => element.reportId == response.favoriteReports[indexF].reportId)?? new ReportResponseData();
                    if(!string.IsNullOrWhiteSpace(tempora.url))
                    {
                        response.favoriteReports[indexF].url = tempora.url;
                    }
                }
            }

            return response;
        }
        
        private List<UserGroup> ValidateGroupRules(ReportResponse response, int userCategoryId, string userName)
        {
            string userCriteria = GetUserCriteria(userCategoryId, userName);
            if (string.IsNullOrEmpty(userCriteria)) return response.groupReports;

            string groupToSearch = userCategoryId == (int)UserCategories.supervisor ? UserCategories.supervisor.ToString() : "estacion";
            int indexGroup = response.groupReports.FindIndex(element => element.group.Equals(groupToSearch, StringComparison.OrdinalIgnoreCase));

            if (indexGroup >= 0)
            {
                foreach (var report in response.groupReports[indexGroup].report)
                {
                    if (CanBeModify(report.url))
                    {
                        report.url = AppendCriteriaToUrl(report.url, userCriteria);
                    }
                }
            }

            return response.groupReports;
        }

        private string GetUserCriteria(int userCategoryId, string userName)
        {
            return userCategoryId switch
            {
                (int)UserCategories.supervisor => $"ZOHO_CRITERIA=%22(Cat.) Estaciones%22.%22Distrito%22%3D%27{userName}%27",
                (int)UserCategories.station => $"ZOHO_CRITERIA=%22(Cat.) Estaciones%22.%22Numero%22%3D{userName}",
                _ => string.Empty,
            };
        }

        private string AppendCriteriaToUrl(string url, string criteria)
        {
            return HasQuestionSymbol(url) ? $"{url}{criteria}" : $"{url}?{criteria}";
        }

        private bool HasQuestionSymbol(string url)
        {
            return url.EndsWith('?');
        }

        private bool CanBeModify(string url)
        {
            return url.Contains("bi.enerser.com.mx:8443");
        }

        private List<ReportResponseData> validateFavoriteReports(List<ReportResponseData> report, ReportResponse favorites)
        {
            for (int index = 0; index < report.Count; index++)
            {
                for (int index2 = 0; index2 < favorites.myReports.Count; index2++)
                {
                    if (report[index].reportId == favorites.myReports[index2].reportId)
                    {
                        report[index].isFavorite = true;
                    }
                }
            }
            return report;
        }

        public GeneralResponse setFavoriteReports(string userId, string reportId)
        {
            if (string.IsNullOrWhiteSpace(userId))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario ingresar un usuario válido"
                };
            }
            if (string.IsNullOrWhiteSpace(reportId))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario ingresar un reporte válido"
                };
            }
            return _ReportDB.setFavoriteReports(userId,reportId);
        }

        public GeneralResponse deleteFavoriteReports(string userId, string reportId)
        {
            if (string.IsNullOrWhiteSpace(userId))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario ingresar un usuario válido"
                };
            }
            if (string.IsNullOrWhiteSpace(reportId))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario ingresar un reporte válido"
                };
            }
            return _ReportDB.deleteFavoriteReports(userId, reportId);
        }

        public void saveRecord(int userId, int reportId)
        {
            _ReportDB.saveRecord(userId, reportId);
        }
    }
}
