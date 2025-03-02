using System;
using System.Collections.Generic;

namespace eTeatar.Services.Database;

public partial class KorisnikUloga
{
    public int KorisnikUlogaId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? VrijemeBrisanja { get; set; }

    public int KorisnikId { get; set; }

    public int UlogaId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Uloga Uloga { get; set; } = null!;
}
