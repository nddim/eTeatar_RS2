using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Services.Database;
using MapsterMapper;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using Rezervacija = eTeatar.Services.Database.Rezervacija;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class OdobriRezervacijaState : BaseRezervacijaState
    {   
        private readonly IKartaService _kartaService;
        private readonly IStavkaUplateService _stavkaUplateService;
        public OdobriRezervacijaState(ETeatarContext context, IMapper mapper, IServiceProvider service, IKartaService kartaService, IStavkaUplateService stavkaUplateService) : base(context, mapper, service)
        {
            _kartaService = kartaService;
            _stavkaUplateService = stavkaUplateService;
        }
        public override Model.Rezervacija Ponisti(int id)
        {
            var set = Context.Set<Database.Rezervacija>();
            var entity = set.Find(id);
            if (entity == null)
            {
                throw new UserException("Rezervacija nije pronađena!");
            }
            entity.StateMachine = "Ponisteno";
            Context.SaveChanges();
            return Mapper.Map<Model.Rezervacija>(entity);
        }
        public override Model.Rezervacija Zavrsi(int id)
        {
            var set = Context.Set<Database.Rezervacija>();
            var entity = set.Find(id);
            if (entity == null)
            {
                throw new UserException("Rezervacija nije pronađena!");
            }
            entity.StateMachine = "Zavrseno";
            foreach (var rs in entity.RezervacijaSjedistes)
            {
                var kartaInsert = new KartaInsertRequest
                {
                    SjedisteId = rs.SjedisteId,
                    TerminId = entity.TerminId,
                    KorisnikId = entity.KorisnikId,
                    RezervacijaId = entity.RezervacijaId
                };

                _kartaService.Insert(kartaInsert);
            }
            Context.SaveChanges();
            entity.Korisnik = null;
            entity.Termin = null;
            entity.RezervacijaSjedistes = null;
            entity.Karta = null;
            return Mapper.Map<Model.Rezervacija>(entity);
        }
        public override List<string> AllowedActions(Rezervacija entity)
        {
            return new List<string>() { nameof(Ponisti), nameof(Zavrsi) };
        }
    }
}
