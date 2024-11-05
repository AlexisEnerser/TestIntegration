namespace enerser.analytics.Models.Group
{
    public class AddGroupReportRequest
    {
        public int id { get; set; } = new int();
        public List<int> reports { get; set; } = new List<int>();
    }
}
