using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Services;
using eTeatar.Services.Database;
using Microsoft.AspNetCore.Mvc;
using Korisnik = eTeatar.Model.Korisnik;

namespace eTeatar.API.Controllers;

[ApiController]
[Route("[controller]")]
public class KorisnikController : ControllerBase
{   
    private IKorisnikService _service;
    public KorisnikController(IKorisnikService service)
    {
        _service = service;
    }
    [HttpGet]
    public List<Korisnik> getList()
    {
        return _service.GetList();
    }
    [HttpPost]
    public Korisnik Insert(KorisnikInsertRequest request)
    {
        return _service.Insert(request);
    }
    [HttpPut("{id}")]
    public Korisnik Update(int id, KorisnikUpdateRequest request)
    {
        return _service.Update(id, request);
    }
}
