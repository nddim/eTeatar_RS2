using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class izmjenaPlacanje : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FKStavkaUpla569574",
                table: "StavkaUplate");

            migrationBuilder.DropTable(
                name: "Hrana");

            migrationBuilder.DropIndex(
                name: "IX_StavkaUplate_HranaId",
                table: "StavkaUplate");

            migrationBuilder.DropColumn(
                name: "HranaId",
                table: "StavkaUplate");

            migrationBuilder.DropColumn(
                name: "TrajanjeKraj",
                table: "Predstava");

            migrationBuilder.DropColumn(
                name: "TrajanjePocetak",
                table: "Predstava");

            migrationBuilder.AddColumn<string>(
                name: "NacinPlacanja",
                table: "Uplata",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Status",
                table: "Uplata",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TransakcijaId",
                table: "Uplata",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Trajanje",
                table: "Predstava",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "ukljucenaHrana",
                table: "Karta",
                type: "bit",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NacinPlacanja",
                table: "Uplata");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "Uplata");

            migrationBuilder.DropColumn(
                name: "TransakcijaId",
                table: "Uplata");

            migrationBuilder.DropColumn(
                name: "Trajanje",
                table: "Predstava");

            migrationBuilder.DropColumn(
                name: "ukljucenaHrana",
                table: "Karta");

            migrationBuilder.AddColumn<int>(
                name: "HranaId",
                table: "StavkaUplate",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "TrajanjeKraj",
                table: "Predstava",
                type: "datetime",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "TrajanjePocetak",
                table: "Predstava",
                type: "datetime",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.CreateTable(
                name: "Hrana",
                columns: table => new
                {
                    HranaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Hrana__19AD0AEA4B1C6010", x => x.HranaId);
                });

            migrationBuilder.CreateIndex(
                name: "IX_StavkaUplate_HranaId",
                table: "StavkaUplate",
                column: "HranaId");

            migrationBuilder.AddForeignKey(
                name: "FKStavkaUpla569574",
                table: "StavkaUplate",
                column: "HranaId",
                principalTable: "Hrana",
                principalColumn: "HranaId");
        }
    }
}
