using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class VijestSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; }
        public int KorisnikId { get; set; }
        public DateTime? DatumGTE { get; set; }
        public DateTime? DatumLTE { get; set; }
    }
}
