﻿using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;

namespace eTeatar.Services
{
    public class KartaService : BaseCRUDService<Karta, KartaSearchObject, Database.Kartum, KartaInsertRequest, KartaUpdateRequest>, IKartaService
    {
        public KartaService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
        }

        public override IQueryable<Kartum> AddFilter(KartaSearchObject search, IQueryable<Kartum> query)
        {
            query = base.AddFilter(search, query);
            if (search?.CijenaLTE != null)
            {
                query = query.Where(x => x.Cijena < search.CijenaGTE);
            }
            if (search?.CijenaGTE != null)
            {
                query = query.Where(x => x.Cijena > search.CijenaGTE);
            }
            if (search?.RezervacijaId != null)
            {
                query = query.Where(x => x.RezervacijaId == search.RezervacijaId);
            }
            if (search?.KorisnikId != null)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }
            if (search?.TerminId != null)
            {
                query = query.Where(x => x.TerminId == search.TerminId);
            }

            return query;
        }

        public override void BeforeInsert(KartaInsertRequest request, Kartum entity)
        {
            var termin = Context.Termins.Find(request.TerminId);
            if(termin.Status != "Aktivan")
            {
                throw new Exception("Termin nije aktivan!");
            }

            var predstava = Context.Predstavas.FirstOrDefault(x => x.PredstavaId == termin.PredstavaId);
            if (predstava == null)
            {
                throw new UserException("Predstava nije pronađena!");
            }

            bool jeLiSjedisteZauzeto = Context.Karta.Any(x => x.TerminId == request.TerminId && x.SjedisteId == request.SjedisteId);
            if (jeLiSjedisteZauzeto)
            {
                throw new Exception("Sjedište je već zauzeto!");
            }

            entity.Cijena = predstava.Cijena;
            entity.RezervacijaId = null;

            base.BeforeInsert(request, entity);
        }

    }
}
