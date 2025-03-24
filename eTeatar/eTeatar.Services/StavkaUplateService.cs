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
            if (search?.KolicinaGTE != null)
            {
                query = query.Where(x => x.Kolicina > search.KolicinaGTE);
            }
            if (search?.KolicinaLTE != null)
            {
                query = query.Where(x => x.Kolicina < search.KolicinaLTE);
            }
            if (search?.CijenaGTE != null)
            {
                query = query.Where(x => x.Cijena > search.CijenaGTE);
            }
            if (search?.CijenaLTE != null)
            {
                query = query.Where(x => x.Cijena < search.CijenaLTE);
            }
            if (search?.UplataId != null)
            {
                query = query.Where(x => x.UplataId == search.UplataId);
            }

            return query;
        }
    }
}
