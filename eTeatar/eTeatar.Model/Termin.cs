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

        public virtual Dvorana Dvorana { get; set; }

        public virtual Predstava Predstava { get; set; }

        public virtual ICollection<Karta> Karta { get; set; } = new List<Karta>();

        public virtual ICollection<Rezervacija> Rezervacijas { get; set; } = new List<Rezervacija>();
    }
}
