using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, RezervacijaSearchObject, Database.Rezervacija, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }
    }
}
