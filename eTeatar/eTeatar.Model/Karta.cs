using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Karta
    {
        public int KartaId { get; set; }

        public decimal Cijena { get; set; }

        public int SjedisteId { get; set; }

        public int TerminId { get; set; }

        public int? RezervacijaId { get; set; }

        public int KorisnikId { get; set; }
    }
}
