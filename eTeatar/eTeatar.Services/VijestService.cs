using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class VijestService : BaseCRUDService<Model.Vijest, VijestSearchObject, Database.Vijest, VijestUpsertRequest, VijestUpsertRequest>, IVijestService
    {
        public VijestService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Vijest> AddFilter(VijestSearchObject search, IQueryable<Vijest> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.DatumGTE != null)
            {
                query = query.Where(x => x.Datum > search.DatumGTE);
            }
            if (search?.DatumLTE != null)
            {
                query = query.Where(x => x.Datum < search.DatumLTE);
            }
         
            return query;
        }
    }
}
