using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ZanrController : BaseCRUDController<Zanr, ZanrSearchObject, ZanrUpsertRequest, ZanrUpsertRequest>
    {
        public ZanrController(IZanrService service) : base(service)
        {
        }
    }
}
