using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class StavkaUplateInsertRequest
    {
        public int Kolicina { get; set; }

        public decimal Cijena { get; set; }

        public int UplataId { get; set; }
    }
}
