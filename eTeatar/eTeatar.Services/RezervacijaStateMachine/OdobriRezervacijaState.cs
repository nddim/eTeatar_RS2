using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Services.Database;
using MapsterMapper;
using Rezervacija = eTeatar.Services.Database.Rezervacija;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class OdobriRezervacijaState : BaseRezervacijaState
    {
        public OdobriRezervacijaState(ETeatarContext context, IMapper mapper, IServiceProvider service) : base(context, mapper, service)
        {
        }
        public override Model.Rezervacija Ponisti(int id)
        {
            var set = Context.Set<Database.Rezervacija>();
            var entity = set.Find(id);
            if (entity == null)
            {
                throw new UserException("Rezervacija nije pronađena!");
            }
            entity.StateMachine = "Ponistena";
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
            entity.StateMachine = "Zavrsena";
            Context.SaveChanges();
            return Mapper.Map<Model.Rezervacija>(entity);
        }
        public override List<string> AllowedActions(Rezervacija entity)
        {
            return new List<string>() { nameof(Ponisti), nameof(Zavrsi) };
        }
    }
}
