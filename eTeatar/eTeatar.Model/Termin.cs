using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Termin
    {
        public int TerminId { get; set; }

        public DateTime Datum { get; set; }

        public string Status { get; set; }

        public int DvoranaId { get; set; }

        public int PredstavaId { get; set; }

        public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();
    }
}
