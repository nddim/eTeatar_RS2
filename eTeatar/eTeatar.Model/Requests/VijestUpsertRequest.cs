using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class VijestUpsertRequest
    {
        public string Naziv { get; set; }
        public string Sadržaj { get; set; }
        public DateTime? Datum { get; set; }
    }
}
