using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Ocjena
    {
        public int OcjenaId { get; set; }

        public int Ocjena1 { get; set; }

        public string Komentar { get; set; }

        public DateTime DatumKreiranja { get; set; }

        public int PredstavaId { get; set; }

        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; }

        public virtual Predstava Predstava { get; set; }
    }
}
