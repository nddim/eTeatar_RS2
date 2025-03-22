using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class PredstavaRepertoar
    {
        public int PredstavaRepertoarId { get; set; }

        public int PredstavaId { get; set; }

        public int RepertoarId { get; set; }

        public virtual Predstava Predstava { get; set; }

        public virtual Repertoar Repertoar { get; set; }
    }
}
