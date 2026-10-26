using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Profile;

public class Admin
{
    public Guid Id { get; set; }
    public string UserName { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public bool IsLocked { get; set; } = false;
    public AdminRole Role { get; set; }
    internal class EntityConfiguration : IEntityTypeConfiguration<Admin>
    {
        public void Configure(EntityTypeBuilder<Admin> builder)
        {
            builder.ToTable("Admin", "Profiles");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Role).HasConversion<string>();

            builder.HasIndex(x => x.UserName).HasDatabaseName("IX_UserName");
        }
    }
}

public enum AdminRole
{
    Survey
}