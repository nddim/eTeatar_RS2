using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KartaController : BaseCRUDController<Karta, KartaSearchObject, KartaInsertRequest, KartaUpdateRequest>
    {
        public KartaController(IKartaService service) : base(service)
        {
        }
    }
}
