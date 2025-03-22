using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Glumac
    {
        public int GlumacId { get; set; }

        public string Ime { get; set; }

        public string Prezime { get; set; } 

        public string Biografija { get; set; }

        public virtual ICollection<PredstavaGlumac> PredstavaGlumacs { get; set; } = new List<PredstavaGlumac>();
    }
}
