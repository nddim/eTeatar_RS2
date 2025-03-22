using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class DvoranaService : BaseCRUDService<Model.Dvorana, DvoranaSearchObject, Dvorana, DvoranaUpsertRequest, DvoranaUpsertRequest>, IDvoranaService
    {
        public DvoranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
