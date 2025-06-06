﻿using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class UplataService : BaseCRUDService<Model.Uplata, UplataSearchObject, Database.Uplatum, UplataInsertRequest, UplataUpdateRequest>, IUplataService
    {
        public UplataService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {

        }

        public override IQueryable<Uplatum> AddFilter(UplataSearchObject search, IQueryable<Uplatum> query)
        {
            query = base.AddFilter(search, query);
            if (search?.Iznos != null)
            {
                query = query.Where(x => x.Iznos == search.Iznos);
            }
            if (search?.KorisnikId != null)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }

            return query;
        }

        public override void BeforeInsert(UplataInsertRequest request, Uplatum entity)
        {
            entity.Datum = DateTime.Now;
        }
    }
}
