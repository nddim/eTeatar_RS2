using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class UlogaService : BaseService<Model.Uloga, UlogaSearchObject, Database.Uloga>, IUlogaService
    {
        public UlogaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Uloga> AddFilter(UlogaSearchObject search, IQueryable<Uloga> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.Naziv))
            {
                query = query.Where(x => x.Naziv == search.Naziv);
            }
            return query;
        }
    }
        
}
