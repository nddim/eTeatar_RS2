using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class GlumacService : BaseCRUDService<Model.Glumac, GlumacSearchObject, Database.Glumac, GlumacInsertRequest, GlumacUpdateRequest>, IGlumacService
    {
        public GlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
