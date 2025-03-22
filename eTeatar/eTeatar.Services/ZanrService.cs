using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class ZanrService : BaseCRUDService<Model.Zanr, ZanrSearchObject, Database.Zanr, ZanrUpsertRequest, ZanrUpsertRequest>, IZanrService
    {
        public ZanrService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
