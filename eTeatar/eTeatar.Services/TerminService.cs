using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class TerminService : BaseCRUDService<Model.Termin, TerminSearchObject, Database.Termin, TerminUpsertRequest, TerminUpsertRequest>, ITerminService
    {
        public TerminService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
