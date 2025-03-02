using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class PredstavaZanr
{
    public int PredstavaZanrId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int ZanrId { get; set; }

    public int PredstavaId { get; set; }

    public virtual Predstava Predstava { get; set; } = null!;

    public virtual Zanr Zanr { get; set; } = null!;
}
