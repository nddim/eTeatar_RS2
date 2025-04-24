using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using eTeatar.Services.RezervacijaStateMachine;
using MapsterMapper;
using Rezervacija = eTeatar.Services.Database.Rezervacija;

namespace eTeatar.Services
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, RezervacijaSearchObject, Rezervacija, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
    {
        public BaseRezervacijaState BaseRezervacijaState { get; set; }
        public RezervacijaService(ETeatarContext _eTeatarContext, IMapper _mapper, BaseRezervacijaState baseRezervacijaState) : base(_eTeatarContext, _mapper)
        {
            BaseRezervacijaState = baseRezervacijaState;
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

        public override Model.Rezervacija Insert(RezervacijaInsertRequest request)
        {
            var state = BaseRezervacijaState.CreateState("Initial");
            return state.Insert(request);
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
        }

        public Model.Rezervacija Odobri(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }

            var state = BaseRezervacijaState.CreateState(rezervacija.StateMachine);
            return state.Odobri(rezervacijaId);
        }

        public Model.Rezervacija Ponisti(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }

            var state = BaseRezervacijaState.CreateState(rezervacija.StateMachine);
            return state.Ponisti(rezervacijaId);
        }

        public List<string> AllowedActions(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }

            var state = BaseRezervacijaState.CreateState(rezervacija.StateMachine);
            return state.AllowedActions(rezervacija);
        }

        public Model.Rezervacija Zavrsi(int rezervacijaId)
        {
            var rezervacija = Context.Rezervacijas.Find(rezervacijaId);
            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }

            var state = BaseRezervacijaState.CreateState(rezervacija.StateMachine);
            return state.Zavrsi(rezervacijaId);
        }
    }
}
