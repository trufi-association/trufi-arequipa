using Microsoft.EntityFrameworkCore;

namespace Microsoft.AspNetCore.Hosting;

public static class EFCoreHostExtensions
{
    public static async Task<bool> MigrateDatabase<TContext>(this IHost host)
        where TContext : DbContext
    {
        using var scope = host.Services.CreateScope();
        var logger = scope.ServiceProvider.GetRequiredService<ILoggerFactory>().CreateLogger(nameof(EFCoreHostExtensions));

        try
        {
            logger.LogInformation("Attempting to migrate the database for {Context}...", typeof(TContext).FullName);
            var db = scope.ServiceProvider.GetRequiredService<TContext>();

            var pendingMigrations = await db.Database.GetPendingMigrationsAsync();
            if (!pendingMigrations.Any())
            {
                return false;
            }

            await db.Database.MigrateAsync();
            return true;
        }
        catch (Exception ex)
        {
            logger.LogCritical(ex, "Failed to migrate the database for {Context}!", typeof(TContext).FullName);
            throw;
        }
    }
}
