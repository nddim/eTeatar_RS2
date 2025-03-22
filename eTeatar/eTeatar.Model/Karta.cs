using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Karta
    {
        public int KartaId { get; set; }

        public float Cijena { get; set; }

        public int SjedisteId { get; set; }

        public int TerminId { get; set; }

        public int RezervacijaId { get; set; }

        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; }

        public virtual Rezervacija Rezervacija { get; set; } 

        public virtual Sjediste Sjediste { get; set; } 

        public virtual Termin Termin { get; set; }
    }
}
