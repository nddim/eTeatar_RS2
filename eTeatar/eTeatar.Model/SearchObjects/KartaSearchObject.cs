using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class KartaSearchObject : BaseSearchObject
    {
        public decimal? CijenaGTE { get; set; }
        public int? RezervacijaId { get; set; }
        public int? KorisnikId { get; set; }
        public int? TerminId { get; set; }


    }
}
