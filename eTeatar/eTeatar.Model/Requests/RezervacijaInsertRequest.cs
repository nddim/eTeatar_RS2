using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        public List<int> Sjedista { get; set; }

        public int TerminId { get; set; }

        public int KorisnikId { get; set; }
    }
}
