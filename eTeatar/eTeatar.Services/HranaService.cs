using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class HranaService : BaseCRUDService<Model.Hrana, HranaSearchObject, Database.Hrana, HranaUpsertRequest, HranaUpsertRequest>, IHranaService
    {
        public HranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
