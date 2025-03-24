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

        public override IQueryable<Zanr> AddFilter(ZanrSearchObject search, IQueryable<Zanr> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }

            return query;
        }
    }
}
