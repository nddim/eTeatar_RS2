using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class VijestUpsertRequest
    {
        public string Naziv { get; set; }
        public string Sadrzaj { get; set; }
        public int KorisnikId { get; set; }
    }
}
