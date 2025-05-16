using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IOcjenaService : ICRUDService<Ocjena, OcjenaSearchObject, OcjenaInsertRequest, OcjenaUpdateRequest>
    {
        double getProsjekOcjena(int predstavaId);

        bool jelKorisnikOcijenio(int korisnikId, int predstavaId);
    }
}
