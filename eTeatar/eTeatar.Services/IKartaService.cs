using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IKartaService : ICRUDService<Karta, KartaSearchObject, KartaInsertRequest, KartaUpdateRequest>
    {

    }
}
