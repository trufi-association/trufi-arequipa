namespace OTP_Updater.Util;

public class ShapeData
{
    public string ShapeId { get; set; } = string.Empty;
    public string RouteId { get; set; } = string.Empty;
    public (float, float, int)[] Points { get; set; } = [];
}
