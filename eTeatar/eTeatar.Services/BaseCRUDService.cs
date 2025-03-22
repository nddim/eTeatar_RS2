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
        public BaseCRUDService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public virtual TModel Insert(TInsert request)
        {
            TDbEntity entity = Mapper.Map<TDbEntity>(request);
            BeforeInsert(request, entity);
            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<TModel>(entity);
        }

        public virtual void BeforeInsert(TInsert request, TDbEntity entity)
        {

        }
        public virtual TModel Update (int id, TUpdate request)
        {
            var set = Context.Set<TDbEntity>();

            var entity = set.Find(id);

            Mapper.Map(entity, request); 

            BeforeUpdate(request, entity);

            Context.SaveChanges();

            return Mapper.Map<TModel>(entity);
        }
        public virtual void BeforeUpdate(TUpdate request, TDbEntity entity)
        {

        }
    }
}
