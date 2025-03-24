using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, RezervacijaSearchObject, Database.Rezervacija, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Rezervacija> AddFilter(RezervacijaSearchObject search, IQueryable<Rezervacija> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.Status))
            {
                query = query.Where(x => x.Status == search.Status);
            }
            if (search?.TerminId != null)
            {
                query = query.Where(x => x.TerminId == search.TerminId);
            }
            if (search?.KorisnikId != null)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }

            return query;
        }
    }
}
