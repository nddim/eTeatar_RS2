using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HranaController : BaseCRUDController<Hrana, HranaSearchObject, HranaUpsertRequest, HranaUpsertRequest>
    {
        public HranaController(IHranaService service) : base(service)
        {
        }
    }
}
