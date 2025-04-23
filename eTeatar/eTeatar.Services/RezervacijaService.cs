using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Rezervacija = eTeatar.Services.Database.Rezervacija;

namespace eTeatar.Services
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, RezervacijaSearchObject, Rezervacija, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
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
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(RezervacijaInsertRequest request, Rezervacija entity)
        {
            var termin = Context.Termins.Where(x => x.TerminId == request.TerminId).FirstOrDefault();
            if (termin.Datum < DateTime.Now)
            {
                throw new UserException("Termin je prošao!");
            }
            bool jeLiSjedisteZauzeto = Context.Karta.Any(x => x.TerminId == request.TerminId && x.SjedisteId == request.SjedisteId);
            if (jeLiSjedisteZauzeto)
            {
                throw new Exception("Sjedište je već zauzeto!");
            }

            entity.Status = "Rezervisano";
            //base.BeforeInsert(request, entity);
        }

        public Model.Rezervacija potvrdiRezervaciju(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }
            rezervacija.Status = "Potvrđeno";
            Context.SaveChanges();
            return Mapper.Map<Model.Rezervacija>(rezervacija);
        }

        public Model.Rezervacija otkaziRezervaciju(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }
            rezervacija.Status = "Otkazano";
            Context.SaveChanges();
            return Mapper.Map<Model.Rezervacija>(rezervacija);
        }
    }
}
