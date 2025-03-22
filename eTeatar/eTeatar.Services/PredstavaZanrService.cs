using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaZanrService : BaseCRUDService<Model.PredstavaZanr, PredstavaZanrSearchObject, Database.PredstavaZanr, PredstavaZanrUpsertRequest, PredstavaZanrUpsertRequest>, IPredstavaZanrService
    {
        public PredstavaZanrService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
