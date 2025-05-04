using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Model;

namespace eTeatar.Services
{
    public interface IRezervacijaSjedisteService : ICRUDService<RezervacijaSjediste, RezervacijaSjedisteSearchObject, RezervacijaSjedisteUpsertRequest, RezervacijaSjedisteUpsertRequest>
    {
        public List<int> GetRezervisanaSjedistaByTermin(int terminId);
    }
}
