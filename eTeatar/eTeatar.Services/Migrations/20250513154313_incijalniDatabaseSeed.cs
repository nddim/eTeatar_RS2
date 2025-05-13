using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eTeatar.Services.Migrations
{
    /// <inheritdoc />
    public partial class incijalniDatabaseSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Dvorana",
                columns: new[] { "DvoranaId", "IsDeleted", "Kapacitet", "Naziv", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, 49, "Dvorana 1", null },
                    { 2, false, 36, "Dvorana 2", null },
                    { 3, false, 25, "Dvorana 3", null }
                });

            migrationBuilder.InsertData(
                table: "Glumac",
                columns: new[] { "GlumacId", "Biografija", "Ime", "IsDeleted", "Prezime", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, "Leonardo DiCaprio je američki glumac i producent, poznat po ulogama u filmovima kao što su 'Titanic', 'Inception', 'The Revenant' i 'The Wolf of Wall Street'. Dobitnik je Oskara i ekološki aktivista.", "Leonardo", false, "DiCaprio", null },
                    { 2, "Johnny Depp je američki glumac poznat po ekscentričnim i upečatljivim ulogama, posebno kao kapetan Jack Sparrow. Njegova karijera traje više od tri decenije.", "Johnny", false, "Depp", null },
                    { 3, "Mustafa Nadarević bio je jedan od najcjenjenijih glumaca bivše Jugoslavije. Poznat po ulogama u filmovima, serijama i pozorištu, ostavio je dubok trag u kulturi regije, naročito ulogom Izeta Fazlinovića.", "Mustafa", false, "Nadarević", null },
                    { 4, "Emir Hadžihafizbegović je jedan od najpoznatijih glumaca u BiH. Igrao je u brojnim filmovima i serijama u regiji, a poznat je po izražajnoj glumi i snažnim dramskim ulogama.", "Emir", false, "Hadžihafizbegović", null },
                    { 5, "Ermin Bravo je nagrađivani glumac iz BiH koji je ostvario značajne uloge u domaćim i međunarodnim filmovima. Takođe je aktivan u pozorištu i kao reditelj.", "Ermin", false, "Bravo", null },
                    { 6, "Senad Bašić je bosanskohercegovački glumac i univerzitetski profesor. Poznat je po bogatom glumačkom opusu, naročito po ulozi Faruka u seriji 'Lud, zbunjen, normalan'.", "Senad", false, "Bašić", null }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikId", "DatumRegistracije", "DatumRodenja", "Email", "Ime", "IsDeleted", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Slika", "Telefon", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 5, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2002, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "admin@eteatar.com", "Admin", false, "admin", "Agw/bMTUSAFhUokkvB7TO8MCeog=", "U3/wrAznwLRJH55vtPWHew==", "Admin", null, "+60456456", null },
                    { 2, new DateTime(2025, 5, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2001, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "mobile@eteatar.com", "Mobile", false, "mobile", "PT2xyqoSvBlVw+JOSdhqKTMTyWs=", "pebmamqt/rufY8AszeYBbw==", "Mobile", null, "+60123123", null }
                });

            migrationBuilder.InsertData(
                table: "Predstava",
                columns: new[] { "PredstavaId", "Cijena", "IsDeleted", "Koreografija", "Naziv", "Opis", "Produkcija", "Scenografija", "Slika", "Trajanje", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, 10m, false, "Fadil Opancic", "Ajmo na fuka", "Predstava govori o odnosu dvojice vojnika, pripadnika Hrvatskog vijeca odbrane i Armije Republike Bosne i Hercegovine.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 2, 10m, false, "Fadil Opancic", "Ne igraj na engleze", "Tri prijatelja. Tri kladionicara. Tri suprotstavljena uloga. Jedna utakmica. I ta jedna utakmica bi trebala da riješi sve njihove probleme. I umjesto da ih riješi, ta utakmica ce pokrenuti razgovor o svim problemima u njihovim medusobnim odnosima.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 3, 10m, false, "Fadil Opancic", "Audicija", "Kultna komedija koja je postala klasik bivše Jugoslavije", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 4, 10m, false, "Fadil Opancic", "Legenda o Ali-paši", "Osnovni kostur ili skelet priče Legende o Ali-paši predstavlja preobrazba Alije Leptira od hamala do visokog dostojanstvenika. Ta se preobrazba prvo zbiva u snu, a onda i zbiljski ostvaruje u njegovom životu. ", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 5, 10m, false, "Fadil Opancic", "Balkanski špijun", "Balkanski špijun, kultni je naslov čiji su citati postali dio opće kulture i ušli u usmenu predaju kao suvenir iz vremena, sustava vrijednosti i života ljudi od kojeg se udaljavamo posljednjih četrdesetak godina ili bar tako vjerujemo.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 6, 10m, false, "Fadil Opancic", "Identitluk", "Kad danas u Bosni i Hercegovini citamo eseje francuskog Libanonca Amina Maaloufa napisane prije dvadesetak godina, cine se tako inspirativni i na svakoj drugoj stranici imamo potrebu glasno se s autorom složiti.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 7, 10m, false, "Fadil Opancic", "Zbogom, Kalifornijo!", "Predstava je, kao i tekst, zamišljena kao posveta svim Mostarcima, onima koji su ostali u gradu i onima koji su ga napustili, ali i onima koji ga i dalje napuštaju, i onome što je nekada bio i što je sada grad Mostar.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 8, 10m, false, "Fadil Opancic", "Ludilo u ...", "Ludilo u... je predstava u kojoj tretiramo Joneskov predložak kao polaznu tacku za predstavu koja se bavi zajednicom izmedu muškarca i žene. Koliko se pojam zajednice promijenio i koliko je drugaciji danas? Koliko geografija u tome ima udjela? Da li je danas zajednica zapravo samo klasno pitanje? ", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 9, 10m, false, "Fadil Opancic", "Kokoška", "Ovaj izuzetno zanimljivi tekst opisuje intimu života glumaca i glumica, život iza kulisa i postavlja pitanje: gdje je i da li se uopće može povući jasna distinkcija između teatra i života.", "Leon Lucic", "Ivan Primorac", null, 120, null },
                    { 10, 10m, false, "Fadil Opancic", "Hasanaginica", "Hasanaginica je jedna brutalno iskrena predstava. Svi ti likovi i svi ti zapleti, svaki sukob i svaka kap ljudskosti, iscijeđena je iz iskustva nas samih, članova ekipe koja je stvorila djelo.", "Leon Lucic", "Ivan Primorac", null, 120, null }
                });

            migrationBuilder.InsertData(
                table: "Repertoar",
                columns: new[] { "RepertoarId", "DatumKraja", "DatumPocetka", "IsDeleted", "Naziv", "Opis", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 6, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 5, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), false, "Repertoar 1", "Repertoar 1", null },
                    { 2, new DateTime(2025, 7, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), false, "Repertoar 2", "Repertoar 2", null },
                    { 3, new DateTime(2025, 8, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 7, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), false, "Repertoar 3", "Repertoar 3", null }
                });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaId", "IsDeleted", "Naziv", "Opis", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, "Admin", "Admin", null },
                    { 2, false, "Gledaoc", "Gledaoc", null }
                });

            migrationBuilder.InsertData(
                table: "Zanr",
                columns: new[] { "ZanrId", "IsDeleted", "Naziv", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, "Komedija", null },
                    { 2, false, "Drama", null },
                    { 3, false, "Tragedija", null },
                    { 4, false, "Mjuzikl", null },
                    { 5, false, "Triler", null },
                    { 6, false, "Satira", null }
                });

            migrationBuilder.InsertData(
                table: "KorisnikUloga",
                columns: new[] { "KorisnikUlogaId", "IsDeleted", "KorisnikId", "UlogaId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, 1, 1, null },
                    { 2, false, 2, 2, null }
                });

            migrationBuilder.InsertData(
                table: "Ocjena",
                columns: new[] { "OcjenaId", "DatumKreiranja", "IsDeleted", "Komentar", "KorisnikId", "PredstavaId", "Vrijednost", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 5, 9, 18, 0, 0, 0, DateTimeKind.Unspecified), false, "Odlična predstava!", 2, 1, 4, null },
                    { 2, new DateTime(2025, 5, 10, 15, 30, 0, 0, DateTimeKind.Unspecified), false, "Gluma fantastična, priča zanimljiva.", 2, 2, 5, null },
                    { 3, new DateTime(2025, 5, 11, 16, 0, 0, 0, DateTimeKind.Unspecified), false, "Dobar pokušaj, ali može bolje.", 2, 3, 3, null },
                    { 4, new DateTime(2025, 5, 12, 11, 0, 0, 0, DateTimeKind.Unspecified), false, "Bravo za produkciju i režiju!", 2, 4, 5, null },
                    { 5, new DateTime(2025, 5, 12, 14, 45, 0, 0, DateTimeKind.Unspecified), false, "Veoma emotivno i snažno.", 2, 5, 4, null },
                    { 6, new DateTime(2025, 5, 10, 12, 0, 0, 0, DateTimeKind.Unspecified), false, "Svaka čast glumcima!", 1, 1, 5, null },
                    { 7, new DateTime(2025, 5, 11, 13, 0, 0, 0, DateTimeKind.Unspecified), false, "Solidno, ali nije ostavilo jak utisak.", 1, 2, 3, null },
                    { 8, new DateTime(2025, 5, 11, 14, 0, 0, 0, DateTimeKind.Unspecified), false, "Zanimljiva priča i dobar ritam.", 1, 4, 4, null },
                    { 9, new DateTime(2025, 5, 12, 15, 0, 0, 0, DateTimeKind.Unspecified), false, "Režija i scenografija vrhunski odrađeni.", 1, 9, 4, null }
                });

            migrationBuilder.InsertData(
                table: "PredstavaGlumac",
                columns: new[] { "PredstavaGlumacId", "GlumacId", "IsDeleted", "PredstavaId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, 1, false, 1, null },
                    { 2, 2, false, 1, null },
                    { 3, 3, false, 1, null },
                    { 4, 2, false, 2, null },
                    { 5, 4, false, 2, null },
                    { 6, 5, false, 3, null },
                    { 7, 1, false, 3, null },
                    { 8, 6, false, 3, null },
                    { 9, 3, false, 4, null },
                    { 10, 4, false, 4, null },
                    { 11, 2, false, 5, null },
                    { 12, 5, false, 5, null },
                    { 13, 6, false, 5, null },
                    { 14, 1, false, 6, null },
                    { 15, 3, false, 6, null },
                    { 16, 6, false, 6, null },
                    { 17, 2, false, 7, null },
                    { 18, 4, false, 7, null },
                    { 19, 1, false, 8, null },
                    { 20, 5, false, 8, null },
                    { 21, 6, false, 8, null },
                    { 22, 3, false, 8, null },
                    { 23, 4, false, 9, null },
                    { 24, 1, false, 9, null },
                    { 25, 2, false, 10, null },
                    { 26, 3, false, 10, null },
                    { 27, 4, false, 10, null },
                    { 28, 5, false, 10, null },
                    { 29, 1, false, 10, null }
                });

            migrationBuilder.InsertData(
                table: "PredstavaRepertoar",
                columns: new[] { "PredstavaRepertoarId", "IsDeleted", "PredstavaId", "RepertoarId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, 1, 1, null },
                    { 2, false, 2, 1, null },
                    { 3, false, 3, 1, null },
                    { 4, false, 2, 2, null },
                    { 5, false, 3, 2, null },
                    { 6, false, 4, 2, null },
                    { 7, false, 5, 2, null },
                    { 8, false, 6, 2, null },
                    { 9, false, 7, 2, null },
                    { 10, false, 3, 3, null },
                    { 11, false, 4, 3, null },
                    { 12, false, 5, 3, null },
                    { 13, false, 6, 3, null },
                    { 14, false, 7, 3, null },
                    { 15, false, 8, 3, null },
                    { 16, false, 9, 3, null },
                    { 17, false, 1, 3, null }
                });

            migrationBuilder.InsertData(
                table: "PredstavaZanr",
                columns: new[] { "PredstavaZanrId", "IsDeleted", "PredstavaId", "VrijemeBrisanja", "ZanrId" },
                values: new object[,]
                {
                    { 1, false, 1, null, 2 },
                    { 2, false, 1, null, 5 },
                    { 3, false, 2, null, 1 },
                    { 4, false, 2, null, 6 },
                    { 5, false, 3, null, 1 },
                    { 6, false, 3, null, 6 },
                    { 7, false, 3, null, 4 },
                    { 8, false, 4, null, 3 },
                    { 9, false, 4, null, 2 },
                    { 10, false, 5, null, 6 },
                    { 11, false, 5, null, 1 },
                    { 12, false, 6, null, 2 },
                    { 13, false, 7, null, 2 },
                    { 14, false, 7, null, 3 },
                    { 15, false, 8, null, 5 },
                    { 16, false, 8, null, 4 },
                    { 17, false, 9, null, 6 },
                    { 18, false, 9, null, 2 },
                    { 19, false, 10, null, 3 },
                    { 20, false, 10, null, 2 }
                });

            migrationBuilder.InsertData(
                table: "Sjediste",
                columns: new[] { "SjedisteId", "DvoranaId", "IsDeleted", "Kolona", "Red", "Status", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, 1, false, "1", "A", "Aktivno", null },
                    { 2, 1, false, "2", "A", "Aktivno", null },
                    { 3, 1, false, "3", "A", "Aktivno", null },
                    { 4, 1, false, "4", "A", "Aktivno", null },
                    { 5, 1, false, "5", "A", "Aktivno", null },
                    { 6, 1, false, "6", "A", "Aktivno", null },
                    { 7, 1, false, "7", "A", "Aktivno", null },
                    { 8, 1, false, "1", "B", "Aktivno", null },
                    { 9, 1, false, "2", "B", "Aktivno", null },
                    { 10, 1, false, "3", "B", "Aktivno", null },
                    { 11, 1, false, "4", "B", "Aktivno", null },
                    { 12, 1, false, "5", "B", "Aktivno", null },
                    { 13, 1, false, "6", "B", "Aktivno", null },
                    { 14, 1, false, "7", "B", "Aktivno", null },
                    { 15, 1, false, "1", "C", "Aktivno", null },
                    { 16, 1, false, "2", "C", "Aktivno", null },
                    { 17, 1, false, "3", "C", "Aktivno", null },
                    { 18, 1, false, "4", "C", "Aktivno", null },
                    { 19, 1, false, "5", "C", "Aktivno", null },
                    { 20, 1, false, "6", "C", "Aktivno", null },
                    { 21, 1, false, "7", "C", "Aktivno", null },
                    { 22, 1, false, "1", "D", "Aktivno", null },
                    { 23, 1, false, "2", "D", "Aktivno", null },
                    { 24, 1, false, "3", "D", "Aktivno", null },
                    { 25, 1, false, "4", "D", "Aktivno", null },
                    { 26, 1, false, "5", "D", "Aktivno", null },
                    { 27, 1, false, "6", "D", "Aktivno", null },
                    { 28, 1, false, "7", "D", "Aktivno", null },
                    { 29, 1, false, "1", "E", "Aktivno", null },
                    { 30, 1, false, "2", "E", "Aktivno", null },
                    { 31, 1, false, "3", "E", "Aktivno", null },
                    { 32, 1, false, "4", "E", "Aktivno", null },
                    { 33, 1, false, "5", "E", "Aktivno", null },
                    { 34, 1, false, "6", "E", "Aktivno", null },
                    { 35, 1, false, "7", "E", "Aktivno", null },
                    { 36, 1, false, "1", "F", "Aktivno", null },
                    { 37, 1, false, "2", "F", "Aktivno", null },
                    { 38, 1, false, "3", "F", "Aktivno", null },
                    { 39, 1, false, "4", "F", "Aktivno", null },
                    { 40, 1, false, "5", "F", "Aktivno", null },
                    { 41, 1, false, "6", "F", "Aktivno", null },
                    { 42, 1, false, "7", "F", "Aktivno", null },
                    { 43, 1, false, "1", "G", "Aktivno", null },
                    { 44, 1, false, "2", "G", "Aktivno", null },
                    { 45, 1, false, "3", "G", "Aktivno", null },
                    { 46, 1, false, "4", "G", "Aktivno", null },
                    { 47, 1, false, "5", "G", "Aktivno", null },
                    { 48, 1, false, "6", "G", "Aktivno", null },
                    { 49, 1, false, "7", "G", "Aktivno", null },
                    { 50, 2, false, "1", "A", "Aktivno", null },
                    { 51, 2, false, "2", "A", "Aktivno", null },
                    { 52, 2, false, "3", "A", "Aktivno", null },
                    { 53, 2, false, "4", "A", "Aktivno", null },
                    { 54, 2, false, "5", "A", "Aktivno", null },
                    { 55, 2, false, "6", "A", "Aktivno", null },
                    { 56, 2, false, "1", "B", "Aktivno", null },
                    { 57, 2, false, "2", "B", "Aktivno", null },
                    { 58, 2, false, "3", "B", "Aktivno", null },
                    { 59, 2, false, "4", "B", "Aktivno", null },
                    { 60, 2, false, "5", "B", "Aktivno", null },
                    { 61, 2, false, "6", "B", "Aktivno", null },
                    { 62, 2, false, "1", "C", "Aktivno", null },
                    { 63, 2, false, "2", "C", "Aktivno", null },
                    { 64, 2, false, "3", "C", "Aktivno", null },
                    { 65, 2, false, "4", "C", "Aktivno", null },
                    { 66, 2, false, "5", "C", "Aktivno", null },
                    { 67, 2, false, "6", "C", "Aktivno", null },
                    { 68, 2, false, "1", "D", "Aktivno", null },
                    { 69, 2, false, "2", "D", "Aktivno", null },
                    { 70, 2, false, "3", "D", "Aktivno", null },
                    { 71, 2, false, "4", "D", "Aktivno", null },
                    { 72, 2, false, "5", "D", "Aktivno", null },
                    { 73, 2, false, "6", "D", "Aktivno", null },
                    { 74, 2, false, "1", "E", "Aktivno", null },
                    { 75, 2, false, "2", "E", "Aktivno", null },
                    { 76, 2, false, "3", "E", "Aktivno", null },
                    { 77, 2, false, "4", "E", "Aktivno", null },
                    { 78, 2, false, "5", "E", "Aktivno", null },
                    { 79, 2, false, "6", "E", "Aktivno", null },
                    { 80, 2, false, "1", "F", "Aktivno", null },
                    { 81, 2, false, "2", "F", "Aktivno", null },
                    { 82, 2, false, "3", "F", "Aktivno", null },
                    { 83, 2, false, "4", "F", "Aktivno", null },
                    { 84, 2, false, "5", "F", "Aktivno", null },
                    { 85, 2, false, "6", "F", "Aktivno", null },
                    { 86, 3, false, "1", "A", "Aktivno", null },
                    { 87, 3, false, "2", "A", "Aktivno", null },
                    { 88, 3, false, "3", "A", "Aktivno", null },
                    { 89, 3, false, "4", "A", "Aktivno", null },
                    { 90, 3, false, "5", "A", "Aktivno", null },
                    { 91, 3, false, "1", "B", "Aktivno", null },
                    { 92, 3, false, "2", "B", "Aktivno", null },
                    { 93, 3, false, "3", "B", "Aktivno", null },
                    { 94, 3, false, "4", "B", "Aktivno", null },
                    { 95, 3, false, "5", "B", "Aktivno", null },
                    { 96, 3, false, "1", "C", "Aktivno", null },
                    { 97, 3, false, "2", "C", "Aktivno", null },
                    { 98, 3, false, "3", "C", "Aktivno", null },
                    { 99, 3, false, "4", "C", "Aktivno", null },
                    { 100, 3, false, "5", "C", "Aktivno", null },
                    { 101, 3, false, "1", "D", "Aktivno", null },
                    { 102, 3, false, "2", "D", "Aktivno", null },
                    { 103, 3, false, "3", "D", "Aktivno", null },
                    { 104, 3, false, "4", "D", "Aktivno", null },
                    { 105, 3, false, "5", "D", "Aktivno", null },
                    { 106, 3, false, "1", "E", "Aktivno", null },
                    { 107, 3, false, "2", "E", "Aktivno", null },
                    { 108, 3, false, "3", "E", "Aktivno", null },
                    { 109, 3, false, "4", "E", "Aktivno", null },
                    { 110, 3, false, "5", "E", "Aktivno", null }
                });

            migrationBuilder.InsertData(
                table: "Termin",
                columns: new[] { "TerminId", "Datum", "DvoranaId", "IsDeleted", "PredstavaId", "Status", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 1, "Aktivan", null },
                    { 2, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 1, "Aktivan", null },
                    { 3, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 1, "Aktivan", null },
                    { 4, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 1, "Aktivan", null },
                    { 5, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 1, "Aktivan", null },
                    { 6, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 1, "Aktivan", null },
                    { 7, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 2, "Aktivan", null },
                    { 8, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 2, "Aktivan", null },
                    { 9, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 2, "Aktivan", null },
                    { 10, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 2, "Aktivan", null },
                    { 11, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 2, "Aktivan", null },
                    { 12, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 2, "Aktivan", null },
                    { 13, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 3, "Aktivan", null },
                    { 14, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 3, "Aktivan", null },
                    { 15, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 3, "Aktivan", null },
                    { 16, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 3, "Aktivan", null },
                    { 17, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 3, "Aktivan", null },
                    { 18, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 3, "Aktivan", null },
                    { 19, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 4, "Aktivan", null },
                    { 20, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 4, "Aktivan", null },
                    { 21, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 4, "Aktivan", null },
                    { 22, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 4, "Aktivan", null },
                    { 23, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 4, "Aktivan", null },
                    { 24, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 4, "Aktivan", null },
                    { 25, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 5, "Aktivan", null },
                    { 26, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 5, "Aktivan", null },
                    { 27, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 5, "Aktivan", null },
                    { 28, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 5, "Aktivan", null },
                    { 29, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 5, "Aktivan", null },
                    { 30, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 5, "Aktivan", null },
                    { 31, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 6, "Aktivan", null },
                    { 32, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 6, "Aktivan", null },
                    { 33, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 6, "Aktivan", null },
                    { 34, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 6, "Aktivan", null },
                    { 35, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 6, "Aktivan", null },
                    { 36, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 6, "Aktivan", null },
                    { 37, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 7, "Aktivan", null },
                    { 38, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 7, "Aktivan", null },
                    { 39, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 7, "Aktivan", null },
                    { 40, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 7, "Aktivan", null },
                    { 41, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 7, "Aktivan", null },
                    { 42, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 7, "Aktivan", null },
                    { 43, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 8, "Aktivan", null },
                    { 44, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 8, "Aktivan", null },
                    { 45, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 8, "Aktivan", null },
                    { 46, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 8, "Aktivan", null },
                    { 47, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 8, "Aktivan", null },
                    { 48, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 8, "Aktivan", null },
                    { 49, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 9, "Aktivan", null },
                    { 50, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 9, "Aktivan", null },
                    { 51, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 9, "Aktivan", null },
                    { 52, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 9, "Aktivan", null },
                    { 53, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 9, "Aktivan", null },
                    { 54, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 9, "Aktivan", null },
                    { 55, new DateTime(2025, 6, 1, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 10, "Aktivan", null },
                    { 56, new DateTime(2025, 6, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 10, "Aktivan", null },
                    { 57, new DateTime(2025, 6, 1, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 10, "Aktivan", null },
                    { 58, new DateTime(2025, 6, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, false, 10, "Aktivan", null },
                    { 59, new DateTime(2025, 6, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, false, 10, "Aktivan", null },
                    { 60, new DateTime(2025, 6, 2, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 10, "Aktivan", null }
                });

            migrationBuilder.InsertData(
                table: "Uplata",
                columns: new[] { "UplataId", "Datum", "IsDeleted", "Iznos", "KorisnikId", "NacinPlacanja", "Status", "TransakcijaId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 5, 11, 18, 0, 0, 0, DateTimeKind.Unspecified), false, 20m, 2, "Paypal", "Approved", "PAYID-NANRCPQ2PU03219CF299124H", null },
                    { 2, new DateTime(2025, 5, 12, 18, 30, 0, 0, DateTimeKind.Unspecified), false, 10m, 2, "Paypal", "Approved", "PAYID-NANRBLQ8FY05110WM3521649", null },
                    { 3, new DateTime(2025, 5, 12, 19, 30, 0, 0, DateTimeKind.Unspecified), false, 30m, 2, "Paypal", "Approved", "PAYID-NANRAJY10H05677AU1376209", null },
                    { 4, new DateTime(2025, 5, 13, 18, 30, 0, 0, DateTimeKind.Unspecified), false, 20m, 2, "Paypal", "Approved", "PAYID-NANGBNY0AX857222G028802W", null },
                    { 5, new DateTime(2025, 5, 13, 19, 15, 0, 0, DateTimeKind.Unspecified), false, 10m, 2, "Paypal", "Approved", "PAYID-NANGA5A71R48042FP1805639", null },
                    { 6, new DateTime(2025, 5, 13, 21, 0, 0, 0, DateTimeKind.Unspecified), false, 20m, 2, "Paypal", "Approved", "PAYID-NANF7YI7AR60568FL8049816", null }
                });

            migrationBuilder.InsertData(
                table: "Vijest",
                columns: new[] { "VijestId", "Datum", "IsDeleted", "KorisnikId", "Naziv", "Sadrzaj", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 5, 10, 19, 15, 0, 0, DateTimeKind.Unspecified), false, 2, "Otvorena nova sezona teatra", "Zvanično je otvorena nova sezona u Narodnom teatru, a publiku očekuje bogat repertoar predstava tokom ljeta.", null },
                    { 2, new DateTime(2025, 5, 11, 17, 0, 0, 0, DateTimeKind.Unspecified), false, 2, "Gostujuća predstava iz Njemacke", "Poznato pozorište iz Berlina gostuje naredne sedmice s predstavom 'Balkanski špijun'. Karte su već u prodaji.", null },
                    { 3, new DateTime(2025, 5, 12, 14, 30, 0, 0, DateTimeKind.Unspecified), false, 2, "Radionica glume za mlade", "Teatar organizuje besplatnu radionicu glume za srednjoškolce. Prijave su otvorene do 20. maja.", null },
                    { 4, new DateTime(2025, 5, 13, 18, 45, 0, 0, DateTimeKind.Unspecified), false, 2, "Humanitarna predstava za djecu", "U saradnji s lokalnim udruženjima, organizuje se predstava čiji će prihod biti doniran dječijem odjeljenju bolnice.", null }
                });

            migrationBuilder.InsertData(
                table: "Karta",
                columns: new[] { "KartaId", "Cijena", "IsDeleted", "KorisnikId", "RezervacijaId", "SjedisteId", "TerminId", "VrijemeBrisanja", "ukljucenaHrana" },
                values: new object[,]
                {
                    { 1, 10m, false, 2, null, 2, 22, null, true },
                    { 2, 10m, false, 2, null, 3, 22, null, true },
                    { 3, 10m, false, 2, null, 89, 30, null, false },
                    { 4, 10m, false, 2, null, 90, 30, null, false },
                    { 5, 10m, false, 2, null, 10, 60, null, true },
                    { 6, 10m, false, 2, null, 11, 60, null, true }
                });

            migrationBuilder.InsertData(
                table: "Rezervacija",
                columns: new[] { "RezervacijaId", "IsDeleted", "KorisnikId", "StateMachine", "TerminId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, 2, "Kreirano", 3, null },
                    { 2, false, 2, "Kreirano", 5, null },
                    { 3, false, 2, "Kreirano", 7, null },
                    { 4, false, 2, "Odobreno", 10, null },
                    { 5, false, 2, "Odobreno", 12, null },
                    { 6, false, 2, "Odobreno", 15, null },
                    { 7, false, 2, "Ponisteno", 20, null },
                    { 8, false, 2, "Zavrseno", 22, null },
                    { 9, false, 2, "Zavrseno", 30, null },
                    { 10, false, 2, "Zavrseno", 46, null }
                });

            migrationBuilder.InsertData(
                table: "StavkaUplate",
                columns: new[] { "StavkaUplateId", "Cijena", "IsDeleted", "Kolicina", "UplataId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, 20m, false, 2, 1, null },
                    { 2, 10m, false, 1, 2, null },
                    { 3, 30m, false, 3, 3, null },
                    { 4, 20m, false, 2, 4, null },
                    { 5, 10m, false, 1, 5, null },
                    { 6, 20m, false, 2, 6, null }
                });

            migrationBuilder.InsertData(
                table: "RezervacijaSjediste",
                columns: new[] { "RezervacijaSjedisteId", "IsDeleted", "RezervacijaId", "SjedisteId", "VrijemeBrisanja" },
                values: new object[,]
                {
                    { 1, false, 1, 86, null },
                    { 2, false, 2, 55, null },
                    { 3, false, 3, 23, null },
                    { 4, false, 4, 9, null },
                    { 5, false, 5, 98, null },
                    { 6, false, 6, 94, null },
                    { 7, false, 7, 68, null },
                    { 8, false, 8, 31, null },
                    { 9, false, 9, 101, null },
                    { 10, false, 10, 44, null }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Karta",
                keyColumn: "KartaId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Ocjena",
                keyColumn: "OcjenaId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "PredstavaGlumac",
                keyColumn: "PredstavaGlumacId",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "PredstavaRepertoar",
                keyColumn: "PredstavaRepertoarId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "PredstavaZanr",
                keyColumn: "PredstavaZanrId",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "RezervacijaSjediste",
                keyColumn: "RezervacijaSjedisteId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 61);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 62);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 63);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 64);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 65);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 66);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 67);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 69);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 70);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 71);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 72);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 73);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 74);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 75);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 76);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 77);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 78);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 79);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 80);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 81);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 82);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 83);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 84);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 85);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 87);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 88);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 91);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 92);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 93);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 95);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 96);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 97);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 99);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 100);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 102);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 103);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 104);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 105);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 106);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 107);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 108);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 109);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 110);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "StavkaUplate",
                keyColumn: "StavkaUplateId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "Vijest",
                keyColumn: "VijestId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Vijest",
                keyColumn: "VijestId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Vijest",
                keyColumn: "VijestId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Vijest",
                keyColumn: "VijestId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Glumac",
                keyColumn: "GlumacId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Repertoar",
                keyColumn: "RepertoarId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Repertoar",
                keyColumn: "RepertoarId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Repertoar",
                keyColumn: "RepertoarId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Rezervacija",
                keyColumn: "RezervacijaId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 68);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 86);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 89);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 90);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 94);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 98);

            migrationBuilder.DeleteData(
                table: "Sjediste",
                keyColumn: "SjedisteId",
                keyValue: 101);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "Uloga",
                keyColumn: "UlogaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uloga",
                keyColumn: "UlogaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "UplataId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Zanr",
                keyColumn: "ZanrId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Termin",
                keyColumn: "TerminId",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Dvorana",
                keyColumn: "DvoranaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Dvorana",
                keyColumn: "DvoranaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Dvorana",
                keyColumn: "DvoranaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Predstava",
                keyColumn: "PredstavaId",
                keyValue: 8);
        }
    }
}
