using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using PredstavaRepertoar = eTeatar.Services.Database.PredstavaRepertoar;
using Repertoar = eTeatar.Services.Database.Repertoar;

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

        public override void BeforeInsert(RepertoarInsertRequest request, Repertoar entity)
        {
            if(request.DatumKraja < request.DatumPocetka)
            {
                throw new UserException("Datum kraja ne smije biti manji od datuma početka!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void AfterInsert(RepertoarInsertRequest request, Repertoar entity)
        {
            if (request?.Predstave != null)
            {
                foreach (var predstavaId in request.Predstave)
                {
                    Context.PredstavaRepertoars.Add(new PredstavaRepertoar
                    {
                        PredstavaId = predstavaId,
                        RepertoarId = entity.RepertoarId,
                    });
                }

                Context.SaveChanges();
            }
            base.AfterInsert(request, entity);
        }

        public override void AfterUpdate(RepertoarUpdateRequest request, Repertoar entity)
        {
            if (request?.Predstave != null)
            {
                foreach (var predstavaId in request.Predstave)
                {
                    Context.PredstavaRepertoars.Add(new PredstavaRepertoar
                    {
                        PredstavaId = predstavaId,
                        RepertoarId = entity.RepertoarId,
                    });
                }

                Context.SaveChanges();
            }
        }
    }
}
