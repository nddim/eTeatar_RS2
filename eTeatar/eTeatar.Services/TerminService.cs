using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Termin = eTeatar.Services.Database.Termin;

namespace eTeatar.Services
{
    public class TerminService : BaseCRUDService<Model.Termin, TerminSearchObject, Database.Termin, TerminUpsertRequest, TerminUpsertRequest>, ITerminService
    {
        public TerminService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Termin> AddFilter(TerminSearchObject search, IQueryable<Termin> query)
        {
            query = base.AddFilter(search, query);
            if (search?.DatumGTE != null)
            {
                query = query.Where(x => x.Datum > search.DatumGTE);
            }
            if(search?.DatumLTE != null)
            {
                query = query.Where(x => x.Datum < search.DatumLTE);
            }
            if (!string.IsNullOrEmpty(search?.Status))
            {
                query = query.Where(x => x.Status == search.Status);
            }
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.DvoranaId != null)
            {
                query = query.Where(x => x.DvoranaId == search.DvoranaId);
            }
            if (search?.RezervacijaId != null)
            {
                query = query.Include(x => x.Rezervacijas.Any(r => r.RezervacijaId == search.RezervacijaId));
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(TerminUpsertRequest request, Termin entity)
        {
            var terminPredstave = Context.Termins.Where(x => x.Datum == request.Datum && x.PredstavaId == request.PredstavaId).FirstOrDefault();
            if (terminPredstave != null)
            {
                throw new UserException("Već postoji termin predstave u to vrijeme!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(TerminUpsertRequest request, Termin entity)
        {
            if (provjeriKonflikte(request.Datum, request.PredstavaId))
            {
                throw new UserException("Već postoji termin predstave u to vrijeme!");
            }
            base.BeforeUpdate(request, entity);
        }
        public bool provjeriKonflikte(DateTime datum, int predstavaId)
        {
            bool termini = Context.Termins.Any(x => x.Datum == datum && x.PredstavaId == predstavaId);
            return termini;
        }
    }
}
