using System.Security.Cryptography;
using System.Text;

namespace enerser.analytics.Utils
{
    public static class PasswordsExtensions
    {
        private static readonly string LowerCase = "abcdefghijklmnopqrstuvwxyz";
        private static readonly string UpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        private static readonly string Digits = "0123456789";
        private static readonly string SpecialChars = "!@#$%^&*()-_=+";
        public static string HashPassword(this string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashValue = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(hashValue).Replace("-", "");
            }
        }

        public static bool VerifyPassword(this string storedHash, string passwordToCheck)
        {
            return HashPassword(passwordToCheck) == storedHash;
        }

        public static string GeneratePassword(this string _,int length)
        {
            if (length < 4)
            {
                throw new ArgumentException("Length must be at least 4 to include all character types.");
            }
            string allChars = LowerCase + UpperCase + Digits + SpecialChars;
            var password = new char[length];
            var randomBytes = new byte[length];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(randomBytes);
            }
            password[0] = UpperCase[randomBytes[0] % UpperCase.Length];
            password[1] = LowerCase[randomBytes[1] % LowerCase.Length];
            password[2] = Digits[randomBytes[2] % Digits.Length];
            password[3] = SpecialChars[randomBytes[3] % SpecialChars.Length];
            for (int i = 4; i < length; i++)
            {
                password[i] = allChars[randomBytes[i] % allChars.Length];
            }
            return new string(password.OrderBy(x => randomBytes[RandomNumberGenerator.GetInt32(length)]).ToArray());
        }
    }
}
