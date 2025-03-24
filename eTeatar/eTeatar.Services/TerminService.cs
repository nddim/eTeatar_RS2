using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

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

            return query;
        }
    }
}
