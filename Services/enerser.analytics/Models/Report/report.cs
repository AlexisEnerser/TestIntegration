namespace enerser.analytics.Models.Report
{
    public class Report
    {
        public int id { get; set; } = new int();
        public string  name { get; set; } = string.Empty;
        public string  url { get; set; } = string.Empty;
        public int report_type_id { get; set; } = new int();
        public string report_type { get; set; } = string.Empty;
        public int status_id { get; set; } = new int();
        public string status { get; set; } = string.Empty;
    }
}
