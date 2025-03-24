using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class SjedisteService : BaseCRUDService<Model.Sjediste, SjedisteSearchObject, Database.Sjediste, SjedisteUpsertRequest, SjedisteUpsertRequest>, ISjedisteService
    {
        public SjedisteService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Sjediste> AddFilter(SjedisteSearchObject search, IQueryable<Sjediste> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrEmpty(search?.Red))
            {
                query = query.Where(x => x.Red == search.Red);
            }
            if (!string.IsNullOrEmpty(search?.Kolona))
            {
                query = query.Where(x => x.Kolona == search.Kolona);
            }
            if (!string.IsNullOrEmpty(search?.Status))
            {
                query = query.Where(x => x.Status == search.Status);
            }
            if (search?.DvoranaId != null)
            {
                query = query.Where(x => x.DvoranaId == search.DvoranaId);
            }

            return query;
        }
    }
}
