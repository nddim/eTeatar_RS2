using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class TerminUpsertRequest
    {
        public DateTime Datum { get; set; }

        public int DvoranaId { get; set; }

        public int PredstavaId { get; set; }

        public string Status { get; set; }

    }
}
