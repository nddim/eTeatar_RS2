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

    public virtual DbSet<Hrana> Hranas { get; set; }

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

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost,1433;Initial Catalog=eTeatar;User=sa;Password=ASDqwe123!;TrustServerCertificate=True");

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
                .IsUnicode(false);
            entity.Property(e => e.Ime)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Prezime)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<Hrana>(entity =>
        {
            entity.HasKey(e => e.HranaId).HasName("PK__Hrana__19AD0AEA4B1C6010");

            entity.ToTable("Hrana");

            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
        });

        modelBuilder.Entity<Kartum>(entity =>
        {
            entity.HasKey(e => e.KartaId).HasName("PK__Karta__EC3FA9EEAD399E80");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Karta)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKKarta115096");

            entity.HasOne(d => d.Rezervacija).WithMany(p => p.Karta)
                .HasForeignKey(d => d.RezervacijaId)
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
                .IsUnicode(false);
            entity.Property(e => e.KorisnickoIme)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LozinkaHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LozinkaSalt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Prezime)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Slika).HasMaxLength(2000);
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
            entity.Property(e => e.Ocjena1).HasColumnName("Ocjena");
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
            entity.Property(e => e.Slika).HasMaxLength(2000);
            entity.Property(e => e.TrajanjeKraj).HasColumnType("datetime");
            entity.Property(e => e.TrajanjePocetak).HasColumnType("datetime");
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");
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
            entity.HasKey(e => e.ReperatoarId).HasName("PK__Repertoa__1018CC45DC2374D2");

            entity.ToTable("Repertoar");

            entity.Property(e => e.DatumKraja).HasColumnType("datetime");
            entity.Property(e => e.DatumPocetka).HasColumnType("datetime");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis)
                .HasMaxLength(500)
                .IsUnicode(false);

            entity.HasOne(d => d.Predstava).WithMany(p => p.Repertoars)
                .HasForeignKey(d => d.PredstavaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKRepertoar158564");
        });

        modelBuilder.Entity<Rezervacija>(entity =>
        {
            entity.HasKey(e => e.RezervacijaId).HasName("PK__Rezervac__CABA44DDDA32E40D");

            entity.ToTable("Rezervacija");

            entity.Property(e => e.Status)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Rezervacijas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKRezervacij849203");
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

            entity.HasOne(d => d.Rezervacija).WithMany(p => p.Sjedistes)
                .HasForeignKey(d => d.RezervacijaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKSjediste277089");
        });

        modelBuilder.Entity<StavkaUplate>(entity =>
        {
            entity.HasKey(e => e.StavkaUplateId).HasName("PK__StavkaUp__BFAFD85965F23692");

            entity.ToTable("StavkaUplate");

            entity.Property(e => e.VrijemeBrisanja).HasColumnType("datetime");

            entity.HasOne(d => d.Hrana).WithMany(p => p.StavkaUplates)
                .HasForeignKey(d => d.HranaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKStavkaUpla569574");

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

            entity.HasOne(d => d.Rezervacija).WithMany(p => p.Termins)
                .HasForeignKey(d => d.RezervacijaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKTermin288953");
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

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Uplata)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKUplata894550");
        });

        modelBuilder.Entity<Vijest>(entity =>
        {
            entity.HasKey(e => e.VijestId).HasName("PK__Vijest__F619121C860AB937");

            entity.ToTable("Vijest");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Sadržaj)
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
            entity.Property(e => e.VrijemeBriisanja).HasColumnType("datetime");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
