using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Authorization;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DvoranaController : BaseCRUDController<Dvorana, DvoranaSearchObject, DvoranaUpsertRequest, DvoranaUpsertRequest>
    {
        public DvoranaController(IDvoranaService service) : base(service)
        {

        }
        [AllowAnonymous]
        public override PagedResult<Dvorana> GetPaged(DvoranaSearchObject searchObject)
        {
            return base.GetPaged(searchObject);
        }
    }
}
