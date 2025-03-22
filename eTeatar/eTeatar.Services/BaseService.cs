using eTeatar.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public abstract class BaseService<TModel, TSearch, TDbEntity> : IService<TModel, TSearch> where TSearch : BaseSearchObject where TDbEntity : class where TModel : class
    {
        public ETeatarContext Context;
        public IMapper Mapper;
        public BaseService(ETeatarContext _eTeatarContext, IMapper _mapper)
        {
            Context = _eTeatarContext;
            Mapper = _mapper;
        }
        public PagedResult<TModel> GetPaged(TSearch search)
        {
            List<TModel> result = new List<TModel>();

            var query = Context.Set<TDbEntity>().AsQueryable();

            query = AddFilter(search, query);

            int count = query.Count();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = query.ToList();

            result = Mapper.Map(list, result);
            PagedResult<TModel> pagedResult = new PagedResult<TModel>();
            pagedResult.Count = count;
            pagedResult.ResultList = result;

            return pagedResult;
        }

        public TModel GetById(int id)
        {
            var entity = Context.Set<TDbEntity>().Find(id);
            if (entity != null)
            {
                return Mapper.Map<TModel>(entity);
            }

            return null;
        }

        public virtual IQueryable<TDbEntity> AddFilter(TSearch search, IQueryable<TDbEntity> query)
        {
            return query;
        }
    }
}
