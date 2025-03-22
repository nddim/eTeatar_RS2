using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaRepertoarService : BaseCRUDService<Model.PredstavaRepertoar, PredstavaRepertoarSearchObject, Database.PredstavaRepertoar, PredstavaRepertoarUpsertRequest, PredstavaRepertoarUpsertRequest> , IPredstavaRepertoarService
    {
        public PredstavaRepertoarService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
