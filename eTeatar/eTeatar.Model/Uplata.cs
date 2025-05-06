using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Uplata
    {
        public int UplataId { get; set; }

        public decimal Iznos { get; set; }

        public string TransakcijaId { get; set; }

        public string NacinPlacanja { get; set; }

        public string Status { get; set; }

        public DateTime Datum { get; set; }

        public int KorisnikId { get; set; }

        public virtual ICollection<StavkaUplate> StavkaUplates { get; set; } = new List<StavkaUplate>();
    }
}
