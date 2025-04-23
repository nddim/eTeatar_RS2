using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Vijest = eTeatar.Services.Database.Vijest;

namespace eTeatar.Services
{
    public class VijestService : BaseCRUDService<Model.Vijest, VijestSearchObject, Database.Vijest, VijestUpsertRequest, VijestUpsertRequest>, IVijestService
    {
        public VijestService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Vijest> AddFilter(VijestSearchObject search, IQueryable<Vijest> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.DatumGTE != null)
            {
                query = query.Where(x => x.Datum > search.DatumGTE);
            }
            if (search?.DatumLTE != null)
            {
                query = query.Where(x => x.Datum < search.DatumLTE);
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(VijestUpsertRequest request, Vijest entity)
        {
            var naziv = Context.Vijests.Where(x => x.Naziv == request.Naziv).FirstOrDefault();
            if (naziv != null)
            {
                throw new UserException("Već postoji vijest s tim nazivom!");
            }
            entity.Datum = DateTime.Now;
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(VijestUpsertRequest request, Vijest entity)
        {
            entity.Datum = DateTime.Now;
            base.BeforeUpdate(request, entity);
        }
    }
}
