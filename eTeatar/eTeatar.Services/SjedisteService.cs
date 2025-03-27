using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Sjediste = eTeatar.Services.Database.Sjediste;

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
            if (search?.Status != null)
            {
                query = query.Where(x => x.Status == search.Status);
            }
            if (search?.DvoranaId != null)
            {
                query = query.Where(x => x.DvoranaId == search.DvoranaId);
            }

            return query;
        }

        public override void BeforeInsert(SjedisteUpsertRequest request, Sjediste entity)
        {
            var sjediste = Context.Sjedistes.Where(x => x.Red == request.Red && x.Kolona == request.Kolona && x.DvoranaId == request.DvoranaId)?.FirstOrDefault();
            if (sjediste != null)
            {
                throw new UserException("Već postoji sjediste s tim redom i kolonom u dvorani!");
            }
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(SjedisteUpsertRequest request, Sjediste entity)
        {
            var sjediste = Context.Sjedistes.Where(x => x.Red == request.Red && x.Kolona == request.Kolona && x.DvoranaId == request.DvoranaId)?.FirstOrDefault(); ;
            if (sjediste != null)
            {
                throw new UserException("Već postoji sjediste s tim redom i kolonom u dvorani!");
            }
            base.BeforeUpdate(request, entity);
        }
    }
}
