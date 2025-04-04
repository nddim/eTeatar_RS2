﻿using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Rezervacija
{
    public int RezervacijaId { get; set; }

    public string Status { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int TerminId { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Termin Termin { get; set; } = null!;

    public virtual ICollection<Kartum> Karta { get; set; } = new List<Kartum>();

    public virtual ICollection<RezervacijaSjediste> RezervacijaSjedistes { get; set; } = new List<RezervacijaSjediste>();

}
