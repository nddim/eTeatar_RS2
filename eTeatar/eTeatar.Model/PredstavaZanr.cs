using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class PredstavaZanr
    {
        public int PredstavaZanrId { get; set; }

        public int ZanrId { get; set; }

        public int PredstavaId { get; set; }

        public virtual Predstava Predstava { get; set; } 

        public virtual Zanr Zanr { get; set; }
    }
}
