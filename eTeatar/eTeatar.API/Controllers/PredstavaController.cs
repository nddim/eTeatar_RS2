using eTeatar.Model;
using eTeatar.Services;
using Microsoft.AspNetCore.Mvc;

namespace eTeatar.API.Controllers;

[ApiController]
[Route("[controller]")]
public class PredstavaController : ControllerBase
{   
    private IPredstavaService _service;
    public PredstavaController(IPredstavaService service)
    {
        _service = service;
    }
    [HttpGet]
    public List<Predstava> getList()
    {
        return _service.GetList();
    }
}
