using System;
using System.Collections.Generic;

namespace eTeatar.Model
{
    public partial class Uloga
    {
        public int UlogaId { get; set; }

        public string Naziv { get; set; } = null!;

        public string Opis { get; set; } = null!;

        public bool IsDeleted { get; set; }

        public DateTime? VrijemeBrisanja { get; set; }
    }
}


