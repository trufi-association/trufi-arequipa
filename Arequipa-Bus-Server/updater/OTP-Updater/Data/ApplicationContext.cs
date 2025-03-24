using Microsoft.EntityFrameworkCore;
using OTP_Updater.Entity.Profile;
using OTP_Updater.Entity.RealTime;
using OTP_Updater.Entity.Surveys;

namespace OTP_Updater.Data;

public class ApplicationContext(DbContextOptions<ApplicationContext> options) : DbContext(options)
{
    public DbSet<VehiclePosition> Positions { get; set; } = default!;
    public DbSet<Survey> Surveys { get; set; } = default!;
    public DbSet<User> Users { get; set; } = default!;
    public DbSet<Question> Questions { get; set; } = default!;
    public DbSet<Option> Options { get; set; } = default!;
    public DbSet<Response> Responses { get; set; } = default!;
    public DbSet<Admin> Administrators { get; set; } = default!;
    public override async Task<int> SaveChangesAsync(bool acceptAllChangesOnSuccess, CancellationToken cancellationToken = default)
    {
        return await base.SaveChangesAsync(acceptAllChangesOnSuccess, cancellationToken);
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.ApplyConfigurationsFromAssembly(GetType().Assembly);
    }
}
