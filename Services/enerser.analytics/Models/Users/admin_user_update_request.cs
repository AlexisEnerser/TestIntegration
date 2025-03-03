﻿namespace enerser.analytics.Models.Users
{
    public class AdminUserUpdateRequest
    {
        public int id { get; set; } = new int();
        public string name { get; set; } = string.Empty;
        public string password { get; set; } = string.Empty;
        public int employee_number { get; set; } = new int();
        public int id_user_type { get; set; } = new int();
        public int id_status { get; set; } = new int();
        public string email { get; set; } = string.Empty;
        public int id_user_category { get; set; } = new int();
    }
}
