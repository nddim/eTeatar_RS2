using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class KorisnikSearchObject : BaseSearchObject
    {
        public string? ImeGTE { get; set; }
        public string? PrezimeGTE { get; set; }
        public string? Email { get; set; }
        public string? KorisnickoIme { get; set; }
        public bool? IsKorisnikUlogaIncluded { get; set; }
        public string? OrderBy { get; set; }

    }
}
