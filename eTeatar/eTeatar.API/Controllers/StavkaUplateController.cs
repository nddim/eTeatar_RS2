using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Mvc;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class StavkaUplateController : BaseCRUDController<StavkaUplate, StavkaUplateSearchObject, StavkaUplateInsertRequest, StavkaUplateUpdateRequest>
    {
        public StavkaUplateController(IStavkaUplateService service) : base(service)
        {
        }
    }
}
