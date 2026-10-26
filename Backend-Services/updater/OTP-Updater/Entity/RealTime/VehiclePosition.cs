using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace OTP_Updater.Entity.RealTime;

public class VehiclePosition()
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Cod { get; set; } = default!;
    public long Hora { get; set; } = default!;
    public string Ruta { get; set; } = default!;
    public float Lat { get; set; } = default!;
    public float Lng { get; set; } = default!;
    public int Vel { get; set; } = default!;
    public int Ang { get; set; } = default!;
    public int Estado { get; set; } = default!;
    public int Sent { get; set; } = default!;
    public DateTime CreatedOn { get; set; } = default!;

    public VehiclePosition(Model.Route model) : this()
    {
        Update(model);
    }

    public void Update(Model.Route model)
    {
        Cod = model.Cod;
        Hora = model.Hora;
        Ruta = model.Ruta;
        Lat = model.Lat;
        Lng = model.Lng;
        Vel = model.Vel;
        Ang = model.Ang;
        Estado = model.Estado;
        Sent = model.Sent;
    }

    internal class EntityConfiguration : IEntityTypeConfiguration<VehiclePosition>
    {
        public void Configure(EntityTypeBuilder<VehiclePosition> builder)
        {
            builder.ToTable("Vehicle", "Positions");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.CreatedOn).HasDefaultValueSql("(now())");

            builder.HasIndex(x => x.Cod).HasDatabaseName("idx_vehicle_cod");
        }
    }
}
