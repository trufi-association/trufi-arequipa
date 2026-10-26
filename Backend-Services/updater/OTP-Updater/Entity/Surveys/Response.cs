using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using OTP_Updater.Controllers;

namespace OTP_Updater.Entity.Surveys;

public class Response(Guid userId, Guid questionId)
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; } = userId;
    public Guid QuestionId { get; set; } = questionId;
    public DateTime CreatedOn { get; set; }
    public DateTime? UpdatedOn { get; set; }
    public Question Question { get; set; } = default!;
    public ICollection<Selection> SelectedOptions { get; set; } = default!;

    public Response(ResponseModel model) : this(model.UserId, model.QuestionId)
    {
        SelectedOptions = [];
        CreatedOn = DateTime.UtcNow;
    }

    public void Update(ResponseModel model)
    {
        SelectedOptions.Clear();
        SelectedOptions = model.Options.Select(x => new Selection()
        {
            ResponseId = Id,
            OptionId = x
        }).ToList();

        UpdatedOn = DateTime.UtcNow;
    }

    internal class EntityConfiguration : IEntityTypeConfiguration<Response>
    {
        public void Configure(EntityTypeBuilder<Response> builder)
        {
            builder.ToTable("Response", "Surveys");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.UserId).IsRequired();
            builder.Property(x => x.CreatedOn).IsRequired();
            builder.Property(x => x.UpdatedOn).IsRequired(false).HasDefaultValue(null);

            builder.HasOne(x => x.Question)
                .WithMany()
                .HasForeignKey(x => x.QuestionId)
                .OnDelete(DeleteBehavior.NoAction);


            builder.HasMany(x => x.SelectedOptions)
                .WithOne()
                .HasForeignKey(x => x.ResponseId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
