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

        [HttpPut("{id}/odobri")]
        public Rezervacija Odobri(int id)
        {
            return (_service as IRezervacijaService).Odobri(id);
        }
        [HttpPut("{id}/zavrsi")]
        public Rezervacija Zavrsi(int id)
        {
            return (_service as IRezervacijaService).Zavrsi(id);
        }
        [HttpPut("{id}/ponisti")]
        public Rezervacija Ponisti(int id)
        {
            return (_service as IRezervacijaService).Ponisti(id);
        }

        //[HttpPut("potvrdi")]
        //public Rezervacija PotvrdiRezervaciju(int rezervacijaId)
        //{
        //    return (_service as IRezervacijaService).potvrdiRezervaciju(rezervacijaId);
        //}
        //[HttpPut("otkazi")]
        //public Rezervacija OtkaziRezrvaciju(int rezervacijaId)
        //{
        //    return (_service as IRezervacijaService).otkaziRezervaciju(rezervacijaId);
        //}
    }
}
