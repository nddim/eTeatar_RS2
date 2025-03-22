using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
namespace eTeatar.Services
{
    public interface IStavkaUplateService : ICRUDService<StavkaUplate, StavkaUplateSearchObject, StavkaUplateInsertRequest, StavkaUplateUpdateRequest>
    {
    }
}
