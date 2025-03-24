using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Surveys;

public class Selection
{
    public Guid ResponseId { get; set; }
    public Guid OptionId { get; set; }
    public Option Option { get; set; } = default!;

    internal class EntityConfiguration : IEntityTypeConfiguration<Selection>
    {
        public void Configure(EntityTypeBuilder<Selection> builder)
        {
            builder.ToTable("Selection", "Surveys");
            builder.HasKey(x => new { x.ResponseId, x.OptionId });

            builder.HasOne(x => x.Option)
                .WithMany()
                .HasForeignKey(x => x.OptionId);
        }
    }
}
