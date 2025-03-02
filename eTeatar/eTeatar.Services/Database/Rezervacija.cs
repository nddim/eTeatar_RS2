using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Rezervacija
{
    public int RezervacijaId { get; set; }

    public string Status { get; set; } = null!;

    public int SjedisteId { get; set; }

    public int TerminId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int KorisnikId { get; set; }

    public virtual ICollection<Kartum> Karta { get; set; } = new List<Kartum>();

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<Sjediste> Sjedistes { get; set; } = new List<Sjediste>();

    public virtual ICollection<Termin> Termins { get; set; } = new List<Termin>();
}
