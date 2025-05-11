using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }

        public string? StateMachine { get; set; }

        public int TerminId { get; set; }

        public int KorisnikId { get; set; }

        public virtual ICollection<RezervacijaSjediste> RezervacijaSjedistes { get; set; } = new List<RezervacijaSjediste>();
    }
}
