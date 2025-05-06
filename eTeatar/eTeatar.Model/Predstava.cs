using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Predstava
    {
        public int PredstavaId { get; set; }

        public string Naziv { get; set; }

        public string Opis { get; set; }

        public int Trajanje { get; set; }

        public string Produkcija { get; set; }

        public string Koreografija { get; set; }

        public string Scenografija { get; set; }

        public decimal Cijena { get; set; }

        public byte[]? Slika { get; set; }
    }
}
