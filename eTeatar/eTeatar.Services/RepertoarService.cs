using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
namespace eTeatar.Services
{
    public class RepertoarService : BaseCRUDService<Model.Repertoar, RepertoarSearchObject, Database.Repertoar, RepertoarInsertRequest, RepertoarUpdateRequest>, IRepertoarService
    {
        public RepertoarService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
