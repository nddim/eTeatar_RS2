using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Kartum
{
    public int KartaId { get; set; }

    public decimal Cijena { get; set; } 

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int SjedisteId { get; set; }

    public int TerminId { get; set; }

    public int? RezervacijaId { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Rezervacija? Rezervacija { get; set; } = null!;

    public virtual Sjediste Sjediste { get; set; } = null!;

    public virtual Termin Termin { get; set; } = null!;
}
