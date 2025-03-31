using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class Dvorana
    {
        public int DvoranaId { get; set; }

        public string Naziv { get; set; }

        public int Kapacitet { get; set; }

        public virtual ICollection<Sjediste> Sjedistes { get; set; } = new List<Sjediste>();
    }
}
