using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class RepertoarUpdateRequest
    {
        public string? Naziv { get; set; }

        public string? Opis { get; set; }

        public DateTime? DatumPocetka { get; set; }

        public DateTime? DatumKraja { get; set; }

        public List <int>? Predstave { get; set; }
    }
}
