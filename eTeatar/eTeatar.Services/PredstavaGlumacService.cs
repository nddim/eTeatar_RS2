using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaGlumacService : BaseCRUDService<Model.PredstavaGlumac, PredstavaGlumacSearchObject, Database.PredstavaGlumac, PredstavaGlumacUpsertRequest, PredstavaGlumacUpsertRequest>, IPredstavaGlumacService
    {
        public PredstavaGlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
