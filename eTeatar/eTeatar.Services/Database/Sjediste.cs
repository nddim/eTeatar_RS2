using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Sjediste
{
    public int SjedisteId { get; set; }

    public string Red { get; set; } = null!;

    public string Kolona { get; set; } = null!;

    public string Status { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int DvoranaId { get; set; }

    public virtual Dvorana Dvorana { get; set; } = null!;

    public virtual ICollection<Kartum> Karta { get; set; } = new List<Kartum>();

    public virtual ICollection<RezervacijaSjediste> RezervacijaSjedistes { get; set; } = new List<RezervacijaSjediste>();
}
