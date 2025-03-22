using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IRezervacijaService : ICRUDService<Rezervacija, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    { 
    }
}
