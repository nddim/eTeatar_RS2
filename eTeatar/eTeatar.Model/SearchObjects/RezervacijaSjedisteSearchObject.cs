using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class RezervacijaSjedisteSearchObject : BaseSearchObject
    {
        public int? RezervacijaId { get; set; }
        public int? SjedisteId { get; set; }
    }
}
