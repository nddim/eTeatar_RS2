using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Predstava = eTeatar.Model.Predstava;

namespace eTeatar.Services.Recommender
{
    public class RecommenderService : IRecommenderService
    {
        private readonly IMapper mapper;
        private readonly ETeatarContext eTeatarContext;

        public RecommenderService(IMapper mapper, ETeatarContext eTeatarContext)
        {
            this.mapper = mapper;
            this.eTeatarContext = eTeatarContext;
            mlContext = new MLContext();
        }

        private static MLContext mlContext = null;
        static object isLocked = new object();
        const string ModelPath = "model.zip";
        static ITransformer model = null;
        public List<Predstava> getRecommendedPredstave(int korisnikId)
        {
            var svePredstaveQuery = eTeatarContext.Predstavas
                .Include(p => p.PredstavaGlumacs).ThenInclude(pg => pg.Glumac).Where(p => p.IsDeleted == false)
                .AsQueryable();

            if (!svePredstaveQuery.Any())
            {
                throw new UserException("Nema dostupnih predstava za preporuku.");
            }

            var kupljenePredstavaIds = eTeatarContext.Karta
                .Where(k => k.KorisnikId == korisnikId)
                .Select(k => k.TerminId)
                .Distinct()
                .Join(eTeatarContext.Termins, tid => tid, t => t.TerminId, (tid, t) => t.PredstavaId)
                .ToList();

            var gledanePredstave = svePredstaveQuery
                .Where(p => kupljenePredstavaIds.Contains(p.PredstavaId))
                .ToList();

            var gledaneData = gledanePredstave.Select(p => new PredstavaData
            {
                PredstavaId = p.PredstavaId,
                Naziv = p.Naziv,
                Produkcija = p.Produkcija,
                Koreografija = p.Koreografija,
                Scenografija = p.Scenografija,
                Glumci = string.Join(", ", p.PredstavaGlumacs.Select(pg => pg.Glumac.Ime + " " + pg.Glumac.Prezime))
            }).ToList();

            var sveData = svePredstaveQuery
                .Select(p => new PredstavaData
                {
                    PredstavaId = p.PredstavaId,
                    Naziv = p.Naziv,
                    Produkcija = p.Produkcija,
                    Koreografija = p.Koreografija,
                    Scenografija = p.Scenografija,
                    Glumci = string.Join(", ", p.PredstavaGlumacs.Select(pg => pg.Glumac.Ime + " " + pg.Glumac.Prezime))
                }).ToList();

            var pipeline = mlContext.Transforms.Text.FeaturizeText("GlumciFeaturized", nameof(PredstavaData.Glumci))
                .Append(mlContext.Transforms.Text.FeaturizeText("ProdukcijaFeaturized", nameof(PredstavaData.Produkcija)))
                .Append(mlContext.Transforms.Text.FeaturizeText("KoreografijaFeaturized", nameof(PredstavaData.Koreografija)))
                .Append(mlContext.Transforms.Text.FeaturizeText("ScenografijaFeaturized", nameof(PredstavaData.Scenografija)))
                .Append(mlContext.Transforms.Concatenate("Features",
                    "GlumciFeaturized", "ProdukcijaFeaturized", "KoreografijaFeaturized", "ScenografijaFeaturized"));

            var model = pipeline.Fit(mlContext.Data.LoadFromEnumerable(sveData));

            var predictionEngine = mlContext.Model.CreatePredictionEngine<PredstavaData, PredstavaPrediction>(model);

            var predictions = new List<PredstavaPrediction>();
            foreach (var p in sveData)
            {
                if (gledaneData.Any(g => g.PredstavaId == p.PredstavaId))
                    continue;

                var vector = predictionEngine.Predict(p).Features;

                float totalScore = 0;
                foreach (var gp in gledaneData)
                {
                    var gpVector = predictionEngine.Predict(gp).Features;
                    totalScore += CalculateCosineSimilarity(vector, gpVector);
                }

                predictions.Add(new PredstavaPrediction
                {
                    Id = p.PredstavaId,
                    Score = totalScore / gledaneData.Count
                });
            }

            var topIds = predictions.OrderByDescending(p => p.Score).Take(5).Select(p => p.Id).ToList();

            var preporucenePredstave = svePredstaveQuery.Where(p => topIds.Contains(p.PredstavaId)).ToList();

            return mapper.Map<List<Predstava>>(preporucenePredstave);
        }

        private float CalculateCosineSimilarity(float[] a, float[] b)
        {
            float dot = 0, magA = 0, magB = 0;
            for (int i = 0; i < a.Length; i++)
            {
                dot += a[i] * b[i];
                magA += a[i] * a[i];
                magB += b[i] * b[i];
            }
            return (float)(dot / (Math.Sqrt(magA) * Math.Sqrt(magB)));
        }

        public void TrainData()
        {
            var svePredstave = eTeatarContext.Predstavas
                .Include(p => p.PredstavaGlumacs).ThenInclude(pg => pg.Glumac)
                .Select(p => new PredstavaData
                {
                    PredstavaId = p.PredstavaId,
                    Produkcija = p.Produkcija,
                    Koreografija = p.Koreografija,
                    Scenografija = p.Scenografija,
                    Glumci = string.Join(", ", p.PredstavaGlumacs.Select(pg => pg.Glumac.Ime + " " + pg.Glumac.Prezime))
                }).ToList();

            var trainingData = mlContext.Data.LoadFromEnumerable(svePredstave);

            var pipeline = mlContext.Transforms.Text.FeaturizeText("GlumciFeaturized", nameof(PredstavaData.Glumci))
                .Append(mlContext.Transforms.Text.FeaturizeText("ProdukcijaFeaturized", nameof(PredstavaData.Produkcija)))
                .Append(mlContext.Transforms.Text.FeaturizeText("KoreografijaFeaturized", nameof(PredstavaData.Koreografija)))
                .Append(mlContext.Transforms.Text.FeaturizeText("ScenografijaFeaturized", nameof(PredstavaData.Scenografija)))
                .Append(mlContext.Transforms.Concatenate("Features",
                    "GlumciFeaturized", "ProdukcijaFeaturized", "KoreografijaFeaturized", "ScenografijaFeaturized"));

            model = pipeline.Fit(trainingData);

            using var fs = System.IO.File.Create(ModelPath);
            mlContext.Model.Save(model, trainingData.Schema, fs);
        }

    }
    public class PredstavaData
    {
        public int PredstavaId { get; set; }
        public string Naziv { get; set; }
        public string Produkcija { get; set; }
        public string Koreografija { get; set; }
        public string Scenografija { get; set; }
        public string Glumci { get; set; }
    }
    public class PredstavaPrediction
    {
        public int Id { get; set; }
        public float Score { get; set; }

        [Microsoft.ML.Data.VectorType]
        public float[] Features { get; set; }
    }
}
