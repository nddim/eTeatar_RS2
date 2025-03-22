using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Ocjena
{
    public int OcjenaId { get; set; }

    public int Vrijednost { get; set; }

    public string Komentar { get; set; } = null!;

    public DateTime DatumKreiranja { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int PredstavaId { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Predstava Predstava { get; set; } = null!;
}
