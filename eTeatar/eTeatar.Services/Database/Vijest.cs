using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class Vijest : ISoftDelete
{
    public int VijestId { get; set; }

    public string Naziv { get; set; } = null!;

    public string Sadrzaj { get; set; } = null!;

    public DateTime Datum { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;
}
