using OTP_Updater.Data;

namespace OTP_Updater;

public class Program
{
    public static async Task Main(string[] args)
    {
        Console.WriteLine("Starting WebAPI...");

        var host = CreateHostBuilder(args).Build();

        await host.MigrateDatabase<ApplicationContext>();

        await host.RunAsync();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .UseDefaultServiceProvider((context, options) =>
            {
                options.ValidateOnBuild = false;
            })
            .ConfigureWebHostDefaults(webBuilder => webBuilder
            .UseStartup<Startup>());
}