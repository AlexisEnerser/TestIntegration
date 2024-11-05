using enerser.analytics.DataBase;
using enerser.analytics.Models;
using enerser.analytics.Models.Group;
using enerser.analytics.Models.Report;
using enerser.analytics.Models.Users;

namespace enerser.analytics.Services
{
    public class GroupServices
    {
        private readonly GroupDB _GroupDB;
        public GroupServices(IConfiguration configuration, GroupDB GroupDB)
        {
            _GroupDB = GroupDB;
        }

        public GeneralResponse createGroup(Group data, int userId)
        {
            if (string.IsNullOrWhiteSpace(data.name))
            {
                return new GeneralResponse()
                {
                    code = -1,
                    message = "Es necesario enviar un nombre del grupo"
                };
            }
            return _GroupDB.createGroup(data, userId);
        }

        public GeneralResponse updateGroup(Group data, int userId)
        {
            return _GroupDB.updateGroup(data, userId);
        }

        public GeneralResponse<List<Group>> consultAllGroups(int userId)
        {
            return _GroupDB.consultAllGroups(userId);
        }

        public GeneralResponse<List<ReportResponseData>> consultGroupReports(int groupId)
        {
            return _GroupDB.consultGroupReports(groupId);
        }

        public GeneralResponse<List<ReportResponseData>> consultGroupNoReports(int groupId)
        {
            return _GroupDB.consultGroupNoReports(groupId);
        }

        public GeneralResponse editGroupReports(AddGroupReportRequest data)
        {
            GeneralResponse response = _GroupDB.clearReports(data.id);
            if (response.code < 0)
            {
                return response;
            }

            foreach(int item in data.reports)
            {
                _GroupDB.addReport(data.id, item);
            }

            return response;
        }

        public GeneralResponse<List<User>> consultGroupUsers(int groupId)
        {
            return _GroupDB.consultGroupUsers(groupId);
        }

        public GeneralResponse<List<User>> consultGroupNoUsers(int groupId)
        {
            return _GroupDB.consultGroupNoUsers(groupId);
        }

        public GeneralResponse editGroupUsers(AddGroupReportRequest data)
        {
            GeneralResponse response = _GroupDB.clearUsers(data.id);
            if (response.code < 0)
            {
                return response;
            }

            foreach (int item in data.reports)
            {
                _GroupDB.addUser(data.id, item);
            }

            return response;
        }    
    }
}
