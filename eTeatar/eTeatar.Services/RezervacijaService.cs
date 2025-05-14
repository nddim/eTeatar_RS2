using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using eTeatar.Services.RezervacijaStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Rezervacija = eTeatar.Services.Database.Rezervacija;
using RezervacijaSjediste = eTeatar.Services.Database.RezervacijaSjediste;

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
           
            if (search?.TerminId != null)
            {
                query = query.Where(x => x.TerminId == search.TerminId);
            }
            if (search?.Status != null)
            {
                query = query.Where(x => x.StateMachine == search.Status);
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
            var entity = Mapper.Map<Database.Rezervacija>(request);

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
            foreach (var sjedisteId in request.Sjedista)
            {
                bool jeLiZauzeto = Context.Karta.Any(x => x.TerminId == request.TerminId && x.SjedisteId == sjedisteId);
                if (jeLiZauzeto)
                {
                    throw new UserException($"Sjedište {sjedisteId} je već rezervisano!");
                }
            }
        }

        public override void AfterInsert(RezervacijaInsertRequest request, Rezervacija entity)
        {

            if (request.Sjedista != null)
            {
                foreach (var sjedisteId in request.Sjedista)
                {
                    Context.RezervacijaSjedistes.Add(new RezervacijaSjediste()
                    {
                        RezervacijaId = entity.RezervacijaId,
                        SjedisteId = sjedisteId
                    });
                }
            }
            else
            {
                throw new UserException("Nema sjedista za rezervaciju.");
            }

            try
            {
                Context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new UserException($"Greška prilikom spremanja sjedista: {ex.Message}");
            }

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
            var rezervacija = Context.Rezervacijas
                .Include(r => r.RezervacijaSjedistes)
                .FirstOrDefault(r => r.RezervacijaId == rezervacijaId);

            if (rezervacija == null)
            {
                throw new UserException("Rezervacija ne postoji!");
            }

            var state = BaseRezervacijaState.CreateState(rezervacija.StateMachine);
            var rezultat = state.Zavrsi(rezervacijaId);

            return rezultat;
        }
    }
}
