using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class StavkaUplate
    {
        public int StavkaUplateId { get; set; }

        public int Kolicina { get; set; }

        public float Cijena { get; set; }

        public int HranaId { get; set; }

        public int UplataId { get; set; }

        public virtual Hrana Hrana { get; set; } 

        public virtual Uplata Uplata { get; set; }
    }
}
