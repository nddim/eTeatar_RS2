using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class GlumacSearchObject : BaseSearchObject
    {
        public string? ImeGTE { get; set; }
        public string? PrezimeGTE { get; set; }
        public int? PredstavaId { get; set; }

    }
}
