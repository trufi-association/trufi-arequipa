using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.Surveys;

public class Option
{
    public Guid Id { get; set; }
    public Guid QuestionId { get; set; }
    public string Text { get; set; } = string.Empty;
    public int Order { get; set; }

    internal class EntityConfiguration : IEntityTypeConfiguration<Option>
    {
        public void Configure(EntityTypeBuilder<Option> builder)
        {
            builder.ToTable("Option", "Surveys");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.QuestionId).IsRequired();
            builder.Property(x => x.Text).IsRequired();
            builder.Property(x => x.Order).IsRequired();
        }
    }
}
