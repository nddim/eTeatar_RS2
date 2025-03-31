using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Vijest
    {
        public int VijestId { get; set; }

        public string Naziv { get; set; }

        public string Sadržaj { get; set; } 

        public DateTime Datum { get; set; }

        public int KorisnikId { get; set; }
    }
}
