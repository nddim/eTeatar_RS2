  using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class KartaDTO
    {
        public int KartaId { get; set; }
        public decimal Cijena { get; set; }
        public int SjedisteId { get; set; }
        public string Red { get; set; }
        public string Kolona { get; set; }
        public int TerminId { get; set; }
        public DateTime DatumVrijeme { get; set; }
        public string NazivPredstave { get; set; }
    }
}
