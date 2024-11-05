using System.Text.RegularExpressions;

namespace enerser.analytics.Utils
{
    public static class EmailValidator
    {
        private static readonly Regex EmailRegex = new Regex(
            @"^[^@\s]+@[^@\s]+\.[^@\s]+$"
            , RegexOptions.Compiled | RegexOptions.IgnoreCase | RegexOptions.ExplicitCapture
            , TimeSpan.FromMilliseconds(100)
        );

        public static bool IsValidEmail(this string email)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                return false;
            }

            return EmailRegex.IsMatch(email);
        }
    }
}
