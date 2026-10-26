using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Surveys;

public class Question
{
    public Guid Id { get; set; }
    public Guid SurveyId { get; set; }
    public string Text { get; set; } = string.Empty;
    public int Order { get; set; }
    public ICollection<Option> Options { get; set; } = default!;

    internal class EntityConfiguration : IEntityTypeConfiguration<Question>
    {
        public void Configure(EntityTypeBuilder<Question> builder)
        {
            builder.ToTable("Question", "Surveys");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.SurveyId).IsRequired();
            builder.Property(x => x.Text).IsRequired();
            builder.Property(x => x.Order).IsRequired();

            builder.HasMany(x => x.Options)
                .WithOne()
                .HasForeignKey(x => x.QuestionId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
