using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaGlumacService : BaseCRUDService<Model.PredstavaGlumac, PredstavaGlumacSearchObject, Database.PredstavaGlumac, PredstavaGlumacUpsertRequest, PredstavaGlumacUpsertRequest>, IPredstavaGlumacService
    {
        public PredstavaGlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<PredstavaGlumac> AddFilter(PredstavaGlumacSearchObject search, IQueryable<PredstavaGlumac> query)
        {
            query = base.AddFilter(search, query);
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.GlumacId != null)
            {
                query = query.Where(x => x.GlumacId == search.GlumacId);
            }
            return query;
        }
    }
}
