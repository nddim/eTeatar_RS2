using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
namespace eTeatar.Services
{
    public interface IRepertoarService : ICRUDService<Repertoar, RepertoarSearchObject, RepertoarInsertRequest, RepertoarUpdateRequest>
    {
    }
}
