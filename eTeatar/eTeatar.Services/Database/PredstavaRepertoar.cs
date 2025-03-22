using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public class PredstavaRepertoar
{
    public int PredstavaRepertoarId { get; set; }

    public int PredstavaId { get; set; }

    public int RepertoarId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public virtual Predstava Predstava { get; set; }

    public virtual Repertoar Repertoar { get; set; }

}
