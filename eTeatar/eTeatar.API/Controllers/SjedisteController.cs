using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SjedisteController : BaseCRUDController<Sjediste, SjedisteSearchObject, SjedisteUpsertRequest, SjedisteUpsertRequest>
    {
        public SjedisteController(ISjedisteService service) : base(service)
        {
        }
    }
}
