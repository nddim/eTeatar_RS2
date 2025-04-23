using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class PredstavaGlumac : ISoftDelete
{
    public int PredstavaGlumacId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int PredstavaId { get; set; }

    public int GlumacId { get; set; }

    public virtual Glumac Glumac { get; set; } = null!;

    public virtual Predstava Predstava { get; set; } = null!;
}
