using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Glumac = eTeatar.Services.Database.Glumac;

namespace eTeatar.Services
{
    public class GlumacService : BaseCRUDService<Model.Glumac, GlumacSearchObject, Database.Glumac, GlumacInsertRequest, GlumacUpdateRequest>, IGlumacService
    {
        public GlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Glumac> AddFilter(GlumacSearchObject search, IQueryable<Glumac> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.ImeGTE))
            {
                query = query.Where(x => x.Ime.StartsWith(search.ImeGTE));
            }
            if (!string.IsNullOrEmpty(search?.PrezimeGTE))
            {
                query = query.Where(x => x.Prezime.StartsWith(search.PrezimeGTE));
            }
            if (search?.PredstavaId != null)
            {
                query = query.Include(x => x.PredstavaGlumacs)
                    .Where(x => x.PredstavaGlumacs.Any(pg => pg.PredstavaId == search.PredstavaId));
            }

            return query;
        }

        public override void BeforeInsert(GlumacInsertRequest request, Glumac entity)
        {
            var glumacImePrezime = Context.Glumacs.Where(x => x.Ime == request.Ime && x.Prezime == request.Prezime).FirstOrDefault();
            if (glumacImePrezime != null)
            {
                throw new UserException("Već postoji glumac s tim imenom i prezimenom!");
            }

            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(GlumacUpdateRequest request, Glumac entity)
        {
            var glumacImePrezime = Context.Glumacs.Where(x => x.Ime == request.Ime && x.Prezime == request.Prezime).FirstOrDefault();
            if (glumacImePrezime != null)
            {
                throw new UserException("Već postoji glumac s tim imenom i prezimenom!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
