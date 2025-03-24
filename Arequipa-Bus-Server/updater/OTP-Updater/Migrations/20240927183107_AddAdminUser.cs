using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class AddAdminUser : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Response_User_UserId",
                schema: "Surveys",
                table: "Response");

            migrationBuilder.EnsureSchema(
                name: "Profiles");

            migrationBuilder.CreateTable(
                name: "Admin",
                schema: "Profiles",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserName = table.Column<string>(type: "text", nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: false),
                    FirstName = table.Column<string>(type: "text", nullable: false),
                    LastName = table.Column<string>(type: "text", nullable: false),
                    IsLocked = table.Column<bool>(type: "boolean", nullable: false),
                    Role = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Admin", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Response_QuestionId",
                schema: "Surveys",
                table: "Response",
                column: "QuestionId");

            migrationBuilder.CreateIndex(
                name: "IX_UserName",
                schema: "Profiles",
                table: "Admin",
                column: "UserName");

            migrationBuilder.AddForeignKey(
                name: "FK_Response_Question_QuestionId",
                schema: "Surveys",
                table: "Response",
                column: "QuestionId",
                principalSchema: "Surveys",
                principalTable: "Question",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Response_User_UserId",
                schema: "Surveys",
                table: "Response",
                column: "UserId",
                principalSchema: "Surveys",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Response_Question_QuestionId",
                schema: "Surveys",
                table: "Response");

            migrationBuilder.DropForeignKey(
                name: "FK_Response_User_UserId",
                schema: "Surveys",
                table: "Response");

            migrationBuilder.DropTable(
                name: "Admin",
                schema: "Profiles");

            migrationBuilder.DropIndex(
                name: "IX_Response_QuestionId",
                schema: "Surveys",
                table: "Response");

            migrationBuilder.AddForeignKey(
                name: "FK_Response_User_UserId",
                schema: "Surveys",
                table: "Response",
                column: "UserId",
                principalSchema: "Surveys",
                principalTable: "User",
                principalColumn: "Id");
        }
    }
}
