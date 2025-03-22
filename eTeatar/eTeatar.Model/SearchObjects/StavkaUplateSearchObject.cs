using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class StavkaUplateSearchObject : BaseSearchObject
    {
        public int? KolicinaGTE { get; set; }
        public int? KolicinaLTE { get; set; }
        public decimal? CijenaGTE { get; set; }
        public decimal? CijenaLTE { get; set; }
        public int? UplataId { get; set; }

    }
}
