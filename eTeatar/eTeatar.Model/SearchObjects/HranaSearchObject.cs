using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class HranaSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; }
        public decimal? CijenaGTE { get; set; }
        public decimal? CijenaLTE { get; set; }
    }
}
