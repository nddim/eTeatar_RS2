using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Services.Database;
using Predstava = eTeatar.Model.Predstava;

namespace eTeatar.Services
{
    public class PredstavaService : IPredstavaService
    {
        private ETeatarContext eTeatarContext;
        public PredstavaService(ETeatarContext _eTeatarContext)
        {
            eTeatarContext = _eTeatarContext;
        } 
        public virtual List<Predstava> GetList()
        {
            var list = eTeatarContext.Predstavas.ToList();
            var result = new List<Predstava>();
            list.ForEach(item =>
            {
                result.Add(new Predstava()
                {
                    Naziv = item.Naziv,
                    PredstavaId = item.PredstavaId
                });
            });

            return result;
        }
    }
}
