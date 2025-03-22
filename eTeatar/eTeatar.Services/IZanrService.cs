using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
namespace eTeatar.Services
{
    public interface IZanrService : ICRUDService<Zanr, ZanrSearchObject, ZanrUpsertRequest, ZanrUpsertRequest>
    {
    }
}
