using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;
using eTeatar.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Korisnik = eTeatar.Model.Korisnik;

namespace eTeatar.API.Controllers;

[ApiController]
[Route("[controller]")]
public class KorisnikController : BaseCRUDController<Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
{   
    public KorisnikController(IKorisnikService service) : base(service)
    {
    }

    [AllowAnonymous]
    [HttpPost("login")]
    public Model.Korisnik Login(string username, string password)
    {
        return (_service as IKorisnikService).Login(username, password);
    }
    [HttpGet("recommend")]
    public List<Model.Predstava> Recommend(int korisnikId)
    {
        return (_service as IKorisnikService).Recommend(korisnikId);
    }
}
