﻿using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.Requests
{
    public class KorisnikInsertRequest
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KorisnickoIme { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        public byte[]? Slika { get; set; }
        public DateTime DatumRodenja { get; set; }
        public int UlogaId { get; set; }
    }
}
