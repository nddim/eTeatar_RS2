using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class UplataService : BaseCRUDService<Model.Uplata, UplataSearchObject, Database.Uplatum, UplataInsertRequest, UplataUpdateRequest>, IUplataService
    {
        public UplataService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
