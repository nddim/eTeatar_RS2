using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class OcjenaInsertRequest
    {
        public int Vrijednost { get; set; }
        public string Komentar { get; set; }
        public int PredstavaId { get; set; }
        public int KorisnikId { get; set; }
    }
}
