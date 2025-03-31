using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Sjediste
    {
        public int SjedisteId { get; set; }

        public string Red { get; set; }

        public string Kolona { get; set; } 

        public string Status { get; set; }

        public int DvoranaId { get; set; }

        public virtual ICollection<RezervacijaSjediste> RezervacijaSjedistes { get; set; } = new List<RezervacijaSjediste>();
    }
}
