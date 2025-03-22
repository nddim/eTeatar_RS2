using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IPredstavaZanrService : ICRUDService<PredstavaZanr, PredstavaZanrSearchObject, PredstavaZanrUpsertRequest, PredstavaZanrUpsertRequest>
    {
    }
}
