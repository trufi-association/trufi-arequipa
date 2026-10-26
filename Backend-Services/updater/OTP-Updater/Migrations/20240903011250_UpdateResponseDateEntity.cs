using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class UpdateResponseDateEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Date",
                schema: "Surveys",
                table: "Response",
                newName: "CreatedOn");

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedOn",
                schema: "Surveys",
                table: "Response",
                type: "timestamp with time zone",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UpdatedOn",
                schema: "Surveys",
                table: "Response");

            migrationBuilder.RenameColumn(
                name: "CreatedOn",
                schema: "Surveys",
                table: "Response",
                newName: "Date");
        }
    }
}
