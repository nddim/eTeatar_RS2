using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Dvorana
{
    public int DvoranaId { get; set; }

    public string Naziv { get; set; } = null!;

    public int Kapacitet { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<Sjediste> Sjedistes { get; set; } = new List<Sjediste>();

    public virtual ICollection<Termin> Termins { get; set; } = new List<Termin>();
}
