using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSelectionEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Selection_Option_OptionId",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Selection",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropIndex(
                name: "IX_Selection_OptionId",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropIndex(
                name: "IX_Selection_ResponseId",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropColumn(
                name: "Id",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Selection",
                schema: "Surveys",
                table: "Selection",
                columns: new[] { "ResponseId", "OptionId" });

            migrationBuilder.CreateIndex(
                name: "IX_Selection_OptionId",
                schema: "Surveys",
                table: "Selection",
                column: "OptionId");

            migrationBuilder.AddForeignKey(
                name: "FK_Selection_Option_OptionId",
                schema: "Surveys",
                table: "Selection",
                column: "OptionId",
                principalSchema: "Surveys",
                principalTable: "Option",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Selection_Option_OptionId",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Selection",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.DropIndex(
                name: "IX_Selection_OptionId",
                schema: "Surveys",
                table: "Selection");

            migrationBuilder.AddColumn<Guid>(
                name: "Id",
                schema: "Surveys",
                table: "Selection",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Selection",
                schema: "Surveys",
                table: "Selection",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Selection_OptionId",
                schema: "Surveys",
                table: "Selection",
                column: "OptionId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Selection_ResponseId",
                schema: "Surveys",
                table: "Selection",
                column: "ResponseId");

            migrationBuilder.AddForeignKey(
                name: "FK_Selection_Option_OptionId",
                schema: "Surveys",
                table: "Selection",
                column: "OptionId",
                principalSchema: "Surveys",
                principalTable: "Option",
                principalColumn: "Id");
        }
    }
}
