using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eTeatar.Services.Recommender
{
    public interface IRecommenderService
    {
        List<Model.Predstava> getRecommendedPredstave(int korisnikId);
        void TrainData();
    }
}
