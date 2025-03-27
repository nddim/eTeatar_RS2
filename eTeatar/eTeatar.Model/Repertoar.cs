using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Repertoar
    {
        public int ReperatoarId { get; set; }

        public string Naziv { get; set; }

        public string Opis { get; set; } 

        public DateTime DatumPocetka { get; set; }

        public DateTime DatumKraja { get; set; }

        public virtual ICollection<PredstavaRepertoar> PredstavaRepertoars { get; set; } = new List<PredstavaRepertoar>();
    }
}
