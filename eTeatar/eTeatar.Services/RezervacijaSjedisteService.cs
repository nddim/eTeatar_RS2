using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public class RezervacijaSjedisteService : BaseCRUDService<Model.RezervacijaSjediste, RezervacijaSjedisteSearchObject, Database.RezervacijaSjediste, RezervacijaSjedisteUpsertRequest, RezervacijaSjedisteUpsertRequest>, IRezervacijaSjedisteService
    {
        public RezervacijaSjedisteService(Database.ETeatarContext context, MapsterMapper.IMapper mapper) : base(context, mapper)
        {
        }
    }
}
