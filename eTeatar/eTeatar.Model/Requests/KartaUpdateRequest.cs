using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class KartaUpdateRequest
    {
        public decimal Cijena { get; set; }
        public int SjedisteId { get; set; }
        public int TerminId { get; set; }
        public bool UkljucenaHrana { get; set; }
    }
}
