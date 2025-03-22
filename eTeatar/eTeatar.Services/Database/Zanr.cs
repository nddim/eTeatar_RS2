using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Zanr
{
    public int ZanrId { get; set; }

    public string Naziv { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual ICollection<PredstavaZanr> PredstavaZanrs { get; set; } = new List<PredstavaZanr>();
}
