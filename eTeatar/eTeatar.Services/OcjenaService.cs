using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class OcjenaService : BaseCRUDService<Model.Ocjena, OcjenaSearchObject, Database.Ocjena, OcjenaInsertRequest, OcjenaUpdateRequest>, IOcjenaService
    {
        public OcjenaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Ocjena> AddFilter(OcjenaSearchObject search, IQueryable<Ocjena> query)
        {
            query = base.AddFilter(search, query);
            if (search?.VrijednostGTE != null)
            {
                query = query.Where(x => x.Vrijednost > search.VrijednostGTE);
            }
            if (search?.VrijednostLTE != null)
            {
                query = query.Where(x => x.Vrijednost < search.VrijednostLTE);
            }
            if (search?.DatumKreiranjaGTE != null)
            {
                query = query.Where(x => x.DatumKreiranja > search.DatumKreiranjaGTE);
            }
            if (search?.DatumKreiranjaLTE != null)
            {
                query = query.Where(x => x.DatumKreiranja < search.DatumKreiranjaLTE);
            }
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if(search?.KorisnikId != null)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }
            return query;
        }
    }
}
