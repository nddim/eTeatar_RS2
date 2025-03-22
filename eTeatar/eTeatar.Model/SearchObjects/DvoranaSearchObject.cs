using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class DvoranaSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; }
        public int? KapacitetGTE { get; set; }
        public int? KapacitetLTE { get; set; }
    }
}
