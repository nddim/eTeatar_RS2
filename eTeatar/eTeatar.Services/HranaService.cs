using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Hrana = eTeatar.Services.Database.Hrana;

namespace eTeatar.Services
{
    public class HranaService : BaseCRUDService<Model.Hrana, HranaSearchObject, Database.Hrana, HranaUpsertRequest, HranaUpsertRequest>, IHranaService
    {
        public HranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Hrana> AddFilter(HranaSearchObject search, IQueryable<Hrana> query)
        {
            query = base.AddFilter(search, query);
            if(!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.CijenaGTE != null)
            {
                query = query.Where(x => x.Cijena > search.CijenaGTE);
            }
            if (search?.CijenaLTE != null)
            {
                query = query.Where(x => x.Cijena < search.CijenaLTE);
            }

            return query;
        }

        public override void BeforeInsert(HranaUpsertRequest request, Hrana entity)
        {
            var naziv = Context.Hranas.Where(x => x.Naziv == request.Naziv && x.HranaId != entity.HranaId).FirstOrDefault();
            if (naziv != null)
            {
                throw new UserException("Već postoji hrana s tim nazivom!");
            }
            if (request.Cijena < 0)
            {
                throw new UserException("Cijena ne smije imati vrijednost manju od 0!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(HranaUpsertRequest request, Hrana entity)
        {
            var naziv = Context.Hranas.Where(x => x.Naziv == request.Naziv && x.HranaId != entity.HranaId).FirstOrDefault();
            if (naziv != null)
            {
                throw new UserException("Već postoji hrana s tim nazivom!");
            }
            if (request.Cijena < 0)
            {
                throw new UserException("Cijena ne smije imati vrijednost manju od 0!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
