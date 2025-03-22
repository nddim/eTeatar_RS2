using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class OcjenaSearchObject : BaseSearchObject
    {
        public int? VrijednostGTE { get; set; }
        public int? VrijednostLTE { get; set; }
        public DateTime? DatumKreiranjaGTE { get; set; }
        public DateTime? DatumKreiranjaLTE { get; set; }
        public int? PredstavaId { get; set; }
        public int? KorisnikId { get; set; }

    }
}
