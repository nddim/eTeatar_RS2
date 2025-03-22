using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Uplata
    {
        public int UplataId { get; set; }

        public float Iznos { get; set; }

        public DateTime Datum { get; set; }

        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; }

        public virtual ICollection<StavkaUplate> StavkaUplates { get; set; } = new List<StavkaUplate>();
    }
}
