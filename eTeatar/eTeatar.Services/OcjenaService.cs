using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class OcjenaService : BaseCRUDService<Model.Ocjena, OcjenaSearchObject, Database.Ocjena, OcjenaInsertRequest, OcjenaUpdateRequest>, IOcjenaService
    {
        public OcjenaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)

        {
        }
    }
}
