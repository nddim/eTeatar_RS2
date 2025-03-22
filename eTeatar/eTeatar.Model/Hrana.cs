using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Hrana
    {
        public int HranaId { get; set; }

        public string Naziv { get; set; }

        public float Cijena { get; set; }

        public virtual ICollection<StavkaUplate> StavkaUplates { get; set; } = new List<StavkaUplate>();
    }
}
