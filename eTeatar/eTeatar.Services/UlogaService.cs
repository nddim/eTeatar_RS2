using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class UlogaService : BaseService<Model.Uloga, UlogaSearchObject, Database.Uloga>, IUlogaService
    {
        public UlogaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
        
}
