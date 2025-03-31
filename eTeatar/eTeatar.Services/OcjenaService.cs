using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Ocjena = eTeatar.Services.Database.Ocjena;

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

        public override void BeforeInsert(OcjenaInsertRequest request, Ocjena entity)
        {
            var ocjena = Context.Ocjenas.Where(x =>
                x.KorisnikId == request.KorisnikId && x.PredstavaId == request.PredstavaId).FirstOrDefault();
            if (ocjena != null)
            {
                throw new UserException("Već postoji recenzija korisnika za predstavu!");
            }

            if (request.Vrijednost < 1 || request.Vrijednost > 5)
            {
                throw new UserException("Vrijednost ocjene treba biti izmedu 1 i 5!");
            }
            
            entity.DatumKreiranja = DateTime.Now;
            base.BeforeInsert(request, entity);
        }

        public double getProsjekOcjena(int predstavaId)
        {
            var ocjene = Context.Ocjenas.Where(x => x.PredstavaId == predstavaId).ToList();
            if (ocjene.Count == 0)
            {
                throw new UserException("Nema ocjena za datu predstavu!");
            }

            return ocjene.Average(x => x.Vrijednost);
        }
    }
}
