using FluentValidation;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using OTP_Updater.Data;
using OTP_Updater.Profile;
using System.Text;

namespace OTP_Updater;

public class Startup(IConfiguration configuration, IWebHostEnvironment env)
{
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddHttpContextAccessor();

        services.AddDbContext<ApplicationContext>(options =>
        {
            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection"));
        });

        services.AddValidatorsFromAssemblyContaining<WebAssemblyMarker>();

        services.AddHealthChecks().AddDbContextCheck<ApplicationContext>();

        var jwtSettings = configuration.GetSection("JwtSettings");
        var key = Encoding.ASCII.GetBytes(jwtSettings.GetValue<string>("Key") ?? string.Empty);

        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(key),
                ValidateIssuer = true,
                ValidIssuer = jwtSettings.GetValue<string>("Issuer"),
                ValidateAudience = false
            };
        });

        services.AddControllers();
        services.AddScoped<IUserManager, UserManager>();

        services.AddSwaggerGen(c =>
        {
            c.CustomSchemaIds(type => type.FullName);
        });
    }

    public void Configure(IApplicationBuilder app, ILogger<Startup> logger)
    {
        logger.LogInformation("Current Environment: {Environment}", env.EnvironmentName);

        if (env.IsDevelopment() || env.IsStaging())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
            app.UseDeveloperExceptionPage();
        }
        else
        {
            app.UseHsts();
        }

        app.UseHttpsRedirection();
        app.UseCors();
        app.UseRouting();

        app.UseAuthentication();
        app.UseAuthorization();

        app.UseEndpoints(x =>
        {
            x.MapHealthChecks("/health");
            x.MapControllers();
        });
    }
}
