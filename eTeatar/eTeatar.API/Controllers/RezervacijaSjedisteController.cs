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
    }

}