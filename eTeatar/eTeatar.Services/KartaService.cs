using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class KartaService : BaseCRUDService<Karta, KartaSearchObject, Database.Kartum, KartaInsertRequest, KartaUpdateRequest>, IKartaService
    {
        public KartaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
