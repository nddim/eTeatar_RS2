using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Predstava : ISoftDelete
{
    public int PredstavaId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public DateTime TrajanjePocetak { get; set; }

    public DateTime TrajanjeKraj { get; set; }

    public string Produkcija { get; set; } = null!;

    public string Koreografija { get; set; } = null!;

    public string Scenografija { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public decimal Cijena { get; set; }

    public byte[]? Slika { get; set; }

    public virtual ICollection<Ocjena> Ocjenas { get; set; } = new List<Ocjena>();

    public virtual ICollection<PredstavaGlumac> PredstavaGlumacs { get; set; } = new List<PredstavaGlumac>();

    public virtual ICollection<PredstavaZanr> PredstavaZanrs { get; set; } = new List<PredstavaZanr>();

    public virtual ICollection<PredstavaRepertoar> PredstavaRepertoars { get; set; } = new List<PredstavaRepertoar>();

    public virtual ICollection<Termin> Termins { get; set; } = new List<Termin>();
}
