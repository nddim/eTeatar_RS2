using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class PredstavaUpdateRequest
    {
        public string Naziv { get; set; } = null!;
        public string Opis { get; set; } = null!;
        public DateTime TrajanjePocetak { get; set; }
        public DateTime TrajanjeKraj { get; set; }
        public string Produkcija { get; set; } = null!;
        public string Koreografija { get; set; } = null!;
        public string Scenografija { get; set; } = null!;
        public decimal Cijena { get; set; }
        public byte[]? Slika { get; set; }
        public List<int>? Zanrovi { get; set; }
        public List<int>? Glumci { get; set; }
    }
}
