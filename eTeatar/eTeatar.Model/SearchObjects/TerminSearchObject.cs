using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class TerminSearchObject : BaseSearchObject
    {
        public DateTime? DatumGTE { get; set; }
        public DateTime? DatumLTE { get; set; }
        public string? Status { get; set; }
        public int? DvoranaId { get; set; }
        public int? PredstavaId { get; set; }
        public int? RezervacijaId { get; set; }
    }
}
