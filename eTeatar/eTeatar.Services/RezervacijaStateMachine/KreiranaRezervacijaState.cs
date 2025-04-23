using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Azure.Core;
using eTeatar.Model;
using eTeatar.Services.Database;
using MapsterMapper;
using Rezervacija = eTeatar.Model.Rezervacija;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class KreiranaRezervacijaState : BaseRezervacijaState
    {
        public KreiranaRezervacijaState(ETeatarContext context, IMapper mapper, IServiceProvider service) : base(context, mapper, service)
        {
        }

        public override Rezervacija Odobri(int id)
        {
            var set = Context.Set<Database.Rezervacija>();
            var entity = set.Find(id);
            if(entity == null)
            {
                throw new UserException("Rezervacija nije pronađena!");
            }
            entity.StateMachine = "Odobrena";
            Context.SaveChanges();
            return Mapper.Map<Rezervacija>(entity);
        }

        public override Rezervacija Ponisti(int id)
        {
            var set = Context.Set<Database.Rezervacija>();
            var entity = set.Find(id);
            if (entity == null)
            {
                throw new UserException("Rezervacija nije pronađena!");
            }
            entity.StateMachine = "Ponistena";
            Context.SaveChanges();
            return Mapper.Map<Rezervacija>(entity);
        }

        public override List<string> AllowedActions(Database.Rezervacija entity)
        {
            return new List<string>() { nameof(Odobri), nameof(Ponisti) };
        }
    }
}
