using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Hrana
{
    public int HranaId { get; set; }

    public string Naziv { get; set; } = null!;

    public decimal Cijena { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<StavkaUplate> StavkaUplates { get; set; } = new List<StavkaUplate>();
}
