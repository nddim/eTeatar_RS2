using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class PredstavaService : BaseService<Model.Predstava, PredstavaSearchObject, Database.Predstava> , IPredstavaService
    {
        public PredstavaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base (_eTeatarContext, _mapper)
        {

        } 
        
    }
}
