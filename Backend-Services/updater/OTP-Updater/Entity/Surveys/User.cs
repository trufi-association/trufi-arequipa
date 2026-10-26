using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Surveys;

public class User(Guid id)
{
    public Guid Id { get; set; } = id;
    public string Name { get; set; } = string.Empty;
    public int? Age { get; set; }
    public ICollection<Response> Responses { get; set; } = [];

    internal class EntityConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable("User", "Surveys");
            builder.HasKey(x => x.Id);

            builder.HasMany(x => x.Responses)
                .WithOne()
                .HasForeignKey(x => x.UserId);
        }
    }
}
