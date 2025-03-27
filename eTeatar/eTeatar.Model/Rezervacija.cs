using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }

        public string Status { get; set; }

        public int TerminId { get; set; }

        public int KorisnikId { get; set; }

        public virtual Termin Termin { get; set; } = null!;

        public virtual Korisnik Korisnik { get; set; }

        public virtual ICollection<Karta> Karta { get; set; } = new List<Karta>();

        public virtual ICollection<RezervacijaSjediste> RezervacijaSjedistes { get; set; } = new List<RezervacijaSjediste>();


    }
}
