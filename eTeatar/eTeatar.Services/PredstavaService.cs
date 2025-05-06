using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System.Runtime.Intrinsics.X86;
using Predstava = eTeatar.Model.Predstava;
using PredstavaGlumac = eTeatar.Services.Database.PredstavaGlumac;
using PredstavaZanr = eTeatar.Services.Database.PredstavaZanr;

namespace eTeatar.Services
{
    public class PredstavaService : BaseCRUDService<Predstava, PredstavaSearchObject, Database.Predstava, PredstavaInsertRequest, PredstavaUpdateRequest>, IPredstavaService
    {
        public PredstavaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base (_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Database.Predstava> AddFilter(PredstavaSearchObject search, IQueryable<Database.Predstava> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }
            if( search?.CijenaGTE != null)
            {
                query = query.Where(x => x.Cijena > search.CijenaGTE);
            }
            if (search?.CijenaLTE != null)
            {
                query = query.Where(x => x.Cijena < search.CijenaLTE);
            }
            if (search?.RepertoarId != null)
            {
                query = query.Include(x=>x.PredstavaRepertoars)
                    .Where(x => x.PredstavaRepertoars.Any(pr => pr.RepertoarId == search.RepertoarId));
            }
            if (search?.ZanrId != null)
            {
                query = query.Include(x => x.PredstavaZanrs)
                    .Where(x => x.PredstavaZanrs.Any(pz => pz.ZanrId == search.ZanrId));
            }
            if (!string.IsNullOrWhiteSpace(search.OrderBy))
            {
                switch (search.OrderBy.ToLower())
                {
                    case "datum":
                        query = query.OrderBy(p => p.Termins.Min(t => t.Datum));
                        break;
                    case "naziv":
                        query = query.OrderBy(p => p.Naziv);
                        break;
                }
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(PredstavaInsertRequest request, Database.Predstava entity)
        {
            var predstavaNaziv = Context.Predstavas.Where(x => x.Naziv == request.Naziv).FirstOrDefault();
            if (predstavaNaziv != null)
            {
                throw new UserException("Već postoji predstava s tim imenom!");
            }
        }

        public override void AfterInsert(PredstavaInsertRequest request, Database.Predstava entity)
        {
            if (request?.Zanrovi != null)
            {
                foreach (var zanrId in request.Zanrovi)
                {
                    Context.PredstavaZanrs.Add(new PredstavaZanr
                    {
                        ZanrId = zanrId,
                        PredstavaId = entity.PredstavaId,
                    });
                }

                Context.SaveChanges();
            }

            if (request?.Glumci != null)
            {
                foreach (var glumacId in request.Glumci)
                {
                    Context.PredstavaGlumacs.Add(new PredstavaGlumac
                    {
                        GlumacId = glumacId,
                        PredstavaId = entity.PredstavaId,
                    });
                }

                Context.SaveChanges();
            }
        }

        public override void AfterUpdate(PredstavaUpdateRequest request, Database.Predstava entity)
        {
            if (request?.Zanrovi != null)
            {
                foreach (var zanrId in request.Zanrovi)
                {
                    Context.PredstavaZanrs.Add(new PredstavaZanr
                    {
                        ZanrId = zanrId,
                        PredstavaId = entity.PredstavaId,
                    });
                }

                Context.SaveChanges();
            }

            if (request?.Glumci != null)
            {
                foreach (var glumacId in request.Glumci)
                {
                    Context.PredstavaGlumacs.Add(new PredstavaGlumac
                    {
                        GlumacId = glumacId,
                        PredstavaId = entity.PredstavaId,
                    });
                }

                Context.SaveChanges();
            }
        }

        public List<Predstava> getProslePredstave(int korisnikId)
        {
            var karte = Context.Karta
                .Where(k => k.KorisnikId == korisnikId && k.Termin.Datum < DateTime.Now)
                .Include(k => k.Termin.Predstava)
                .ToList();

            var predstave = karte
                .Select(k => k.Termin.Predstava)
                .Distinct()
            .ToList();

            return Mapper.Map<List<Predstava>>(predstave);
        }
    }
}
