using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class KartaInsertRequest
    {
        public decimal Cijena { get; set; }
        public int SjedisteId { get; set; }
        public int TerminId { get; set; }
        public int? RezervacijaId { get; set; }
        public int KorisnikId { get; set; }
    }
}
