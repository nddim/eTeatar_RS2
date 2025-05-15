using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class IncijalnaMigracija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Dvorana",
                columns: table => new
                {
                    DvoranaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Kapacitet = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Dvorana__B534FBB1E4A1508C", x => x.DvoranaId);
                });

            migrationBuilder.CreateTable(
                name: "Glumac",
                columns: table => new
                {
                    GlumacId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Prezime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Biografija = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Glumac__7782EF2A330ECF0E", x => x.GlumacId);
                });

            migrationBuilder.CreateTable(
                name: "Hrana",
                columns: table => new
                {
                    HranaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Hrana__19AD0AEA4B1C6010", x => x.HranaId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Prezime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Email = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Telefon = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    KorisnickoIme = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(2000)", maxLength: 2000, nullable: true),
                    LozinkaHash = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    DatumRodenja = table.Column<DateTime>(type: "datetime", nullable: false),
                    DatumRegistracije = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnik__80B06D41BBD960AE", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "Predstava",
                columns: table => new
                {
                    PredstavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Opis = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: false),
                    TrajanjePocetak = table.Column<DateTime>(type: "datetime", nullable: false),
                    TrajanjeKraj = table.Column<DateTime>(type: "datetime", nullable: false),
                    Produkcija = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Koreografija = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Scenografija = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(2000)", maxLength: 2000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Predstav__024E0E4A0BBF2AA0", x => x.PredstavaId);
                });

            migrationBuilder.CreateTable(
                name: "Repertoar",
                columns: table => new
                {
                    RepertoarId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Opis = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: false),
                    DatumPocetka = table.Column<DateTime>(type: "datetime", nullable: false),
                    DatumKraja = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Repertoa__1018CC45DC2374D2", x => x.RepertoarId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Opis = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uloga__DCAB23CBA4EF472E", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "Zanr",
                columns: table => new
                {
                    ZanrId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Zanr__953868D37E250D1A", x => x.ZanrId);
                });

            migrationBuilder.CreateTable(
                name: "Sjediste",
                columns: table => new
                {
                    SjedisteId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Red = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Kolona = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    DvoranaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Sjediste__B2086AAA0744C421", x => x.SjedisteId);
                    table.ForeignKey(
                        name: "FKSjediste19417",
                        column: x => x.DvoranaId,
                        principalTable: "Dvorana",
                        principalColumn: "DvoranaId");
                });

            migrationBuilder.CreateTable(
                name: "Uplata",
                columns: table => new
                {
                    UplataId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Iznos = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uplata__C5B165E69C3A436D", x => x.UplataId);
                    table.ForeignKey(
                        name: "FKUplata894550",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateTable(
                name: "Vijest",
                columns: table => new
                {
                    VijestId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Sadrzaj = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Vijest__F619121C860AB937", x => x.VijestId);
                    table.ForeignKey(
                        name: "FKVijest785774",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateTable(
                name: "Ocjena",
                columns: table => new
                {
                    OcjenaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Vrijednost = table.Column<int>(type: "int", nullable: false),
                    Komentar = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: false),
                    DatumKreiranja = table.Column<DateTime>(type: "datetime", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    PredstavaId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Ocjena__E6FC7AA92AEC1C39", x => x.OcjenaId);
                    table.ForeignKey(
                        name: "FKOcjena731337",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FKOcjena784566",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                });

            migrationBuilder.CreateTable(
                name: "PredstavaGlumac",
                columns: table => new
                {
                    PredstavaGlumacId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    PredstavaId = table.Column<int>(type: "int", nullable: false),
                    GlumacId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Predstav__2A010D82781F86EE", x => x.PredstavaGlumacId);
                    table.ForeignKey(
                        name: "FKPredstavaG242172",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FKPredstavaG755270",
                        column: x => x.GlumacId,
                        principalTable: "Glumac",
                        principalColumn: "GlumacId");
                });

            migrationBuilder.CreateTable(
                name: "Termin",
                columns: table => new
                {
                    TerminId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    DvoranaId = table.Column<int>(type: "int", nullable: false),
                    PredstavaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Termin__42126C95643B31F8", x => x.TerminId);
                    table.ForeignKey(
                        name: "FKTermin31281",
                        column: x => x.DvoranaId,
                        principalTable: "Dvorana",
                        principalColumn: "DvoranaId");
                    table.ForeignKey(
                        name: "FKTermin545750",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                });

            migrationBuilder.CreateTable(
                name: "PredstavaRepertoar",
                columns: table => new
                {
                    PredstavaRepertoarId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PredstavaId = table.Column<int>(type: "int", nullable: false),
                    RepertoarId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PredstavaRepertoar", x => x.PredstavaRepertoarId);
                    table.ForeignKey(
                        name: "FK_PredstavaRepertoar_Predstava_PredstavaId",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FK_PredstavaRepertoar_Repertoar_RepertoarId",
                        column: x => x.RepertoarId,
                        principalTable: "Repertoar",
                        principalColumn: "RepertoarId");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloga",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnik__1608726EE6CFC106", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FKKorisnikUl220885",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                    table.ForeignKey(
                        name: "FKKorisnikUl810045",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateTable(
                name: "PredstavaZanr",
                columns: table => new
                {
                    PredstavaZanrId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    ZanrId = table.Column<int>(type: "int", nullable: false),
                    PredstavaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Predstav__67D6222F83EF3DAA", x => x.PredstavaZanrId);
                    table.ForeignKey(
                        name: "FKPredstavaZ211544",
                        column: x => x.PredstavaId,
                        principalTable: "Predstava",
                        principalColumn: "PredstavaId");
                    table.ForeignKey(
                        name: "FKPredstavaZ6500",
                        column: x => x.ZanrId,
                        principalTable: "Zanr",
                        principalColumn: "ZanrId");
                });

            migrationBuilder.CreateTable(
                name: "StavkaUplate",
                columns: table => new
                {
                    StavkaUplateId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    HranaId = table.Column<int>(type: "int", nullable: false),
                    UplataId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StavkaUp__BFAFD85965F23692", x => x.StavkaUplateId);
                    table.ForeignKey(
                        name: "FKStavkaUpla481381",
                        column: x => x.UplataId,
                        principalTable: "Uplata",
                        principalColumn: "UplataId");
                    table.ForeignKey(
                        name: "FKStavkaUpla569574",
                        column: x => x.HranaId,
                        principalTable: "Hrana",
                        principalColumn: "HranaId");
                });

            migrationBuilder.CreateTable(
                name: "Rezervacija",
                columns: table => new
                {
                    RezervacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Status = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    TerminId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Rezervac__CABA44DDDA32E40D", x => x.RezervacijaId);
                    table.ForeignKey(
                        name: "FKRezervacij849203",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK_Rezervacija_Termin_TerminId",
                        column: x => x.TerminId,
                        principalTable: "Termin",
                        principalColumn: "TerminId");
                });

            migrationBuilder.CreateTable(
                name: "Karta",
                columns: table => new
                {
                    KartaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime", nullable: true),
                    SjedisteId = table.Column<int>(type: "int", nullable: false),
                    TerminId = table.Column<int>(type: "int", nullable: false),
                    RezervacijaId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Karta__EC3FA9EEAD399E80", x => x.KartaId);
                    table.ForeignKey(
                        name: "FKKarta115096",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FKKarta279567",
                        column: x => x.SjedisteId,
                        principalTable: "Sjediste",
                        principalColumn: "SjedisteId");
                    table.ForeignKey(
                        name: "FKKarta684934",
                        column: x => x.TerminId,
                        principalTable: "Termin",
                        principalColumn: "TerminId");
                    table.ForeignKey(
                        name: "FKKarta75020",
                        column: x => x.RezervacijaId,
                        principalTable: "Rezervacija",
                        principalColumn: "RezervacijaId");
                });

            migrationBuilder.CreateTable(
                name: "RezervacijaSjediste",
                columns: table => new
                {
                    RezervacijaSjedisteId = table.Column<int>(type: "int", nullable: false).Annotation("SqlServer:Identity", "1, 1"),
                    RezervacijaId = table.Column<int>(type: "int", nullable: false),
                    SjedisteId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    VrijemeBrisanja = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaSjediste", x => x.RezervacijaSjedisteId);
                    table.ForeignKey(
                        name: "FKSjediste277089",
                        column: x => x.SjedisteId,
                        principalTable: "Sjediste",
                        principalColumn: "SjedisteId");
                    table.ForeignKey(
                        name: "FKRezervacija",
                        column: x => x.RezervacijaId,
                        principalTable: "Rezervacija",
                        principalColumn: "RezervacijaId");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Karta_KorisnikId",
                table: "Karta",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Karta_RezervacijaId",
                table: "Karta",
                column: "RezervacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Karta_SjedisteId",
                table: "Karta",
                column: "SjedisteId");

            migrationBuilder.CreateIndex(
                name: "IX_Karta_TerminId",
                table: "Karta",
                column: "TerminId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_KorisnikId",
                table: "KorisnikUloga",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_UlogaId",
                table: "KorisnikUloga",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_KorisnikId",
                table: "Ocjena",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_PredstavaId",
                table: "Ocjena",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaGlumac_GlumacId",
                table: "PredstavaGlumac",
                column: "GlumacId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaGlumac_PredstavaId",
                table: "PredstavaGlumac",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaRepertoar_PredstavaId",
                table: "PredstavaRepertoar",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaRepertoar_RepertoarId",
                table: "PredstavaRepertoar",
                column: "RepertoarId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaZanr_PredstavaId",
                table: "PredstavaZanr",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_PredstavaZanr_ZanrId",
                table: "PredstavaZanr",
                column: "ZanrId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_KorisnikId",
                table: "Rezervacija",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_TerminId",
                table: "Rezervacija",
                column: "TerminId");

            migrationBuilder.CreateIndex(
                name: "IX_Sjediste_DvoranaId",
                table: "Sjediste",
                column: "DvoranaId");

            migrationBuilder.CreateIndex(
                name: "IX_StavkaUplate_HranaId",
                table: "StavkaUplate",
                column: "HranaId");

            migrationBuilder.CreateIndex(
                name: "IX_StavkaUplate_UplataId",
                table: "StavkaUplate",
                column: "UplataId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_DvoranaId",
                table: "Termin",
                column: "DvoranaId");

            migrationBuilder.CreateIndex(
                name: "IX_Termin_PredstavaId",
                table: "Termin",
                column: "PredstavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Uplata_KorisnikId",
                table: "Uplata",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Vijest_KorisnikId",
                table: "Vijest",
                column: "KorisnikId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Karta");

            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.DropTable(
                name: "Ocjena");

            migrationBuilder.DropTable(
                name: "PredstavaGlumac");

            migrationBuilder.DropTable(
                name: "PredstavaRepertoar");

            migrationBuilder.DropTable(
                name: "PredstavaZanr");

            migrationBuilder.DropTable(
                name: "RezervacijaSjediste");

            migrationBuilder.DropTable(
                name: "StavkaUplate");

            migrationBuilder.DropTable(
                name: "Vijest");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Glumac");

            migrationBuilder.DropTable(
                name: "Repertoar");

            migrationBuilder.DropTable(
                name: "Zanr");

            migrationBuilder.DropTable(
                name: "Sjediste");

            migrationBuilder.DropTable(
                name: "Rezervacija");

            migrationBuilder.DropTable(
                name: "Uplata");

            migrationBuilder.DropTable(
                name: "Hrana");

            migrationBuilder.DropTable(
                name: "Termin");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Dvorana");

            migrationBuilder.DropTable(
                name: "Predstava");
        }
    }
}
