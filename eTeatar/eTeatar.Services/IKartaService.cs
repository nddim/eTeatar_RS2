﻿using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IKartaService : ICRUDService<Karta, KartaSearchObject, KartaInsertRequest, KartaUpdateRequest>
    {
        public List<Model.KartaDTO> getKartasByKorisnik(int korisnikId);
        public List<Model.KartaDTO> getArchivedKartasByKorisnik(int korisnikId);


    }
}
