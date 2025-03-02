using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Repertoar
{
    public int ReperatoarId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public DateTime DatumPocetka { get; set; }

    public DateTime DatumKraja { get; set; }

    public bool IsDeleted { get; set; }

    public int? VrijemeBrisanja { get; set; }

    public int PredstavaId { get; set; }

    public virtual Predstava Predstava { get; set; } = null!;
}
