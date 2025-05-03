using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class PredstavaSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; }
        public DateTime? TrajanjePocetakGTE { get; set; }
        public DateTime? TrajanjePocetakLTE { get; set; }
        public DateTime? TrajanjeKrajGTE { get; set; }
        public DateTime? TrajanjeKrajLTE { get; set; }
        public decimal? CijenaGTE { get; set; }
        public decimal? CijenaLTE { get; set; }
        public int? RepertoarId { get; set; }
        public int? ZanrId { get; set; }
        public string? OrderBy { get; set; }

    }
}
