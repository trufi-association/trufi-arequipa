using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.RealTime;

public class VehicleRoute
{
    public Guid Id { get; set; }
    public string GtfsId { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public ICollection<VehicleStopTime> StopTimes { get; set; } = default!;

    internal class EntityConfiguration : IEntityTypeConfiguration<VehicleRoute>
    {
        public void Configure(EntityTypeBuilder<VehicleRoute> builder)
        {
            builder.ToTable("VehicleRoute", "Positions");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.GtfsId).IsRequired();
            builder.Property(x => x.Name).IsRequired();

            builder.HasMany(x => x.StopTimes)
                .WithOne()
                .HasForeignKey(x => x.RouteId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
