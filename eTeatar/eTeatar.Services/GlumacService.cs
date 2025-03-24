using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace eTeatar.Services
{
    public class GlumacService : BaseCRUDService<Model.Glumac, GlumacSearchObject, Database.Glumac, GlumacInsertRequest, GlumacUpdateRequest>, IGlumacService
    {
        public GlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Glumac> AddFilter(GlumacSearchObject search, IQueryable<Glumac> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.ImeGTE))
            {
                query = query.Where(x => x.Ime.StartsWith(search.ImeGTE));
            }
            if (!string.IsNullOrEmpty(search?.PrezimeGTE))
            {
                query = query.Where(x => x.Prezime.StartsWith(search.PrezimeGTE));
            }
            if (search?.PredstavaId != null)
            {
                query = query.Include(x => x.PredstavaGlumacs)
                    .Where(x => x.PredstavaGlumacs.Any(pg => pg.PredstavaId == search.PredstavaId));
            }

            return query;
        }
    }
}
