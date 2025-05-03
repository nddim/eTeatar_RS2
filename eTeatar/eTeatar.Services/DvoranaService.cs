using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Dvorana = eTeatar.Services.Database.Dvorana;

namespace eTeatar.Services
{
    public class DvoranaService :
        BaseCRUDService<Model.Dvorana, DvoranaSearchObject, Dvorana, DvoranaUpsertRequest, DvoranaUpsertRequest>,
        IDvoranaService
    {
        public DvoranaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Dvorana> AddFilter(DvoranaSearchObject search, IQueryable<Dvorana> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.NazivGTE));
            }

            if (search?.KapacitetGTE != null)
            {
                query = query.Where(x => x.Kapacitet > search.KapacitetGTE);
            }

            if (search?.KapacitetLTE != null)
            {
                query = query.Where(x => x.Kapacitet < search.KapacitetLTE);
            }

            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(DvoranaUpsertRequest request, Dvorana entity)
        {
            var dvorana = Context.Dvoranas.Where(x => x.Naziv == request.Naziv).FirstOrDefault();
            if (dvorana != null)
            {
                throw new UserException("Već postoji dvorana s tim imenom!");
            }

            if (request.Kapacitet <= 10)
            {
                throw new UserException("Kapacitet ne smije biti manji od 10");
            }

            var (redovi, kolone) = IzracunajMatricu(request.Kapacitet);

            entity.Sjedistes = new List<Database.Sjediste>();

            int brojac = 0;
            for (int i = 0; i < redovi; i++)
            {
                char red = (char)('A' + i);
                for (int j = 1; j <= kolone; j++)
                {
                    if (brojac >= request.Kapacitet)
                        break;

                    entity.Sjedistes.Add(new Database.Sjediste
                    {
                        Red = red.ToString(),
                        Kolona = j.ToString(),
                        Status = "Aktivno"
                    });

                    brojac++;
                }
            }


        }

        public override void BeforeUpdate(DvoranaUpsertRequest request, Dvorana entity)
        {

            var dvoranaNaziv = Context.Dvoranas.Where(x => x.Naziv == request.Naziv).FirstOrDefault();
            if (dvoranaNaziv != null)
            {
                throw new UserException("Već postoji dvorana s tim imenom!");
            }

            if (request.Kapacitet <= 10)
            {
                throw new UserException("Kapacitet ne smije biti manji od 10");
            }
        }

        (int redovi, int kolone) IzracunajMatricu(int kapacitet)
        {
            int minRazlika = int.MaxValue;
            int najboljiRedovi = 1;
            int najboljiKolone = kapacitet;

            for (int i = 1; i <= 10; i++)
            {
                for (int j = 1; j <= 10; j++)
                {
                    if (i * j >= kapacitet)
                    {
                        int razlika = Math.Abs(i - j);
                        if (razlika < minRazlika)
                        {
                            minRazlika = razlika;
                            najboljiRedovi = i;
                            najboljiKolone = j;
                        }
                    }
                }
            }

            return (najboljiRedovi, najboljiKolone);
        }
    }
}
