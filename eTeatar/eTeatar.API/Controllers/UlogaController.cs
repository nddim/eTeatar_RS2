using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Authorization;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [AllowAnonymous]
    public class UlogaController : BaseController<Uloga, UlogaSearchObject>
    {
        public UlogaController(IUlogaService service) : base(service)
        {
        }
    }
}
