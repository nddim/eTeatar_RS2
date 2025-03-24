using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class HranaService : BaseCRUDService<Model.Hrana, HranaSearchObject, Database.Hrana, HranaUpsertRequest, HranaUpsertRequest>, IHranaService
    {
        public HranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Hrana> AddFilter(HranaSearchObject search, IQueryable<Hrana> query)
        {
            query = base.AddFilter(search, query);
            if(!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.CijenaGTE != null)
            {
                query = query.Where(x => x.Cijena > search.CijenaGTE);
            }
            if (search?.CijenaLTE != null)
            {
                query = query.Where(x => x.Cijena < search.CijenaLTE);
            }

            return query;
        }
    }
}
