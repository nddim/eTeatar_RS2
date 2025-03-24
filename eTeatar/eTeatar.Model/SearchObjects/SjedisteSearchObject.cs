using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class SjedisteSearchObject : BaseSearchObject
    {
        public string? Red { get; set; }
        public string? Kolona { get; set; }
        public string? Status { get; set; }
        public int? DvoranaId { get; set; }
    }
}
