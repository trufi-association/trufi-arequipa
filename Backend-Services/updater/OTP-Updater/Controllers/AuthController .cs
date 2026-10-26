using Microsoft.AspNetCore.Mvc;
using OTP_Updater.Profile;

namespace OTP_Updater.Controllers;

[ApiController]
[Route("[controller]")]
public class AuthController(IUserManager userManager) : ControllerBase
{
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginModel model)
    {
        var token = await userManager.Authenticate(model);

        if (token is null)
        {
            return Unauthorized();
        }

        return Ok(new { token });
    }
}

public class LoginModel
{
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}