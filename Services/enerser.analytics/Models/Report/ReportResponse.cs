using enerser.analytics.Utils;
using System.Data.SqlClient;

namespace enerser.analytics.Models.Report
{
    public class ReportResponse : GeneralResponse
    {
        public List<ReportResponseData> myReports { get; set; } = new List<ReportResponseData>();
        public List<ReportResponseData> favoriteReports { get; set; } = new List<ReportResponseData>();
        public List<UserGroup> groupReports { get; set; } = new List<UserGroup>();
    }

    public class UserGroup
    {
        public int groupId { get; set; } = new int();
        public string group { get; set; } = string.Empty;
        public List<ReportResponseData> report { get; set; } = new List<ReportResponseData>();
    }

    public class ReportResponseData
    {
        public int reportId { get; set; } = new int();
        public string name { get; set; } = string.Empty;
        public string url { get; set; } = string.Empty;
        public int reportTypeId { get; set; } = new int();
        public string reportType { get; set; } = string.Empty;
        public bool isFavorite { get; set; } = new bool();

        public ReportResponseData() { }

        public ReportResponseData(SqlDataReader reader)
        {
            name = reader.GetValue("report_name", string.Empty);
            reportId = reader.GetValue("id_report", 0);
            reportType = reader.GetValue("reportType", string.Empty);
            reportTypeId = reader.GetValue("id_report_type", 0);
            url = reader.GetValue("report_access_url", string.Empty);
        }
    }
}
