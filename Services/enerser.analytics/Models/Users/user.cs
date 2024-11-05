using System;
using System.Data;
using System.Data.SqlClient;
using enerser.analytics.Utils;

namespace enerser.analytics.Models.Users
{
    public class User
    {
        public int id { get; set; } = new int();
        public string name { get; set; } = string.Empty;
        public string user_name { get; set; } = string.Empty;
        public int employee_number { get; set; } = new int();
        public int id_user_type { get; set; } = new int();
        public string user_type { get; set; } = string.Empty;
        public int id_status { get; set; } = new int();
        public string status { get; set; } = string.Empty;
        public string email { get; set; } = string.Empty;
        public int id_user_category { get; set; } = new int();
        public string user_category { get; set; } = string.Empty;

        public User() { }

        public User(SqlDataReader reader)
        {
            id = reader.GetValue("id_user", 0);
            user_name = reader.GetValue("username", string.Empty);
            employee_number = reader.GetValue("employee_number", 0);
            id_user_type = reader.GetValue("id_user_type", 0);
            user_type = reader.GetValue("user_type", string.Empty);
            id_status = reader.GetValue("id_status", 0);
            status = reader.GetValue("status", string.Empty);
            email = reader.GetValue("email", string.Empty);
            name = reader.GetValue("name", string.Empty);
            id_user_category = reader.GetValue("id_user_category", 0);
            user_category = reader.GetValue("user_category", string.Empty);
        }
    }
}
