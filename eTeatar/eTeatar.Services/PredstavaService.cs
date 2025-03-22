using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Predstava = eTeatar.Model.Predstava;

namespace eTeatar.Services
{
    public class PredstavaService : BaseCRUDService<Predstava, PredstavaSearchObject, Database.Predstava, PredstavaInsertRequest, PredstavaUpdateRequest>, IPredstavaService
    {
        public PredstavaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base (_eTeatarContext, _mapper)
        {

        } 
        
    }
}
