using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using enerser.analytics.Models.Users;

namespace enerser.analytics.JWT
{
    public class JwtService
    {
        private readonly string _secretKey;
        private readonly string _issuer;

        public JwtService(string secretKey, string issuer)
        {
            _secretKey = secretKey;
            _issuer = issuer;
        }

        public string GenerateToken(UserInfoResponseData data, int expireMinutes = 240)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_secretKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                new Claim("userId", data.userId.ToString()),
                new Claim("username", data.username),
                new Claim("name", data.name),
                new Claim("userType", data.userType),
                new Claim("email", data.email),
                new Claim("businessId", data.businessId.ToString()),
                new Claim("business", data.business),
                new Claim("status", data.status),
                new Claim("mobileAccess", data.mobileAccess),
                new Claim("userCategoryId", data.userCategoryId.ToString()),
                new Claim("userCategory", data.userCategory),
            }),
                Expires = DateTime.UtcNow.AddMinutes(expireMinutes),
                Issuer = _issuer,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
