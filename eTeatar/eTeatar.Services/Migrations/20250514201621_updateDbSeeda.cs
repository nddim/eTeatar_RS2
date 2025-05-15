using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class updateDbSeeda : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Slika",
                table: "Predstava",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(byte[]),
                oldType: "varbinary(2000)",
                oldMaxLength: 2000,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Slika",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(byte[]),
                oldType: "varbinary(2000)",
                oldMaxLength: 2000,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Prezime",
                table: "Glumac",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldUnicode: false,
                oldMaxLength: 255);

            migrationBuilder.AlterColumn<string>(
                name: "Ime",
                table: "Glumac",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(255)",
                oldUnicode: false,
                oldMaxLength: 255);

            migrationBuilder.AlterColumn<string>(
                name: "Biografija",
                table: "Glumac",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "varchar(500)",
                oldUnicode: false,
                oldMaxLength: 500);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 1,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 2,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 3,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 4,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 5,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 6,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 7,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 8,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 9,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 10,
                column: "Slika",
                value: null);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<byte[]>(
                name: "Slika",
                table: "Predstava",
                type: "varbinary(2000)",
                maxLength: 2000,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<byte[]>(
                name: "Slika",
                table: "Korisnik",
                type: "varbinary(2000)",
                maxLength: 2000,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Prezime",
                table: "Glumac",
                type: "varchar(255)",
                unicode: false,
                maxLength: 255,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(255)",
                oldMaxLength: 255);

            migrationBuilder.AlterColumn<string>(
                name: "Ime",
                table: "Glumac",
                type: "varchar(255)",
                unicode: false,
                maxLength: 255,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(255)",
                oldMaxLength: 255);

            migrationBuilder.AlterColumn<string>(
                name: "Biografija",
                table: "Glumac",
                type: "varchar(500)",
                unicode: false,
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(500)",
                oldMaxLength: 500);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 1,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 2,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 3,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 4,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 5,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 6,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 7,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 8,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 9,
                column: "Slika",
                value: null);

            migrationBuilder.UpdateData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 10,
                column: "Slika",
                value: null);
        }
    }
}
