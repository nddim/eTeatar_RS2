using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;

namespace eTeatar.Services
{
    public class RezervacijaSjedisteService : BaseCRUDService<Model.RezervacijaSjediste, RezervacijaSjedisteSearchObject, Database.RezervacijaSjediste, RezervacijaSjedisteUpsertRequest, RezervacijaSjedisteUpsertRequest>, IRezervacijaSjedisteService
    {
        public RezervacijaSjedisteService(Database.ETeatarContext context, MapsterMapper.IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<RezervacijaSjediste> AddFilter(RezervacijaSjedisteSearchObject search, IQueryable<RezervacijaSjediste> query)
        {
            query = base.AddFilter(search, query);
            if (search?.RezervacijaId != null)
            {
                query = query.Where(x => x.RezervacijaId == search.RezervacijaId);
            }
            if (search?.SjedisteId != null)
            {
                query = query.Where(x => x.SjedisteId == search.SjedisteId);
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }
    }
}
