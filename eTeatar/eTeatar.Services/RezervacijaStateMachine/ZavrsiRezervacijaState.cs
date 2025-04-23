using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class ZavrsiRezervacijaState : BaseRezervacijaState
    {
        public ZavrsiRezervacijaState(ETeatarContext context, IMapper mapper, IServiceProvider service) : base(context, mapper, service)
        {
        }
        public override List<string> AllowedActions(Database.Rezervacija entity)
        {
            return new List<string>() {};
        }
    }
}
