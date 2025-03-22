using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class RezervacijaSjedisteUpsertRequest
    {
        public int RezervacijaId { get; set; }

        public int SjedisteId { get; set; }
    }
}
