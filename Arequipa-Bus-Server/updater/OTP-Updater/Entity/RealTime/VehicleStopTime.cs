using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.RealTime;

public class VehicleStopTime
{
    public Guid Id { get; set; }
    public Guid RouteId { get; set; }
    public float Lat { get; set; }
    public float Lon { get; set; }
    public int Sequence { get; set; }
    public DateTime ArrivalTime { get; set; }
    public DateTime DepartureTime { get; set; }
    public VehicleRoute Route { get; set; } = default!;

    internal class EntityConfiguration : IEntityTypeConfiguration<VehicleStopTime>
    {
        public void Configure(EntityTypeBuilder<VehicleStopTime> builder)
        {
            builder.ToTable("VehicleStopTime", "Positions");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.RouteId).IsRequired();
            builder.Property(x => x.Lat).IsRequired();
            builder.Property(x => x.Lon).IsRequired();
            builder.Property(x => x.Sequence).IsRequired();
            builder.Property(x => x.ArrivalTime).IsRequired();
            builder.Property(x => x.DepartureTime).IsRequired();

            builder.HasOne(x => x.Route)
                .WithMany(x => x.StopTimes)
                .HasForeignKey(x => x.RouteId)
                .OnDelete(DeleteBehavior.NoAction);

            builder.HasIndex(x => new { x.RouteId, x.Sequence }).HasDatabaseName("idx_RouteId_Sequence");
        }
    }
}
