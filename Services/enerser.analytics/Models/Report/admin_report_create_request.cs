namespace enerser.analytics.Models.Report
{
    public class AdminReportCreateRequest
    {
        public string name { get; set; } = string.Empty;
        public string url { get; set; } = string.Empty;
        public int report_type_id { get; set; } = new int();
    }
}
