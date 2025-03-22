using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }

        public string Ime { get; set; }

        public string Prezime { get; set; }

        public string Email { get; set; }

        public string Telefon { get; set; } 

        public string KorisnickoIme { get; set; }

        public byte[]? Slika { get; set; }

        public DateTime DatumRodenja { get; set; }

        public DateTime DatumRegistracije { get; set; }

        public virtual ICollection<Karta> Karta { get; set; } = new List<Karta>();

        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();

        public virtual ICollection<Ocjena> Ocjenas { get; set; } = new List<Ocjena>();

        public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();

        public virtual ICollection<Uplata> Uplata { get; set; } = new List<Uplata>();

        public virtual ICollection<Vijest> Vijests { get; set; } = new List<Vijest>();
    }
}
