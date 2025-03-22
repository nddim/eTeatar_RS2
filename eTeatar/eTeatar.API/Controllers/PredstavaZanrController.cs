using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PredstavaZanrController : BaseCRUDController<PredstavaZanr, PredstavaZanrSearchObject, PredstavaZanrUpsertRequest, PredstavaZanrUpsertRequest>
    {
        public PredstavaZanrController(IPredstavaZanrService service) : base(service)
        {
        }
    }
}
