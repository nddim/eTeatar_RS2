using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RezervacijaSjedisteController : BaseCRUDController<RezervacijaSjediste, RezervacijaSjedisteSearchObject
        , RezervacijaSjedisteUpsertRequest, RezervacijaSjedisteUpsertRequest>
    {
        public RezervacijaSjedisteController(IRezervacijaSjedisteService service) : base(service)
        {

        }

        [HttpGet("GetRezervisanaSjedistaByTermin/{terminId}")]
        public List<int> GetRezervisanaSjedistaByTermin(int terminId)
        {
            return ((IRezervacijaSjedisteService)_service).GetRezervisanaSjedistaByTermin(terminId);
        }
    }

}