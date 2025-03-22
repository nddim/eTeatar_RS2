using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Repertoar
{
    public int RepertoarId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public DateTime DatumPocetka { get; set; }

    public DateTime DatumKraja { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<PredstavaRepertoar> PredstavaRepertoars { get; set; } = new List<PredstavaRepertoar>();
}
