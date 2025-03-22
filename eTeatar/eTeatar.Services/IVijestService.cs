using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IVijestService : ICRUDService<Vijest, VijestSearchObject, VijestUpsertRequest, VijestUpsertRequest>
    {
    }
}
