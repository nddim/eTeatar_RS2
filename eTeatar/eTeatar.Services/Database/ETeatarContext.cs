using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace eTeatar.Services.Database;

public partial class ETeatarContext : DbContext
{
    public ETeatarContext()
    {
    }

    public ETeatarContext(DbContextOptions<ETeatarContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Dvorana> Dvoranas { get; set; }

    public virtual DbSet<Glumac> Glumacs { get; set; }

    public virtual DbSet<Kartum> Karta { get; set; }

    public virtual DbSet<Korisnik> Korisniks { get; set; }

    public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; }

    public virtual DbSet<Ocjena> Ocjenas { get; set; }

    public virtual DbSet<Predstava> Predstavas { get; set; }

    public virtual DbSet<PredstavaGlumac> PredstavaGlumacs { get; set; }

    public virtual DbSet<PredstavaZanr> PredstavaZanrs { get; set; }

    public virtual DbSet<Repertoar> Repertoars { get; set; }

    public virtual DbSet<Rezervacija> Rezervacijas { get; set; }

    public virtual DbSet<Sjediste> Sjedistes { get; set; }

    public virtual DbSet<StavkaUplate> StavkaUplates { get; set; }

    public virtual DbSet<Termin> Termins { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

    public virtual DbSet<Uplatum> Uplata { get; set; }

    public virtual DbSet<Vijest> Vijests { get; set; }

    public virtual DbSet<Zanr> Zanrs { get; set; }

    public virtual DbSet<PredstavaRepertoar> PredstavaRepertoars { get; set; }

    public virtual DbSet<RezervacijaSjediste> RezervacijaSjedistes { get; set; }

//    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
//        => optionsBuilder.UseSqlServer("Data Source=localhost,1433;Initial Catalog=eTeatar;User=sa;Password=ASDqwe123!;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Dvorana>(entity =>
        {
            entity.HasKey(e => e.DvoranaId).HasName("PK__Dvorana__B534FBB1E4A1508C");

            entity.ToTable("Dvorana");

            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<Glumac>(entity =>
        {
            entity.HasKey(e => e.GlumacId).HasName("PK__Glumac__7782EF2A330ECF0E");

            entity.ToTable("Glumac");

            entity.Property(e => e.Biografija)
                .HasMaxLength(500)
                .IsUnicode(true);
            entity.Property(e => e.Ime)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.Prezime)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<Kartum>(entity =>
        {
            entity.HasKey(e => e.KartaId).HasName("PK__Karta__EC3FA9EEAD399E80");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.Property(e => e.Cijena)
                .HasPrecision(18, 2);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Karta)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKarta115096");

            entity.HasOne(d => d.Rezervacija).WithMany(p => p.Karta)
                .HasForeignKey(d => d.RezervacijaId)
                .IsRequired(false)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKarta75020");

            entity.HasOne(d => d.Sjediste).WithMany(p => p.Karta)
                .HasForeignKey(d => d.SjedisteId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKarta279567");

            entity.HasOne(d => d.Termin).WithMany(p => p.Karta)
                .HasForeignKey(d => d.TerminId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKarta684934");

            entity.Property(e => e.ukljucenaHrana)
                .HasColumnType("bit");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__Korisnik__80B06D41BBD960AE");

            entity.ToTable("Korisnik");

            entity.Property(e => e.DatumRegistracije).HasColumnType("datetime");
            entity.Property(e => e.DatumRodenja).HasColumnType("datetime");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Ime)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.KorisnickoIme)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.LozinkaHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LozinkaSalt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Prezime)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.Slika).HasColumnType("nvarchar(max)").IsUnicode(true);
            entity.Property(e => e.Telefon)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<KorisnikUloga>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogaId).HasName("PK__Korisnik__1608726EE6CFC106");

            entity.ToTable("KorisnikUloga");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKorisnikUl810045");

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKorisnikUl220885");
        });

        modelBuilder.Entity<Ocjena>(entity =>
        {
            entity.HasKey(e => e.OcjenaId).HasName("PK__Ocjena__E6FC7AA92AEC1C39");

            entity.ToTable("Ocjena");

            entity.Property(e => e.DatumKreiranja).HasColumnType("datetime");
            entity.Property(e => e.Komentar)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.Vrijednost).HasColumnName("Vrijednost");
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Ocjenas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKOcjena731337");

            entity.HasOne(d => d.Predstava).WithMany(p => p.Ocjenas)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKOcjena784566");
        });

        modelBuilder.Entity<Predstava>(entity =>
        {
            entity.HasKey(e => e.PredstavaId).HasName("PK__Predstav__024E0E4A0BBF2AA0");

            entity.ToTable("Predstava");

            entity.Property(e => e.Koreografija)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.Produkcija)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Scenografija)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.Property(e => e.Cijena)
                .HasPrecision(18, 2);

            entity.Property(e => e.Slika).HasColumnType("nvarchar(max)").IsUnicode(true);
            entity.Property(e => e.Trajanje);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
            entity.HasMany(e=> e.PredstavaRepertoars).WithOne(pr=> pr.Predstava).HasForeignKey(pr => pr.PredstavaId);
        });

        modelBuilder.Entity<PredstavaGlumac>(entity =>
        {
            entity.HasKey(e => e.PredstavaGlumacId).HasName("PK__Predstav__2A010D82781F86EE");

            entity.ToTable("PredstavaGlumac");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Glumac).WithMany(p => p.PredstavaGlumacs)
                .HasForeignKey(d => d.GlumacId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKPredstavaG755270");

            entity.HasOne(d => d.Predstava).WithMany(p => p.PredstavaGlumacs)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKPredstavaG242172");
        });

        modelBuilder.Entity<PredstavaRepertoar>(entity =>
        {
            entity.HasKey(e => e.PredstavaRepertoarId);

            entity.ToTable("PredstavaRepertoar");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Repertoar).WithMany(p => p.PredstavaRepertoars)
                .HasForeignKey(d => d.RepertoarId)
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Predstava).WithMany(p => p.PredstavaRepertoars)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<PredstavaZanr>(entity =>
        {
            entity.HasKey(e => e.PredstavaZanrId).HasName("PK__Predstav__67D6222F83EF3DAA");

            entity.ToTable("PredstavaZanr");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Predstava).WithMany(p => p.PredstavaZanrs)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKPredstavaZ211544");

            entity.HasOne(d => d.Zanr).WithMany(p => p.PredstavaZanrs)
                .HasForeignKey(d => d.ZanrId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKPredstavaZ6500");
        });

        modelBuilder.Entity<Repertoar>(entity =>
        {
            entity.HasKey(e => e.RepertoarId).HasName("PK__Repertoa__1018CC45DC2374D2");

            entity.ToTable("Repertoar");

            entity.Property(e => e.DatumKraja).HasColumnType("datetime");
            entity.Property(e => e.DatumPocetka).HasColumnType("datetime");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis)
                .HasMaxLength(500)
                .IsUnicode(false);

            entity.HasMany(d => d.PredstavaRepertoars).WithOne(p => p.Repertoar)
                .HasForeignKey(d => d.RepertoarId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Rezervacija>(entity =>
        {
            entity.HasKey(e => e.RezervacijaId).HasName("PK__Rezervac__CABA44DDDA32E40D");

            entity.ToTable("Rezervacija");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKRezervacij849203");

            entity.HasOne(d => d.Termin).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.RezervacijaId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Sjediste>(entity =>
        {
            entity.HasKey(e => e.SjedisteId).HasName("PK__Sjediste__B2086AAA0744C421");

            entity.ToTable("Sjediste");

            entity.Property(e => e.Kolona)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Red)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Dvorana).WithMany(p => p.Sjedistes)
                .HasForeignKey(d => d.DvoranaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKSjediste19417");

            entity.HasMany(d => d.RezervacijaSjedistes).WithOne(p => p.Sjediste)
                .HasForeignKey(d => d.SjedisteId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKSjediste277089");

            entity.HasMany(d => d.Karta).WithOne(p => p.Sjediste)
                .HasForeignKey(d => d.SjedisteId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<RezervacijaSjediste>(entity =>
        {
            entity.HasKey(e => e.RezervacijaSjedisteId);

            entity.Property(e => e.RezervacijaSjedisteId)
                .ValueGeneratedOnAdd();

            entity.ToTable("RezervacijaSjediste");

            entity.HasOne(d => d.Rezervacija)
                .WithMany(p => p.RezervacijaSjedistes) 
                .HasForeignKey(d => d.RezervacijaId)   
                .OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Sjediste)
                .WithMany(p => p.RezervacijaSjedistes)  
                .HasForeignKey(d => d.SjedisteId)  
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<StavkaUplate>(entity =>
        {
            entity.HasKey(e => e.StavkaUplateId).HasName("PK__StavkaUp__BFAFD85965F23692");

            entity.ToTable("StavkaUplate");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.Property(e => e.Cijena)
                .HasPrecision(18, 2);

            entity.HasOne(d => d.Uplata).WithMany(p => p.StavkaUplates)
                .HasForeignKey(d => d.UplataId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKStavkaUpla481381");
        });

        modelBuilder.Entity<Termin>(entity =>
        {
            entity.HasKey(e => e.TerminId).HasName("PK__Termin__42126C95643B31F8");

            entity.ToTable("Termin");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Dvorana).WithMany(p => p.Termins)
                .HasForeignKey(d => d.DvoranaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKTermin31281");

            entity.HasOne(d => d.Predstava).WithMany(p => p.Termins)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKTermin545750");

            entity.HasMany(d => d.Rezervacijas).WithOne(p => p.Termin)
                .HasForeignKey(d => d.TerminId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.HasKey(e => e.UlogaId).HasName("PK__Uloga__DCAB23CBA4EF472E");

            entity.ToTable("Uloga");

            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<Uplatum>(entity =>
        {
            entity.HasKey(e => e.UplataId).HasName("PK__Uplata__C5B165E69C3A436D");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.Property(e => e.Iznos)
                .HasPrecision(18, 2);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Uplata)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKUplata894550");

            entity.Property(e => e.TransakcijaId)
                .HasColumnType("nvarchar(max)")
                .IsRequired(false);

            entity.Property(e => e.NacinPlacanja)
                .HasColumnType("nvarchar(max)")
                .IsRequired(false);

            entity.Property(e => e.Status)
                .HasColumnType("nvarchar(max)")
                .IsRequired(false);
        });

        modelBuilder.Entity<Vijest>(entity =>
        {
            entity.HasKey(e => e.VijestId).HasName("PK__Vijest__F619121C860AB937");

            entity.ToTable("Vijest");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Sadrzaj)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Vijests)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKVijest785774");
        });

        modelBuilder.Entity<Zanr>(entity =>
        {
            entity.HasKey(e => e.ZanrId).HasName("PK__Zanr__953868D37E250D1A");

            entity.ToTable("Zanr");

            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        try
        {
            Console.WriteLine("Seed podataka");
            modelBuilder.Seed();
        }
        catch (Exception ex)
        {
            Console.WriteLine("Greška");
        }
        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

public static class ModelBuilderExtensions
{
    public static void Seed(this ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Dvorana>().HasData(
            new Dvorana
            {
                DvoranaId = 1,
                Naziv = "Dvorana 1",
                Kapacitet = 49,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Dvorana
            {
                DvoranaId = 2,
                Naziv = "Dvorana 2",
                Kapacitet = 36,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Dvorana
            {
                DvoranaId = 3,
                Naziv = "Dvorana 3",
                Kapacitet = 25,
                IsDeleted = false,
                VrijemeBrisanja = null
            }
        );
        modelBuilder.Entity<Glumac>().HasData(
            new Glumac
            {
                GlumacId = 1,
                Ime = "Leonardo",
                Prezime = "DiCaprio",
                Biografija = "Leonardo DiCaprio je američki glumac i producent, poznat po ulogama u filmovima kao što su 'Titanic', 'Inception', 'The Revenant' i 'The Wolf of Wall Street'. Dobitnik je Oskara i ekološki aktivista.",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Glumac
            {
                GlumacId = 2,
                Ime = "Johnny",
                Prezime = "Depp",
                Biografija = "Johnny Depp je američki glumac poznat po ekscentričnim i upečatljivim ulogama, posebno kao kapetan Jack Sparrow. Njegova karijera traje više od tri decenije.",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Glumac
            {
                GlumacId = 3,
                Ime = "Mustafa",
                Prezime = "Nadarević",
                Biografija = "Mustafa Nadarević bio je jedan od najcjenjenijih glumaca bivše Jugoslavije. Poznat po ulogama u filmovima, serijama i pozorištu, ostavio je dubok trag u kulturi regije, naročito ulogom Izeta Fazlinovića.",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Glumac
            {
                GlumacId = 4,
                Ime = "Emir",
                Prezime = "Hadžihafizbegović",
                Biografija = "Emir Hadžihafizbegović je jedan od najpoznatijih glumaca u BiH. Igrao je u brojnim filmovima i serijama u regiji, a poznat je po izražajnoj glumi i snažnim dramskim ulogama.",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Glumac
            {
                GlumacId = 5,
                Ime = "Ermin",
                Prezime = "Bravo",
                Biografija = "Ermin Bravo je nagrađivani glumac iz BiH koji je ostvario značajne uloge u domaćim i međunarodnim filmovima. Takođe je aktivan u pozorištu i kao reditelj.",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Glumac
            {
                GlumacId = 6,
                Ime = "Senad",
                Prezime = "Bašić",
                Biografija = "Senad Bašić je bosanskohercegovački glumac i univerzitetski profesor. Poznat je po bogatom glumačkom opusu, naročito po ulozi Faruka u seriji 'Lud, zbunjen, normalan'.",
                IsDeleted = false,
                VrijemeBrisanja = null
            }
        );
        modelBuilder.Entity<Kartum>().HasData(
            new Kartum { KartaId = 1, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 22, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 2 },
            new Kartum { KartaId = 2, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 22, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 3 },
            new Kartum { KartaId = 3, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 30, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = false, SjedisteId = 89 },
            new Kartum { KartaId = 4, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 30, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = false, SjedisteId = 90 },
            new Kartum { KartaId = 5, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 60, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 10 },
            new Kartum { KartaId = 6, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 60, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 11 },
            new Kartum { KartaId = 7, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 81, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 90 },
            new Kartum { KartaId = 8, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 82, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 15 },
            new Kartum { KartaId = 9, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 83, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 60 },
            new Kartum { KartaId = 10, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 84, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 100 },
            new Kartum { KartaId = 11, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 85, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 11 },
            new Kartum { KartaId = 12, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 86, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 70 },
            new Kartum { KartaId = 13, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 87, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 99 },
            new Kartum { KartaId = 14, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 88, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 25 },
            new Kartum { KartaId = 15, Cijena = 10, IsDeleted = false, VrijemeBrisanja = null, TerminId = 89, RezervacijaId = null, KorisnikId = 2, ukljucenaHrana = true, SjedisteId = 75 }

        );
        modelBuilder.Entity<Korisnik>().HasData(
            new Korisnik
            {
                KorisnikId = 1,
                Ime = "Admin",
                Prezime = "Admin",
                Email = "admin@eteatar.com",
                Telefon = "+60456456",
                KorisnickoIme = "admin",
                LozinkaHash = "Agw/bMTUSAFhUokkvB7TO8MCeog=",
                LozinkaSalt = "U3/wrAznwLRJH55vtPWHew==",
                DatumRodenja = DateTime.Parse("2002-01-01 00:00:00.000"),
                DatumRegistracije = DateTime.Parse("2025-05-13 00:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                Slika = null
            },
            new Korisnik
            {
                KorisnikId = 2,
                Ime = "Mobile",
                Prezime = "Mobile",
                Email = "mobile@eteatar.com",
                Telefon = "+60123123",
                KorisnickoIme = "mobile",
                LozinkaHash = "PT2xyqoSvBlVw+JOSdhqKTMTyWs=",
                LozinkaSalt = "pebmamqt/rufY8AszeYBbw==",
                DatumRodenja = DateTime.Parse("2001-01-01 00:00:00.000"),
                DatumRegistracije = DateTime.Parse("2025-05-13 00:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                Slika = null
            }
        );
        modelBuilder.Entity<Database.Ocjena>().HasData(
            new Ocjena
            {
                OcjenaId = 1,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 4,
                Komentar = "Odlična predstava!",
                DatumKreiranja = DateTime.Parse("2025-05-09 18:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 1
            },
            new Ocjena
            {
                OcjenaId = 2,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 5,
                Komentar = "Gluma fantastična, priča zanimljiva.",
                DatumKreiranja = DateTime.Parse("2025-05-10 15:30:00.000"),
                KorisnikId = 1,
                PredstavaId = 2
            },
            new Ocjena
            {
                OcjenaId = 3,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 3,
                Komentar = "Dobar pokušaj, ali može bolje.",
                DatumKreiranja = DateTime.Parse("2025-05-11 16:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 3
            },
            new Ocjena
            {
                OcjenaId = 4,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 5,
                Komentar = "Bravo za produkciju i režiju!",
                DatumKreiranja = DateTime.Parse("2025-05-12 11:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 4
            },
            new Ocjena
            {
                OcjenaId = 5,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 4,
                Komentar = "Veoma emotivno i snažno.",
                DatumKreiranja = DateTime.Parse("2025-05-12 14:45:00.000"),
                KorisnikId = 1,
                PredstavaId = 5
            },
            new Ocjena
            {
                OcjenaId = 6,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 5,
                Komentar = "Svaka čast glumcima!",
                DatumKreiranja = DateTime.Parse("2025-05-10 12:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 1
            },
            new Ocjena
            {
                OcjenaId = 7,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 3,
                Komentar = "Solidno, ali nije ostavilo jak utisak.",
                DatumKreiranja = DateTime.Parse("2025-05-11 13:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 2
            },
            new Ocjena
            {
                OcjenaId = 8,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 4,
                Komentar = "Zanimljiva priča i dobar ritam.",
                DatumKreiranja = DateTime.Parse("2025-05-11 14:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 4
            },
            new Ocjena
            {
                OcjenaId = 9,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Vrijednost = 4,
                Komentar = "Režija i scenografija vrhunski odrađeni.",
                DatumKreiranja = DateTime.Parse("2025-05-12 15:00:00.000"),
                KorisnikId = 1,
                PredstavaId = 9
            }
        );
        modelBuilder.Entity<Predstava>().HasData(
            new Predstava
            {
                PredstavaId = 1,
                Naziv = "Ajmo na fuka",
                Opis = "Predstava govori o odnosu dvojice vojnika, pripadnika Hrvatskog vijeca odbrane i Armije Republike Bosne i Hercegovine.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 2,
                Naziv = "Ne igraj na engleze",
                Opis = "Tri prijatelja. Tri kladionicara. Tri suprotstavljena uloga. Jedna utakmica. I ta jedna utakmica bi trebala da riješi sve njihove probleme. I umjesto da ih riješi, ta utakmica ce pokrenuti razgovor o svim problemima u njihovim medusobnim odnosima.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 3,
                Naziv = "Audicija",
                Opis = "Kultna komedija koja je postala klasik bivše Jugoslavije",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 4,
                Naziv = "Legenda o Ali-paši",
                Opis = "Osnovni kostur ili skelet priče Legende o Ali-paši predstavlja preobrazba Alije Leptira od hamala do visokog dostojanstvenika. Ta se preobrazba prvo zbiva u snu, a onda i zbiljski ostvaruje u njegovom životu. ",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 5,
                Naziv = "Balkanski špijun",
                Opis = "Balkanski špijun, kultni je naslov čiji su citati postali dio opće kulture i ušli u usmenu predaju kao suvenir iz vremena, sustava vrijednosti i života ljudi od kojeg se udaljavamo posljednjih četrdesetak godina ili bar tako vjerujemo.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 6,
                Naziv = "Identitluk",
                Opis = "Kad danas u Bosni i Hercegovini citamo eseje francuskog Libanonca Amina Maaloufa napisane prije dvadesetak godina, cine se tako inspirativni i na svakoj drugoj stranici imamo potrebu glasno se s autorom složiti.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 7,
                Naziv = "Zbogom, Kalifornijo!",
                Opis = "Predstava je, kao i tekst, zamišljena kao posveta svim Mostarcima, onima koji su ostali u gradu i onima koji su ga napustili, ali i onima koji ga i dalje napuštaju, i onome što je nekada bio i što je sada grad Mostar.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 8,
                Naziv = "Ludilo u ...",
                Opis = "Ludilo u... je predstava u kojoj tretiramo Joneskov predložak kao polaznu tacku za predstavu koja se bavi zajednicom izmedu muškarca i žene. Koliko se pojam zajednice promijenio i koliko je drugaciji danas? Koliko geografija u tome ima udjela? Da li je danas zajednica zapravo samo klasno pitanje? ",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 9,
                Naziv = "Kokoška",
                Opis = "Ovaj izuzetno zanimljivi tekst opisuje intimu života glumaca i glumica, život iza kulisa i postavlja pitanje: gdje je i da li se uopće može povući jasna distinkcija između teatra i života.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Predstava
            {
                PredstavaId = 10, 
                Naziv = "Hasanaginica",
                Opis = "Hasanaginica je jedna brutalno iskrena predstava. Svi ti likovi i svi ti zapleti, svaki sukob i svaka kap ljudskosti, iscijeđena je iz iskustva nas samih, članova ekipe koja je stvorila djelo.",
                Produkcija = "Leon Lucic",
                Scenografija = "Ivan Primorac",
                Koreografija = "Fadil Opancic",
                Trajanje = 120,
                Cijena = 10,
                Slika = null,
                IsDeleted = false,
                VrijemeBrisanja = null
            }
        );
        modelBuilder.Entity<Repertoar>().HasData(
            new Repertoar
            {
                RepertoarId = 1,
                Naziv = "Repertoar 1",
                Opis = "Repertoar 1",
                DatumPocetka = DateTime.Parse("2026-05-13 00:00:00.000"),
                DatumKraja = DateTime.Parse("2026-06-13 00:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Repertoar
            {
                RepertoarId = 2,
                Naziv = "Repertoar 2",
                Opis = "Repertoar 2",
                DatumPocetka = DateTime.Parse("2026-06-13 00:00:00.000"),
                DatumKraja = DateTime.Parse("2026-07-13 00:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Repertoar
            {
                RepertoarId = 3,
                Naziv = "Repertoar 3",
                Opis = "Repertoar 3",
                DatumPocetka = DateTime.Parse("2026-07-13 00:00:00.000"),
                DatumKraja = DateTime.Parse("2026-08-13 00:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null
            }
        );
        modelBuilder.Entity<Rezervacija>().HasData(
            new Rezervacija
            { 
                RezervacijaId = 1,
                KorisnikId = 2,
                TerminId = 3,
                IsDeleted = false,
                VrijemeBrisanja = null, 
                StateMachine = "Kreirano"
            },
            new Rezervacija
            {
                RezervacijaId = 2,
                KorisnikId = 2,
                TerminId = 5,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Kreirano"
            },
            new Rezervacija
            {
                RezervacijaId = 3,
                KorisnikId = 2,
                TerminId = 7,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Kreirano"
            },
            new Rezervacija
            {
                RezervacijaId = 4,
                KorisnikId = 2,
                TerminId = 10,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Odobreno"
            },
            new Rezervacija
            {
                RezervacijaId = 5,
                KorisnikId = 2,
                TerminId = 12,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Odobreno"
            },
            new Rezervacija
            {
                RezervacijaId = 6,
                KorisnikId = 2,
                TerminId = 15,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Odobreno"
            },
            new Rezervacija
            {
                RezervacijaId = 7,
                KorisnikId = 2,
                TerminId = 20,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Ponisteno"
            },
            new Rezervacija
            {
                RezervacijaId = 8,
                KorisnikId = 2,
                TerminId = 22,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Zavrseno"
            },
            new Rezervacija
            {
                RezervacijaId = 9,
                KorisnikId = 2,
                TerminId = 30,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Zavrseno"
            },
            new Rezervacija
            {
                RezervacijaId = 10,
                KorisnikId = 2,
                TerminId = 46,
                IsDeleted = false,
                VrijemeBrisanja = null,
                StateMachine = "Zavrseno"
            }

        );
        modelBuilder.Entity<Sjediste>().HasData(
            new Sjediste { SjedisteId = 1, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 2, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 3, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 4, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 5, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 6, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 7, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 8, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 9, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 10, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 11, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 12, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 13, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 14, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 15, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 16, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 17, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 18, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 19, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 20, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 21, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 22, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 23, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 24, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 25, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 26, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 27, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 28, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 29, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 30, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 31, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 32, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 33, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 34, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 35, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 36, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 37, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 38, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 39, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 40, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 41, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 42, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 43, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "1", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 44, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "2", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 45, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "3", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 46, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "4", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 47, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "5", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 48, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "6", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 49, IsDeleted = false, VrijemeBrisanja = null, Red = "G", Kolona = "7", Status = "Aktivno", DvoranaId = 1 },
            new Sjediste { SjedisteId = 50, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 51, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 52, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 53, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 54, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 55, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 56, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 57, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 58, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 59, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 60, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 61, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 62, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 63, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 64, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 65, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 66, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 67, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 68, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 69, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 70, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 71, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 72, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 73, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 74, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 75, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 76, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 77, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 78, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 79, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 80, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "1", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 81, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "2", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 82, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "3", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 83, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "4", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 84, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "5", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 85, IsDeleted = false, VrijemeBrisanja = null, Red = "F", Kolona = "6", Status = "Aktivno", DvoranaId = 2 },
            new Sjediste { SjedisteId = 86, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "1", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 87, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "2", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 88, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "3", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 89, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "4", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 90, IsDeleted = false, VrijemeBrisanja = null, Red = "A", Kolona = "5", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 91, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "1", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 92, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "2", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 93, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "3", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 94, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "4", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 95, IsDeleted = false, VrijemeBrisanja = null, Red = "B", Kolona = "5", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 96, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "1", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 97, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "2", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 98, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "3", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 99, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "4", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 100, IsDeleted = false, VrijemeBrisanja = null, Red = "C", Kolona = "5", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 101, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "1", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 102, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "2", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 103, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "3", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 104, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "4", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 105, IsDeleted = false, VrijemeBrisanja = null, Red = "D", Kolona = "5", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 106, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "1", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 107, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "2", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 108, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "3", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 109, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "4", Status = "Aktivno", DvoranaId = 3 },
            new Sjediste { SjedisteId = 110, IsDeleted = false, VrijemeBrisanja = null, Red = "E", Kolona = "5", Status = "Aktivno", DvoranaId = 3 }


        );
        modelBuilder.Entity<StavkaUplate>().HasData(
            new StavkaUplate
            {
                StavkaUplateId = 1,
                UplataId = 1,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 20,
                Kolicina = 2
            },
            new StavkaUplate
            {
                StavkaUplateId = 2,
                UplataId = 2,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 10,
                Kolicina = 1
            },
            new StavkaUplate
            {
                StavkaUplateId = 3,
                UplataId = 3,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 30,
                Kolicina = 3
            },
            new StavkaUplate
            {
                StavkaUplateId = 4,
                UplataId = 4,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 20,
                Kolicina = 2
            },
            new StavkaUplate
            {
                StavkaUplateId = 5,
                UplataId = 5,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 10,
                Kolicina = 1
            },
            new StavkaUplate
            {
                StavkaUplateId = 6,
                UplataId = 6,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Cijena = 20,
                Kolicina = 2
            }
        );
        modelBuilder.Entity<Termin>().HasData(
            new Termin { TerminId = 1, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 1 },
            new Termin { TerminId = 2, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 1 },
            new Termin { TerminId = 3, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 1 },
            new Termin { TerminId = 4, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 1 },
            new Termin { TerminId = 5, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 1 },
            new Termin { TerminId = 6, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 1 },
            new Termin { TerminId = 7, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 2 },
            new Termin { TerminId = 8, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 2 },
            new Termin { TerminId = 9, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 2 },
            new Termin { TerminId = 10, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 2 },
            new Termin { TerminId = 11, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 2 },
            new Termin { TerminId = 12, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 2 },
            new Termin { TerminId = 13, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 3 },
            new Termin { TerminId = 14, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 3 },
            new Termin { TerminId = 15, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 3 },
            new Termin { TerminId = 16, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 3 },
            new Termin { TerminId = 17, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 3 },
            new Termin { TerminId = 18, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 3 },
            new Termin { TerminId = 19, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 4 },
            new Termin { TerminId = 20, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 4 },
            new Termin { TerminId = 21, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 4 },
            new Termin { TerminId = 22, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 4 },
            new Termin { TerminId = 23, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 4 },
            new Termin { TerminId = 24, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 4 },
            new Termin { TerminId = 25, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 5 },
            new Termin { TerminId = 26, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 5 },
            new Termin { TerminId = 27, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 5 },
            new Termin { TerminId = 28, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 5 },
            new Termin { TerminId = 29, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 5 },
            new Termin { TerminId = 30, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 5 },
            new Termin { TerminId = 31, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 6 },
            new Termin { TerminId = 32, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 6 },
            new Termin { TerminId = 33, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 6 },
            new Termin { TerminId = 34, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 6 },
            new Termin { TerminId = 35, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 6 },
            new Termin { TerminId = 36, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 6 },
            new Termin { TerminId = 37, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 7 },
            new Termin { TerminId = 38, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 7 },
            new Termin { TerminId = 39, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 7 },
            new Termin { TerminId = 40, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 7 },
            new Termin { TerminId = 41, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 7 },
            new Termin { TerminId = 42, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 7 },
            new Termin { TerminId = 43, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 8 },
            new Termin { TerminId = 44, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 8 },
            new Termin { TerminId = 45, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 8 },
            new Termin { TerminId = 46, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 8 },
            new Termin { TerminId = 47, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 8 },
            new Termin { TerminId = 48, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 8 },
            new Termin { TerminId = 49, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 9 },
            new Termin { TerminId = 50, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 9 },
            new Termin { TerminId = 51, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 9 },
            new Termin { TerminId = 52, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 9 },
            new Termin { TerminId = 53, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 9 },
            new Termin { TerminId = 54, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 9 },
            new Termin { TerminId = 55, Datum = DateTime.Parse("2026-06-01 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 10 },
            new Termin { TerminId = 56, Datum = DateTime.Parse("2026-06-01 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 10 },
            new Termin { TerminId = 57, Datum = DateTime.Parse("2026-06-01 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 10 },
            new Termin { TerminId = 58, Datum = DateTime.Parse("2026-06-02 18:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 10 },
            new Termin { TerminId = 59, Datum = DateTime.Parse("2026-06-02 20:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 10 },
            new Termin { TerminId = 60, Datum = DateTime.Parse("2026-06-02 22:00:00.000"), Status = "Aktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 10 },
            new Termin { TerminId = 81, Datum = DateTime.Parse("2025-05-01 22:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 1 },
            new Termin { TerminId = 82, Datum = DateTime.Parse("2025-04-02 18:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 2 },
            new Termin { TerminId = 83, Datum = DateTime.Parse("2025-05-02 20:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 3 },
            new Termin { TerminId = 84, Datum = DateTime.Parse("2025-04-02 22:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 4 },
            new Termin { TerminId = 85, Datum = DateTime.Parse("2025-05-01 18:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 5 },
            new Termin { TerminId = 86, Datum = DateTime.Parse("2025-04-01 20:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 1 },
            new Termin { TerminId = 87, Datum = DateTime.Parse("2025-05-01 22:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 3, PredstavaId = 2 },
            new Termin { TerminId = 88, Datum = DateTime.Parse("2025-04-02 18:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 1, PredstavaId = 4 },
            new Termin { TerminId = 89, Datum = DateTime.Parse("2025-05-02 20:00:00.000"), Status = "Neaktivan", IsDeleted = false, VrijemeBrisanja = null, DvoranaId = 2, PredstavaId = 9 }
              
        );
        modelBuilder.Entity<Uloga>().HasData(
            new Uloga
            {
                UlogaId = 1,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Naziv = "Admin",
                Opis = "Admin",
            },
            new Uloga
            {
                UlogaId = 2,
                IsDeleted = false,
                VrijemeBrisanja = null,
                Naziv = "Gledaoc",
                Opis = "Gledaoc",
            }
        );
        modelBuilder.Entity<Uplatum>().HasData(
            new Uplatum
            {
                UplataId = 1,
                Iznos = 20,
                Datum = DateTime.Parse("2025-05-11 18:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANRCPQ2PU03219CF299124H"
            },
            new Uplatum
            {
                UplataId = 2,
                Iznos = 10,
                Datum = DateTime.Parse("2025-05-12 18:30:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANRBLQ8FY05110WM3521649"
            },
            new Uplatum
            {
                UplataId = 3,
                Iznos = 30,
                Datum = DateTime.Parse("2025-05-12 19:30:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANRAJY10H05677AU1376209"
            },
            new Uplatum
            {
                UplataId = 4,
                Iznos = 20,
                Datum = DateTime.Parse("2025-05-13 18:30:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANGBNY0AX857222G028802W"
            },
            new Uplatum
            {
                UplataId = 5,
                Iznos = 10,
                Datum = DateTime.Parse("2025-05-13 19:15:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANGA5A71R48042FP1805639"
            },
            new Uplatum
            {
                UplataId = 6,
                Iznos = 20,
                Datum = DateTime.Parse("2025-05-13 21:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                NacinPlacanja = "Paypal",
                Status = "Approved",
                TransakcijaId = "PAYID-NANF7YI7AR60568FL8049816"
            }
        );
        modelBuilder.Entity<Vijest>().HasData(
            new Vijest
            {
                VijestId = 1,
                Naziv = "Otvorena nova sezona teatra",
                Sadrzaj = "Zvanično je otvorena nova sezona u Narodnom teatru, a publiku očekuje bogat repertoar predstava tokom ljeta.",
                Datum = DateTime.Parse("2025-05-10 19:15:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2
            },
            new Vijest
            {
                VijestId = 2,
                Naziv = "Gostujuća predstava iz Njemacke",
                Sadrzaj = "Poznato pozorište iz Berlina gostuje naredne sedmice s predstavom 'Balkanski špijun'. Karte su već u prodaji.",
                Datum = DateTime.Parse("2025-05-11 17:00:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2
            },
            new Vijest
            {
                VijestId = 3,
                Naziv = "Radionica glume za mlade",
                Sadrzaj = "Teatar organizuje besplatnu radionicu glume za srednjoškolce. Prijave su otvorene do 20. maja.",
                Datum = DateTime.Parse("2025-05-12 14:30:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2
            },
            new Vijest
            {
                VijestId = 4,
                Naziv = "Humanitarna predstava za djecu",
                Sadrzaj = "U saradnji s lokalnim udruženjima, organizuje se predstava čiji će prihod biti doniran dječijem odjeljenju bolnice.",
                Datum = DateTime.Parse("2025-05-13 18:45:00.000"),
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2
            }
        );
        modelBuilder.Entity<Zanr>().HasData(
            new Zanr
            {
                ZanrId = 1,
                Naziv = "Komedija",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Zanr
            {
                ZanrId = 2,
                Naziv = "Drama",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Zanr
            {
                ZanrId = 3,
                Naziv = "Tragedija",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Zanr
            {
                ZanrId = 4,
                Naziv = "Mjuzikl",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Zanr
            {
                ZanrId = 5,
                Naziv = "Triler",
                IsDeleted = false,
                VrijemeBrisanja = null
            },
            new Zanr
            {
                ZanrId = 6,
                Naziv = "Satira",
                IsDeleted = false,
                VrijemeBrisanja = null
            }
        );
        modelBuilder.Entity<KorisnikUloga>().HasData(
            new KorisnikUloga
            {
                KorisnikUlogaId = 1,
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 1,
                UlogaId = 1
            },
            new KorisnikUloga
            {
                KorisnikUlogaId = 2,
                IsDeleted = false,
                VrijemeBrisanja = null,
                KorisnikId = 2,
                UlogaId = 2
            }
        );
        modelBuilder.Entity<PredstavaGlumac>().HasData(
            new PredstavaGlumac { PredstavaGlumacId = 1, PredstavaId = 1, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 2, PredstavaId = 1, GlumacId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 3, PredstavaId = 1, GlumacId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 4, PredstavaId = 2, GlumacId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 5, PredstavaId = 2, GlumacId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 6, PredstavaId = 3, GlumacId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 7, PredstavaId = 3, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 8, PredstavaId = 3, GlumacId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 9, PredstavaId = 4, GlumacId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 10, PredstavaId = 4, GlumacId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 11, PredstavaId = 5, GlumacId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 12, PredstavaId = 5, GlumacId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 13, PredstavaId = 5, GlumacId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 14, PredstavaId = 6, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 15, PredstavaId = 6, GlumacId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 16, PredstavaId = 6, GlumacId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 17, PredstavaId = 7, GlumacId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 18, PredstavaId = 7, GlumacId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 19, PredstavaId = 8, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 20, PredstavaId = 8, GlumacId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 21, PredstavaId = 8, GlumacId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 22, PredstavaId = 8, GlumacId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 23, PredstavaId = 9, GlumacId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 24, PredstavaId = 9, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 25, PredstavaId = 10, GlumacId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 26, PredstavaId = 10, GlumacId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 27, PredstavaId = 10, GlumacId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 28, PredstavaId = 10, GlumacId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaGlumac { PredstavaGlumacId = 29, PredstavaId = 10, GlumacId = 1, IsDeleted = false, VrijemeBrisanja = null }
        );
        modelBuilder.Entity<PredstavaRepertoar>().HasData(
            new PredstavaRepertoar { PredstavaRepertoarId = 1, PredstavaId = 1, RepertoarId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 2, PredstavaId = 2, RepertoarId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 3, PredstavaId = 3, RepertoarId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 4, PredstavaId = 2, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 5, PredstavaId = 3, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 6, PredstavaId = 4, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 7, PredstavaId = 5, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 8, PredstavaId = 6, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 9, PredstavaId = 7, RepertoarId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 10, PredstavaId = 3, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 11, PredstavaId = 4, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 12, PredstavaId = 5, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 13, PredstavaId = 6, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 14, PredstavaId = 7, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 15, PredstavaId = 8, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 16, PredstavaId = 9, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaRepertoar { PredstavaRepertoarId = 17, PredstavaId = 1, RepertoarId = 3, IsDeleted = false, VrijemeBrisanja = null }
        );
        modelBuilder.Entity<PredstavaZanr>().HasData(
            new PredstavaZanr { PredstavaZanrId = 1, PredstavaId = 1, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 2, PredstavaId = 1, ZanrId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 3, PredstavaId = 2, ZanrId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 4, PredstavaId = 2, ZanrId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 5, PredstavaId = 3, ZanrId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 6, PredstavaId = 3, ZanrId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 7, PredstavaId = 3, ZanrId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 8, PredstavaId = 4, ZanrId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 9, PredstavaId = 4, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 10, PredstavaId = 5, ZanrId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 11, PredstavaId = 5, ZanrId = 1, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 12, PredstavaId = 6, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 13, PredstavaId = 7, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 14, PredstavaId = 7, ZanrId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 15, PredstavaId = 8, ZanrId = 5, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 16, PredstavaId = 8, ZanrId = 4, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 17, PredstavaId = 9, ZanrId = 6, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 18, PredstavaId = 9, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 19, PredstavaId = 10, ZanrId = 3, IsDeleted = false, VrijemeBrisanja = null },
            new PredstavaZanr { PredstavaZanrId = 20, PredstavaId = 10, ZanrId = 2, IsDeleted = false, VrijemeBrisanja = null }
);
        modelBuilder.Entity<RezervacijaSjediste>().HasData(
            new RezervacijaSjediste{ RezervacijaSjedisteId = 1, RezervacijaId = 1, SjedisteId = 86, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 2, RezervacijaId = 2, SjedisteId = 55, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 3, RezervacijaId = 3, SjedisteId = 23, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 4, RezervacijaId = 4, SjedisteId = 9, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 5, RezervacijaId = 5, SjedisteId = 98, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 6, RezervacijaId = 6, SjedisteId = 94, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 7, RezervacijaId = 7, SjedisteId = 68, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 8, RezervacijaId = 8, SjedisteId = 31, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 9, RezervacijaId = 9, SjedisteId = 101, IsDeleted = false, VrijemeBrisanja = null },
            new RezervacijaSjediste { RezervacijaSjedisteId = 10, RezervacijaId = 10, SjedisteId = 44, IsDeleted = false, VrijemeBrisanja = null }
        );
    }
}
