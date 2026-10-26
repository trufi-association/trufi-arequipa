using OTP_Updater.Controllers;
using OTP_Updater.Entity.Profile;

namespace OTP_Updater.Profile;

public interface IUserManager
{
    Task<string?> Authenticate(LoginModel model);
    Task<Admin> CreateAdmin(string userName, string password);
    string CreatePasswordHash(string userName, string password);
    bool VerifyPasswordHash(string userName, string hashedPassword, string confirmPassword);
}