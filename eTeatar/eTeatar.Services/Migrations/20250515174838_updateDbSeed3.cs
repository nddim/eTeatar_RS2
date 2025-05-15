using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class updateDbSeed3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminId", "Datum", "DvoranaId", "IsDeleted", "PredstavaId", "Status", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 81, new DateTime(2025, 5, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 1, "Neaktivan", null },
                    { 82, new DateTime(2025, 4, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 2, "Neaktivan", null },
                    { 83, new DateTime(2025, 5, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 3, "Neaktivan", null },
                    { 84, new DateTime(2025, 4, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 4, "Neaktivan", null },
                    { 85, new DateTime(2025, 5, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 5, "Neaktivan", null },
                    { 86, new DateTime(2025, 4, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 1, "Neaktivan", null },
                    { 87, new DateTime(2025, 5, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 2, "Neaktivan", null },
                    { 88, new DateTime(2025, 4, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 4, "Neaktivan", null },
                    { 89, new DateTime(2025, 5, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 9, "Neaktivan", null }
                });

            migrationBuilder.InsertData(
                table: "Karta",
                columns: new[] { "KartaId", "Cijena", "IsDeleted", "KorisnikId", "RezervacijaId", "SjedisteId", "TerminId", "VrijemeBrisanja", "ukljucenaHrana" },
                values: new object[,]
                {
                    { 7, 10m, false, 2, null, 90, 81, null, true },
                    { 8, 10m, false, 2, null, 15, 82, null, true },
                    { 9, 10m, false, 2, null, 60, 83, null, true },
                    { 10, 10m, false, 2, null, 100, 84, null, true },
                    { 11, 10m, false, 2, null, 11, 85, null, true },
                    { 12, 10m, false, 2, null, 70, 86, null, true },
                    { 13, 10m, false, 2, null, 99, 87, null, true },
                    { 14, 10m, false, 2, null, 25, 88, null, true },
                    { 15, 10m, false, 2, null, 75, 89, null, true }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 81);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 82);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 83);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 84);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 85);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 86);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 87);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 88);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 89);
        }
    }
}
