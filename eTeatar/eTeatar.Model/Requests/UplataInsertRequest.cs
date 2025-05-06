using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class UplataInsertRequest
    {
        public decimal Iznos { get; set; }
        public int KorisnikId { get; set; }
        public string TransakcijaId { get; set; }
        public string NacinPlacanja { get; set; }
        public string Status { get; set; }

    }
}
