using Newtonsoft.Json;

namespace enerser.analytics.Models.Users
{
    public class UserInfoResponseData
    {
        public int userId { get; set; } = new int();
        public int userCategoryId { get; set; } = new int();
        public string username { get; set; } = string.Empty;
        public string name { get; set; } = string.Empty;
        public string userCategory { get; set; } = string.Empty;
        [JsonIgnore]
        public string password { get; set; } = string.Empty;
        public string userType { get; set; } = string.Empty;
        public string email { get; set; } = string.Empty;
        public int businessId { get; set; } = new int();
        public string business { get; set; } = string.Empty;
        public string status { get; set; } = string.Empty;
        public string mobileAccess { get; set; } = string.Empty;
    }

}
