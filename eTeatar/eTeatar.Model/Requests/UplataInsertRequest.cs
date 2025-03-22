using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class UplataInsertRequest
    {
        public decimal Iznos { get; set; }
        public DateTime Datum { get; set; }
        public int KorisnikId { get; set; }

    }
}
