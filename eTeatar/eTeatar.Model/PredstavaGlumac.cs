using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class PredstavaGlumac
    {
        public int PredstavaGlumacId { get; set; }

        public int PredstavaId { get; set; }

        public int GlumacId { get; set; }

        public virtual Glumac? Glumac { get; set; }

        public virtual Predstava? Predstava { get; set; }
    }
}
