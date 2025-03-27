using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
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
            if (search?.TrajanjePocetakGTE != null)
            {
                query = query.Where(x => x.TrajanjePocetak > search.TrajanjePocetakGTE);
            }
            if(search?.TrajanjePocetakLTE != null)
            {
                query = query.Where(x => x.TrajanjePocetak < search.TrajanjePocetakLTE);
            }
            if (search?.TrajanjeKrajGTE != null)
            {
                query = query.Where(x => x.TrajanjeKraj > search.TrajanjeKrajGTE);
            }
            if (search?.TrajanjeKrajLTE != null)
            {
                query = query.Where(x => x.TrajanjeKraj < search.TrajanjeKrajLTE);
            }
            if (!string.IsNullOrEmpty(search?.ProdukcijaGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.ProdukcijaGTE));
            }
            if (!string.IsNullOrEmpty(search?.KoreografijaGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.KoreografijaGTE));
            }
            if (!string.IsNullOrEmpty(search?.ScenografijaGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.ScenografijaGTE));
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
                query = query.Where(x => x.PredstavaRepertoars.Any(pr => pr.RepertoarId == search.RepertoarId));
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

            if (request.TrajanjeKraj < request.TrajanjePocetak)
            {
                throw new UserException("Vrijeme kraja ne smije biti veći od vremena početka!");
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
    }
}
