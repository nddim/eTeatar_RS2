using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UplataController : BaseCRUDController<Uplata, UplataSearchObject, UplataInsertRequest, UplataUpdateRequest>
    {
        public UplataController(IUplataService service) : base(service)
        {
        }
    }
}
