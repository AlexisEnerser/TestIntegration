namespace enerser.analytics.JWT
{
    public static class Claims
    {
        public static int UserId(HttpContext httpContext)
        {
            var claims = httpContext.Items["Claims"] as IDictionary<string, string>;
            return int.Parse(claims?["userId"]!);
        }

        public static Tuple<string, int, string> UserInfo(HttpContext httpContext)
        {
            var claims = httpContext.Items["Claims"] as IDictionary<string, string>;
            string userId = claims?["userId"]!;
            int userCategoryId = int.TryParse(claims?["userCategoryId"]!, out int _userCategoryId) ? _userCategoryId : 0;
            string userName = claims?["username"]!;
            return Tuple.Create(userId, userCategoryId, userName);
        }
    }
}
