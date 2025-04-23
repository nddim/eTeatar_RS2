using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Termin : ISoftDelete
{
    public int TerminId { get; set; }

    public DateTime Datum { get; set; }

    public string Status { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int DvoranaId { get; set; }

    public int PredstavaId { get; set; }

    public virtual Dvorana Dvorana { get; set; } = null!;

    public virtual Predstava Predstava { get; set; } = null!;

    public virtual ICollection<Kartum> Karta { get; set; } = new List<Kartum>();

    public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();
}
