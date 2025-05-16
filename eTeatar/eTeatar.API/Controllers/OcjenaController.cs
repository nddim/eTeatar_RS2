using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OcjenaController : BaseCRUDController<Ocjena, OcjenaSearchObject, OcjenaInsertRequest, OcjenaUpdateRequest>
    {
        public OcjenaController(IOcjenaService service) : base(service)
        {
        }

        [HttpGet("Prosjek")]
        public virtual double GetProsjekOcjena(int predstavaId)
        {
            return ((IOcjenaService)_service).getProsjekOcjena(predstavaId);
        }
        [HttpGet("jelKorisnikOcjenio")]
        public bool JelOcijenio(int korisnikId, int predstavaId)
        {
            return ((IOcjenaService)_service).jelKorisnikOcijenio(korisnikId, predstavaId);
        }
    }
}
