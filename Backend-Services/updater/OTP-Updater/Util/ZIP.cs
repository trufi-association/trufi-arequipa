using System.IO.Compression;

namespace OTP_Updater.Util;

public class ZIP
{
    public static readonly string CONTENT_TYPE = "application/zip";
    public static Stream Create((string, Stream)[] archivableFiles)
    {
        var zipStream = new MemoryStream();

        using (var zipArchive = new ZipArchive(zipStream, ZipArchiveMode.Create, true))
        {
            foreach (var archive in archivableFiles)
            {
                var zipEntry = zipArchive.CreateEntry(archive.Item1, CompressionLevel.Optimal);
                using (var entryStream = zipEntry.Open())
                {
                    archive.Item2.CopyTo(entryStream);
                }
            }
        }

        zipStream.Seek(0, SeekOrigin.Begin);

        return new MemoryStream(zipStream.ToArray());
    }
}
