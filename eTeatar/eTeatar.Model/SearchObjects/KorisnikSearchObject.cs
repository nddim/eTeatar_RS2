using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class KorisnikSearchObject : BaseSearchObject
    {
        public string? ImeGTE { get; set; }
        public string? PrezimeGTE { get; set; }
        public string? EmailGTE { get; set; }
        public string? KorisnickoImeGTE { get; set; }
        public string? Telefon { get; set; }
        public DateTime? DatumRodenjaGTE { get; set; }
        public DateTime? DatumRodenjaLTE { get; set; }
        public int? UlogaId { get; set; }

    }
}
