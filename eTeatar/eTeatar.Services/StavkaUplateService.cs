using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class StavkaUplateService : BaseCRUDService<Model.StavkaUplate, StavkaUplateSearchObject, Database.StavkaUplate, StavkaUplateInsertRequest, StavkaUplateUpdateRequest>, IStavkaUplateService
    {
        public StavkaUplateService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
