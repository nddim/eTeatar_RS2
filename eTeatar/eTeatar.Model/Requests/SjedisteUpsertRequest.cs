using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class SjedisteUpsertRequest
    {
        public string Red { get; set; }
        public string Kolona { get; set; }
        public string Status { get; set; }
        public int DvoranaId { get; set; }
    }
}
