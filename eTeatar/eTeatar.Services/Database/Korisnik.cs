using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Korisnik : ISoftDelete
{
    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Telefon { get; set; } = null!;

    public string KorisnickoIme { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public string LozinkaHash { get; set; } = null!;

    public string LozinkaSalt { get; set; } = null!;

    public DateTime DatumRodenja { get; set; }

    public DateTime DatumRegistracije { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<Kartum> Karta { get; set; } = new List<Kartum>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();

    public virtual ICollection<Ocjena> Ocjenas { get; set; } = new List<Ocjena>();

    public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();

    public virtual ICollection<Uplatum> Uplata { get; set; } = new List<Uplatum>();

    public virtual ICollection<Vijest> Vijests { get; set; } = new List<Vijest>();
}
