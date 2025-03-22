using System;
using System.Collections.Generic;

namespace eTeatar.Model
{
    public partial class Uloga
    {
        public int UlogaId { get; set; }

        public string Naziv { get; set; }

        public string Opis { get; set; } 

        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();
    }
}


