using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Sjediste
    {
        public int SjedisteId { get; set; }

        public string Red { get; set; }

        public string Kolona { get; set; } 

        public bool Status { get; set; }

        public int DvoranaId { get; set; }

        public int RezervacijaId { get; set; }

        public virtual Dvorana Dvorana { get; set; }

        public virtual ICollection<Karta> Karta { get; set; } = new List<Karta>();

        public virtual Rezervacija Rezervacija { get; set; } 
    }
}
