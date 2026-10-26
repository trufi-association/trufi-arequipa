using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class AddSurveyDataEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Surveys");

            migrationBuilder.CreateTable(
                name: "Survey",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: false),
                    IntroductionText = table.Column<string>(type: "text", nullable: false),
                    ConclusionText = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Survey", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "User",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Age = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "VehicleRoute",
                schema: "Positions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    GtfsId = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleRoute", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Question",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SurveyId = table.Column<Guid>(type: "uuid", nullable: false),
                    Text = table.Column<string>(type: "text", nullable: false),
                    Order = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Question", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Question_Survey_SurveyId",
                        column: x => x.SurveyId,
                        principalSchema: "Surveys",
                        principalTable: "Survey",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Response",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Response", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Response_User_UserId",
                        column: x => x.UserId,
                        principalSchema: "Surveys",
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "VehicleStopTime",
                schema: "Positions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    RouteId = table.Column<Guid>(type: "uuid", nullable: false),
                    Lat = table.Column<float>(type: "real", nullable: false),
                    Lon = table.Column<float>(type: "real", nullable: false),
                    Sequence = table.Column<int>(type: "integer", nullable: false),
                    ArrivalTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DepartureTime = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleStopTime", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VehicleStopTime_VehicleRoute_RouteId",
                        column: x => x.RouteId,
                        principalSchema: "Positions",
                        principalTable: "VehicleRoute",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Option",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    QuestionId = table.Column<Guid>(type: "uuid", nullable: false),
                    Text = table.Column<string>(type: "text", nullable: false),
                    Order = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Option", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Option_Question_QuestionId",
                        column: x => x.QuestionId,
                        principalSchema: "Surveys",
                        principalTable: "Question",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Selection",
                schema: "Surveys",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ResponseId = table.Column<Guid>(type: "uuid", nullable: false),
                    OptionId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Selection", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Selection_Option_OptionId",
                        column: x => x.OptionId,
                        principalSchema: "Surveys",
                        principalTable: "Option",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Selection_Response_ResponseId",
                        column: x => x.ResponseId,
                        principalSchema: "Surveys",
                        principalTable: "Response",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Option_QuestionId",
                schema: "Surveys",
                table: "Option",
                column: "QuestionId");

            migrationBuilder.CreateIndex(
                name: "IX_Question_SurveyId",
                schema: "Surveys",
                table: "Question",
                column: "SurveyId");

            migrationBuilder.CreateIndex(
                name: "IX_Response_UserId",
                schema: "Surveys",
                table: "Response",
                column: "UserId");

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

            migrationBuilder.CreateIndex(
                name: "idx_RouteId_Sequence",
                schema: "Positions",
                table: "VehicleStopTime",
                columns: new[] { "RouteId", "Sequence" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Selection",
                schema: "Surveys");

            migrationBuilder.DropTable(
                name: "VehicleStopTime",
                schema: "Positions");

            migrationBuilder.DropTable(
                name: "Option",
                schema: "Surveys");

            migrationBuilder.DropTable(
                name: "Response",
                schema: "Surveys");

            migrationBuilder.DropTable(
                name: "VehicleRoute",
                schema: "Positions");

            migrationBuilder.DropTable(
                name: "Question",
                schema: "Surveys");

            migrationBuilder.DropTable(
                name: "User",
                schema: "Surveys");

            migrationBuilder.DropTable(
                name: "Survey",
                schema: "Surveys");
        }
    }
}
