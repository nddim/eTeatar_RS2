using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GlumacController : BaseCRUDController<Glumac, GlumacSearchObject, GlumacInsertRequest, GlumacUpdateRequest>
    {
        public GlumacController(IGlumacService service) : base(service)
        {
        }
    }
}
