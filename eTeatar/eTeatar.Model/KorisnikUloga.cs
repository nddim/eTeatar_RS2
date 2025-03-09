using System;
using System.Collections.Generic;

namespace eTeatar.Model
{
    public partial class KorisnikUloga
    {
        public int KorisnikUlogaId { get; set; }

        public bool IsDeleted { get; set; }

        public DateTime? VrijemeBrisanja { get; set; }

        public int KorisnikId { get; set; }

        public int UlogaId { get; set; }

        public virtual Uloga Uloga { get; set; } = null!;
    }
}


