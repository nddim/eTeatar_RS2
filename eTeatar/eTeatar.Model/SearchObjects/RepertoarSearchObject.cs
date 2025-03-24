using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class RepertoarSearchObject : BaseSearchObject
    {
        public string NazivGTE { get; set; }
        public DateTime DatumPocetkaGTE { get; set; }
        public DateTime DatumPocetkaLTE { get; set; }
        public DateTime DatumKrajaGTE { get; set; }
        public DateTime DatumKrajaLTE { get; set; }
        public int? PredstavaId { get; set; }
    }
}
