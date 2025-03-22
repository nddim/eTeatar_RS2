using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Predstava
    {
        public int PredstavaId { get; set; }

        public string Naziv { get; set; }

        public string Opis { get; set; }

        public DateTime TrajanjePocetak { get; set; }

        public DateTime TrajanjeKraj { get; set; }

        public string Produkcija { get; set; }

        public string Koreografija { get; set; }

        public string Scenografija { get; set; }

        public float Cijena { get; set; }

        public int RepertoarId { get; set; }

        public byte[]? Slika { get; set; }

        public virtual ICollection<Ocjena> Ocjenas { get; set; } = new List<Ocjena>();

        public virtual ICollection<PredstavaGlumac> PredstavaGlumacs { get; set; } = new List<PredstavaGlumac>();

        public virtual ICollection<PredstavaZanr> PredstavaZanrs { get; set; } = new List<PredstavaZanr>();

        public virtual ICollection<Repertoar> Repertoars { get; set; } = new List<Repertoar>();

        public virtual ICollection<Termin> Termins { get; set; } = new List<Termin>();
    }
}
