using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using PredstavaZanr = eTeatar.Services.Database.PredstavaZanr;

namespace eTeatar.Services
{
    public class PredstavaZanrService : BaseCRUDService<Model.PredstavaZanr, PredstavaZanrSearchObject, Database.PredstavaZanr, PredstavaZanrUpsertRequest, PredstavaZanrUpsertRequest>, IPredstavaZanrService
    {
        public PredstavaZanrService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<PredstavaZanr> AddFilter(PredstavaZanrSearchObject search, IQueryable<PredstavaZanr> query)
        {
            query = base.AddFilter(search, query);
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.ZanrId != null)
            {
                query = query.Where(x => x.ZanrId == search.ZanrId);
            }

            return query;
        }
        public override void BeforeInsert(PredstavaZanrUpsertRequest request, PredstavaZanr entity)
        {
            var predstavaZanr = Context.PredstavaZanrs.Where(x => x.PredstavaId == request.PredstavaId && x.ZanrId == request.ZanrId).FirstOrDefault();
            if (predstavaZanr != null)
            {
                throw new UserException("Žanr je već dodjeljen predstavi!");
            }
            base.BeforeInsert(request, entity);
        }
        public override void BeforeUpdate(PredstavaZanrUpsertRequest request, PredstavaZanr entity)
        {
            var predstavaZanr = Context.PredstavaZanrs.Where(x => x.PredstavaId == request.PredstavaId && x.ZanrId == request.ZanrId).FirstOrDefault();
            if (predstavaZanr != null)
            {
                throw new UserException("Žanr je već dodjeljen predstavi!");
            }
            base.BeforeUpdate(request, entity);
        }

        
    }
}
