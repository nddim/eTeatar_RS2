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
            entity.StateMachine = "Kreirana";
            set.Add(entity);
            Context.SaveChanges();
            return Mapper.Map<Rezervacija>(entity);
        }

        public override List<string> AllowedActions(Database.Rezervacija entity)
        {
            return new List<string>() { nameof(Insert) };
        }

    }
}
