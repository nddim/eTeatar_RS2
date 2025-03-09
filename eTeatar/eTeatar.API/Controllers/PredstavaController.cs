using eTeatar.Model;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Mvc;

namespace eTeatar.API.Controllers;

[ApiController]
[Route("[controller]")]
public class PredstavaController : BaseController<Predstava, PredstavaSearchObject>
{   
    public PredstavaController(IPredstavaService service) : base(service)
    {
        _service = service;
    }
   
}
