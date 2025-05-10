using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Model.Requests;
using MapsterMapper;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class InitialRezervacijaState : BaseRezervacijaState
    {
        public InitialRezervacijaState(Database.ETeatarContext context, IMapper mapper, IServiceProvider service) : base(context, mapper, service)
        {
            
        }
        public override Rezervacija Insert(RezervacijaInsertRequest request)
        {
            
            var set = Context.Set<Database.Rezervacija>();
            var entity = Mapper.Map<Database.Rezervacija>(request);
            entity.StateMachine = "Kreirano";

            BeforeInsert(request, entity);

            set.Add(entity);
            Context.SaveChanges();

            AfterInsert(request, entity);

            return Mapper.Map<Rezervacija>(entity);
        }
        public virtual void BeforeInsert(RezervacijaInsertRequest request, Database.Rezervacija entity)
        {
            var termin = Context.Termins.FirstOrDefault(x => x.TerminId == request.TerminId);
            if (termin == null)
            {
                throw new UserException("Termin ne postoji.");
            }
            //if (termin.Datum < DateTime.Now)
            //{
            //    throw new UserException("Termin je prošao!");
            //}
            if (request.Sjedista == null || !request.Sjedista.Any())
            {
                throw new UserException("Morate odabrati bar jedno sjedište.");
            }

            foreach (var sjedisteId in request.Sjedista)
            {
                bool jeLiZauzeto = Context.Karta.Any(x =>
                    x.TerminId == request.TerminId && x.SjedisteId == sjedisteId);

                if (jeLiZauzeto)
                    throw new UserException($"Sjedište {sjedisteId} je već rezervisano!");
            }

            entity.Status = "Kreirano";
        }
        public virtual void AfterInsert(RezervacijaInsertRequest request, Database.Rezervacija entity)
        {
            if (request.Sjedista == null || !request.Sjedista.Any())
            {
                throw new UserException("Nema sjedišta za rezervaciju.");
            }

            foreach (var sjedisteId in request.Sjedista)
            {
                Context.RezervacijaSjedistes.Add(new Database.RezervacijaSjediste
                {
                    RezervacijaId = entity.RezervacijaId,
                    SjedisteId = sjedisteId
                });
            }
            try
            {
                Context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new UserException($"Greška prilikom spremanja sjedišta: {ex.Message}");
            }
            entity.Korisnik = null;
            entity.Termin = null;
            entity.RezervacijaSjedistes = null;
        }
        public override List<string> AllowedActions(Database.Rezervacija entity)
        {
            return new List<string>() { nameof(Insert) };
        }

    }
}
