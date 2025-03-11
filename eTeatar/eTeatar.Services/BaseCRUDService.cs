using eTeatar.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.SearchObjects;
using eTeatar.Model.Requests;

namespace eTeatar.Services
{
    public abstract class BaseCRUDService<TModel, TSearch, TDbEntity, TInsert, TUpdate> : BaseService<TModel, TSearch, TDbEntity> where TSearch : BaseSearchObject where TDbEntity : class where TModel : class
    {
        private ETeatarContext eTeatarContext;
        private IMapper mapper;
        public BaseCRUDService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public TModel Insert(TInsert request)
        {
            TDbEntity entity = mapper.Map<TDbEntity>(request);
            mapper.Map(request, entity);

            BeforeInsert(request, entity);

            eTeatarContext.Add(entity);
            eTeatarContext.SaveChanges();

            return mapper.Map<TModel>(entity);
        }

        public virtual void BeforeInsert(TInsert request, TDbEntity entity)
        {

        }
        public TModel Update (int id, TUpdate request)
        {
            var set = eTeatarContext.Set<TDbEntity>();

            var entity = set.Find(id);

            mapper.Map(entity, request); 

            BeforeUpdate(request, entity);

            eTeatarContext.SaveChanges();

            return mapper.Map<TModel>(entity);
        }
        public virtual void BeforeUpdate(TUpdate request, TDbEntity entity)
        {

        }
    }
}
