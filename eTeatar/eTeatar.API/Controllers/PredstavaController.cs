using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using Microsoft.AspNetCore.Mvc;

namespace eTeatar.API.Controllers;

[ApiController]
[Route("[controller]")]
public class PredstavaController : BaseCRUDController<Predstava, PredstavaSearchObject, PredstavaInsertRequest, PredstavaUpdateRequest>
{   
    public PredstavaController(IPredstavaService service) : base(service)
    {
        
    }
   
}
