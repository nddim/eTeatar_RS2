﻿using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class StavkaUplate
{
    public int StavkaUplateId { get; set; }

    public int Kolicina { get; set; }

    public decimal Cijena { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int HranaId { get; set; }

    public int UplataId { get; set; }

    public virtual Hrana Hrana { get; set; } = null!;

    public virtual Uplatum Uplata { get; set; } = null!;
}
