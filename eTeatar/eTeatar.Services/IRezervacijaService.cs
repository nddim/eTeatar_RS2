using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IRezervacijaService : ICRUDService<Rezervacija, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        public Rezervacija Odobri(int rezervacijaId);
        public Rezervacija Zavrsi(int rezervacijaId);
        public Rezervacija Ponisti(int rezervacijaId);
        public List<string> AllowedActions(int rezervacijaId);
    }
}
