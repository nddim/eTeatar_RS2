using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PredstavaRepertoarController : BaseCRUDController<PredstavaRepertoar, PredstavaRepertoarSearchObject, PredstavaRepertoarUpsertRequest, PredstavaRepertoarUpsertRequest>
    {
        public PredstavaRepertoarController(IPredstavaRepertoarService service) : base(service)
        {

        }
    }
}
