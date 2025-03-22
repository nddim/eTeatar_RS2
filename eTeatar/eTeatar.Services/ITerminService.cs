using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface ITerminService : ICRUDService<Termin, TerminSearchObject, TerminUpsertRequest, TerminUpsertRequest>
    {
    }
}
