using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaZanrService : BaseCRUDService<Model.PredstavaZanr, PredstavaZanrSearchObject, Database.PredstavaZanr, PredstavaZanrUpsertRequest, PredstavaZanrUpsertRequest>, IPredstavaZanrService
    {
        public PredstavaZanrService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<PredstavaZanr> AddFilter(PredstavaZanrSearchObject search, IQueryable<PredstavaZanr> query)
        {
            query = base.AddFilter(search, query);
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.ZanrId != null)
            {
                query = query.Where(x => x.ZanrId == search.ZanrId);
            }

            return query;
        }
    }
}
