using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IDvoranaService : ICRUDService<Dvorana, DvoranaSearchObject, DvoranaUpsertRequest, DvoranaUpsertRequest>
    {

    }
}
