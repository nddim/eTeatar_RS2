using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Zanr = eTeatar.Services.Database.Zanr;

namespace eTeatar.Services
{
    public class ZanrService : BaseCRUDService<Model.Zanr, ZanrSearchObject, Database.Zanr, ZanrUpsertRequest, ZanrUpsertRequest>, IZanrService
    {
        public ZanrService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Zanr> AddFilter(ZanrSearchObject search, IQueryable<Zanr> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if (search?.PredstavaId != null)
            {
                query = query.Include(x => x.PredstavaZanrs)
                    .Where(x => x.PredstavaZanrs.Any(pz => pz.PredstavaId == search.PredstavaId));
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(ZanrUpsertRequest request, Zanr entity)
        {
            var naziv = Context.Zanrs.Where(x => x.Naziv == request.Naziv).FirstOrDefault();
            if (naziv != null)
            {
                throw new UserException("Već postoji žanr s tim nazivom!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(ZanrUpsertRequest request, Zanr entity)
        {
            var naziv = Context.Zanrs.Where(x => x.Naziv == request.Naziv && x.ZanrId != entity.ZanrId).FirstOrDefault();
            if (naziv != null)
            {
                throw new UserException("Već postoji žanr s tim nazivom!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
