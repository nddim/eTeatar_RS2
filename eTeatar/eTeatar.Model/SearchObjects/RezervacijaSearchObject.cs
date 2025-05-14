using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class RezervacijaSearchObject : BaseSearchObject
    {
        public int? TerminId { get; set; }
        public int? KorisnikId { get; set; }
        public string? Status { get; set; }
    }
}
