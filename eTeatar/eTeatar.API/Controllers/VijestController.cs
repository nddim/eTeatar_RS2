using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VijestController : BaseCRUDController<Vijest, VijestSearchObject, VijestUpsertRequest, VijestUpsertRequest>
    {
        public VijestController(IVijestService service) : base(service)
        {
        }
    }
}
