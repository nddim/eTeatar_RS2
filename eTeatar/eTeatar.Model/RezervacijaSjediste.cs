using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class RezervacijaSjediste
    {
        public int RezervacijaSjedisteId { get; set; }

        public int RezervacijaId { get; set; }

        public int SjedisteId { get; set; }

        public virtual Rezervacija Rezervacija { get; set; } = null!;

        public virtual Sjediste Sjediste { get; set; } = null!;

    }
}
