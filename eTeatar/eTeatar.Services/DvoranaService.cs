using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class DvoranaService : BaseCRUDService<Model.Dvorana, DvoranaSearchObject, Dvorana, DvoranaUpsertRequest, DvoranaUpsertRequest>, IDvoranaService
    {
        public DvoranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Dvorana> AddFilter(DvoranaSearchObject search, IQueryable<Dvorana> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.KapacitetGTE != null)
            {
                query = query.Where(x => x.Kapacitet > search.KapacitetGTE);
            }
            if (search?.KapacitetLTE != null)
            {
                query = query.Where(x => x.Kapacitet < search.KapacitetLTE);
            }

            return query;
        }
    }
}
