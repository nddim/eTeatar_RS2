using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
namespace eTeatar.Services
{
    public class RepertoarService : BaseCRUDService<Model.Repertoar, RepertoarSearchObject, Database.Repertoar, RepertoarInsertRequest, RepertoarUpdateRequest>, IRepertoarService
    {
        public RepertoarService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Repertoar> AddFilter(RepertoarSearchObject search, IQueryable<Repertoar> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.DatumPocetkaGTE != null)
            {
                query = query.Where(x => x.DatumPocetka > search.DatumPocetkaGTE);
            }
            if (search?.DatumPocetkaLTE != null)
            {
                query = query.Where(x => x.DatumPocetka < search.DatumPocetkaLTE);
            }
            if (search?.DatumKrajaGTE != null)
            {
                query = query.Where(x => x.DatumKraja > search.DatumKrajaGTE);
            }
            if(search?.DatumKrajaLTE != null)
            {
                query = query.Where(x => x.DatumKraja < search.DatumKrajaLTE);
            }
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaRepertoars.Any(pr => pr.PredstavaId == search.PredstavaId));
            }
            return query;
        }
    }
}
