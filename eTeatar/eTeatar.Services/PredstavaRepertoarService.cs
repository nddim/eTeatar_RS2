using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using PredstavaRepertoar = eTeatar.Services.Database.PredstavaRepertoar;

namespace eTeatar.Services
{
    public class PredstavaRepertoarService : BaseCRUDService<Model.PredstavaRepertoar, PredstavaRepertoarSearchObject, Database.PredstavaRepertoar, PredstavaRepertoarUpsertRequest, PredstavaRepertoarUpsertRequest> , IPredstavaRepertoarService
    {
        public PredstavaRepertoarService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<PredstavaRepertoar> AddFilter(PredstavaRepertoarSearchObject search, IQueryable<PredstavaRepertoar> query)
        {
            query = base.AddFilter(search, query);
            if (search?.PredstavaId != null)
            {
                query = query.Where(x => x.PredstavaId == search.PredstavaId);
            }
            if (search?.RepertoarId != null)
            {
                query = query.Where(x => x.RepertoarId == search.RepertoarId);
            }
            return query;
        }
        public override void BeforeInsert(PredstavaRepertoarUpsertRequest request, PredstavaRepertoar entity)
        {
            var predstavaRepertoar = Context.PredstavaRepertoars.Where(x => x.PredstavaId == request.PredstavaId && x.RepertoarId == request.RepertoarId).FirstOrDefault();
            if (predstavaRepertoar != null)
            {
                throw new UserException("Predstava već postoji unutar repertoara!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(PredstavaRepertoarUpsertRequest request, PredstavaRepertoar entity)
        {
            var predstavaRepertoar = Context.PredstavaRepertoars.Where(x => x.PredstavaId == request.PredstavaId && x.RepertoarId == request.RepertoarId).FirstOrDefault();
            if (predstavaRepertoar != null)
            {
                throw new UserException("Predstava već postoji unutar repertoara!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
