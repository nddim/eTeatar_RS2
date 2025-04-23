using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using PredstavaGlumac = eTeatar.Services.Database.PredstavaGlumac;

namespace eTeatar.Services
{
    public class PredstavaGlumacService : BaseCRUDService<Model.PredstavaGlumac, PredstavaGlumacSearchObject, Database.PredstavaGlumac, PredstavaGlumacUpsertRequest, PredstavaGlumacUpsertRequest>, IPredstavaGlumacService
    {
        public PredstavaGlumacService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<PredstavaGlumac> AddFilter(PredstavaGlumacSearchObject search, IQueryable<PredstavaGlumac> query)
        {
            query = base.AddFilter(search, query);
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.GlumacId != null)
            {
                query = query.Where(x => x.GlumacId == search.GlumacId);
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(PredstavaGlumacUpsertRequest request, PredstavaGlumac entity)
        {
            var predstavaGlumac = Context.PredstavaGlumacs.Where(x => x.PredstavaId == request.PredstavaId && x.GlumacId == request.GlumacId).FirstOrDefault();
            if (predstavaGlumac != null)
            {
                throw new UserException("Glumac je već sadržan u predstavi!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(PredstavaGlumacUpsertRequest request, PredstavaGlumac entity)
        {
            var predstavaGlumac = Context.PredstavaGlumacs.Where(x => x.PredstavaId == request.PredstavaId && x.GlumacId == request.GlumacId).FirstOrDefault();
            if (predstavaGlumac != null)
            {
                throw new UserException("Glumac je već sadržan u predstavi!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
