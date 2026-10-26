namespace OTP_Updater.Model;

public class Route
{
    public string Cod { get; set; } = default!;
    public long Hora { get; set; } = default!;
    public string Ruta { get; set; } = default!;
    public float Lat { get; set; } = default!;
    public float Lng { get; set; } = default!;
    public int Vel { get; set; } = default!;
    public int Ang { get; set; } = default!;
    public int Estado { get; set; } = default!;
    public int Sent { get; set; } = default!;
}
