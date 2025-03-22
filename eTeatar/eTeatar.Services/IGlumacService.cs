using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IGlumacService : ICRUDService<Glumac, GlumacSearchObject, GlumacInsertRequest, GlumacUpdateRequest>
    {
    }
}
