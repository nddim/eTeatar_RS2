using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class SjedisteSearchObject : BaseSearchObject
    {
        public string? RedGTE { get; set; }
        public string? KolonaGTE { get; set; }
        public string? Status { get; set; }
        public int? DvoranaId { get; set; }
    }
}
