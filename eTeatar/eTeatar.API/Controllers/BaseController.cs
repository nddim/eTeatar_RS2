using eTeatar.Model;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    //[Authorize]
    public class BaseController<TModel, TSearch> : ControllerBase where TSearch : BaseSearchObject 
    {
        protected IService<TModel, TSearch> _service;
        public BaseController(IService<TModel, TSearch> service)
        {
            _service = service;
        }
        [HttpGet]
        public virtual PagedResult<TModel> GetPaged([FromQuery] TSearch searchObject)
        {
            return _service.GetPaged(searchObject);
        }
        [HttpGet("{id}")]
        public virtual TModel GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
