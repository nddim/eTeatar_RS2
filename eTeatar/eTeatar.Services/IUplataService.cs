using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IUplataService : ICRUDService<Uplata, UplataSearchObject, UplataInsertRequest, UplataUpdateRequest>
    {
    }
}
