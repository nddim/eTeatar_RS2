using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RezervacijaController : BaseCRUDController<Rezervacija, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        public RezervacijaController(IRezervacijaService service) : base(service)
        {
        }
    }
}
