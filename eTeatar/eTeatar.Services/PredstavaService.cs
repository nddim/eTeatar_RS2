using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;

namespace eTeatar.Services
{
    public class PredstavaService : IPredstavaService
    {
        public List<Predstava> List = new()
        {
            new Predstava()
            {
                PredstavaId = 1,
                Naziv = "Jezeva kucica"
            },
            new Predstava()
            {
                PredstavaId = 2,
                Naziv = "Terminator"
            }
        };

        public List<Predstava> GetList()
        {
            return List;
        }
    }
}
