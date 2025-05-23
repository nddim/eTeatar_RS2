﻿using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Uplatum : ISoftDelete
{
    public int UplataId { get; set; }

    public decimal Iznos { get; set; }

    public DateTime Datum { get; set; }

    public string? TransakcijaId { get; set; }

    public string? NacinPlacanja { get; set; }

    public string? Status { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<StavkaUplate> StavkaUplates { get; set; } = new List<StavkaUplate>();
}
