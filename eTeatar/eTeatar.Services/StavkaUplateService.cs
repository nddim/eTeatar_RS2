using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class StavkaUplateService : BaseCRUDService<Model.StavkaUplate, StavkaUplateSearchObject, Database.StavkaUplate, StavkaUplateInsertRequest, StavkaUplateUpdateRequest>, IStavkaUplateService
    {
        public StavkaUplateService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<StavkaUplate> AddFilter(StavkaUplateSearchObject search, IQueryable<StavkaUplate> query)
        {
            query = base.AddFilter(search, query);
            if (search?.Cijena != null)
            {
                query = query.Where(x => x.Cijena == search.Cijena);
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }
    }
}
