using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class UplataSearchObject : BaseSearchObject
    {
        public decimal? IznosGTE { get; set; }
        public decimal? IznosLTE { get; set; }
        public DateTime? DatumGTE { get; set; }
        public DateTime? DatumLTE { get; set; }
        public int? KorisnikId { get; set; }
    }
}
