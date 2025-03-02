using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Glumac
{
    public int GlumacId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string Biografija { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<PredstavaGlumac> PredstavaGlumacs { get; set; } = new List<PredstavaGlumac>();
}
