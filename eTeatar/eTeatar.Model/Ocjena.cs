using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Ocjena
    {
        public int OcjenaId { get; set; }

        public int Vrijednost { get; set; }

        public string Komentar { get; set; }

        public DateTime DatumKreiranja { get; set; }

        public int PredstavaId { get; set; }

        public int KorisnikId { get; set; }
    }
}
