using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class SjedisteService : BaseCRUDService<Model.Sjediste, SjedisteSearchObject, Database.Sjediste, SjedisteUpsertRequest, SjedisteUpsertRequest>, ISjedisteService
    {
        public SjedisteService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }
    }
}
