using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class PredstavaSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; } = null!;
        public int? RepertoarId { get; set; }
    }
}
