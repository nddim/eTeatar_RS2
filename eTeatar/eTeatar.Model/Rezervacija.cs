using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }

        public string Status { get; set; }

        public int SjedisteId { get; set; }

        public int TerminId { get; set; }

        public int KorisnikId { get; set; }

        public virtual ICollection<Karta> Karta { get; set; } = new List<Karta>();

        public virtual Korisnik Korisnik { get; set; }

        public virtual ICollection<Sjediste> Sjedistes { get; set; } = new List<Sjediste>();

        public virtual ICollection<Termin> Termins { get; set; } = new List<Termin>();
    }
}
