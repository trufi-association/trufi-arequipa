using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Surveys;

public class Survey
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string IntroductionText { get; set; } = string.Empty;
    public string ConclusionText { get; set; } = string.Empty;
    public ICollection<Question> Questions { get; set; } = default!;

    internal class EntityConfiguration : IEntityTypeConfiguration<Survey>
    {
        public void Configure(EntityTypeBuilder<Survey> builder)
        {
            builder.ToTable("Survey", "Surveys");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).IsRequired();
            builder.Property(x => x.Description).IsRequired();
            builder.Property(x => x.IntroductionText).IsRequired();
            builder.Property(x => x.ConclusionText).IsRequired();

            builder.HasMany(x => x.Questions)
                .WithOne()
                .HasForeignKey(x => x.SurveyId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
