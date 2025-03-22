using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class VijestService : BaseCRUDService<Model.Vijest, VijestSearchObject, Database.Vijest, VijestUpsertRequest, VijestUpsertRequest>, IVijestService
    {
        public VijestService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
