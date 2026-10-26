using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class AddAdminUserSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Admin",
                columns: ["Id", "UserName", "FirstName", "LastName", "PasswordHash", "IsLocked", "Role"],
                schema: "Profiles",
                values: new object[,] {
                    {
                        Guid.Parse("ae8c2ee2-b0ee-4153-8e04-9acda8fc001c"),
                        "Admin0432",
                        "",
                        "",
                        "AQAAAAIAAYagAAAAEC0uVw0xkGk+hKFXR5gZCFPmvtgAoHwYwS3EMBbv9kVkd5sbO7AozlqfnDo52UtVvw==",
                        false,
                        "Survey"
                    },
                });

        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
