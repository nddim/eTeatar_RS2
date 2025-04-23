using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class dodanaStateMachineRezervacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Rezervacija",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Rezervacija");
        }
    }
}
