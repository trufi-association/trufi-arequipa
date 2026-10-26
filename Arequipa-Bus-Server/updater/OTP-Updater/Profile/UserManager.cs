using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using OTP_Updater.Controllers;
using OTP_Updater.Data;
using OTP_Updater.Entity.Profile;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace OTP_Updater.Profile;

public class UserManager(ApplicationContext db, IConfiguration configuration) : IUserManager
{
    public async Task<string?> Authenticate(LoginModel model)
    {
        var admin = await db.Administrators.SingleOrDefaultAsync(x => x.UserName == model.Username);

        if (admin is null)
        {
            return null;
        }

        if (VerifyPasswordHash(admin.UserName, admin.PasswordHash, model.Password))
        {
            return GenerateJwtToken(admin.Id);
        }

        return null;
    }

    public string CreatePasswordHash(string userName, string password)
    {
        var passwordHasher = new PasswordHasher<string>();
        var hashedPassword = passwordHasher.HashPassword(userName, password);

        return hashedPassword;
    }

    public async Task<Admin> CreateAdmin(string userName, string password)
    {
        var admin = new Admin()
        {
            Id = Guid.NewGuid(),
            UserName = userName,
            PasswordHash = CreatePasswordHash(userName, password)
        };

        db.Administrators.Add(admin);

        await db.SaveChangesAsync();

        return admin;
    }

    public bool VerifyPasswordHash(string userName, string hashedPassword, string confirmPassword)
    {
        var passwordHasher = new PasswordHasher<string>();
        var result = passwordHasher.VerifyHashedPassword(userName, hashedPassword, confirmPassword);
        return result == PasswordVerificationResult.Success || result == PasswordVerificationResult.SuccessRehashNeeded;
    }

    private string GenerateJwtToken(Guid id)
    {
        var jwtSettings = configuration.GetSection("JwtSettings");
        var keyBytes = Encoding.ASCII.GetBytes(jwtSettings.GetValue<string>("Key") ?? string.Empty);
        var key = new SymmetricSecurityKey(keyBytes);
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, id.ToString()),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

        var token = new JwtSecurityToken(
            issuer: jwtSettings.GetValue<string>("Issuer"),
            audience: jwtSettings.GetValue<string>("Audience"),
            claims: claims,
            expires: DateTime.Now.AddMinutes(Convert.ToDouble(jwtSettings.GetValue<string>("ExpireMinutes"))),
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
