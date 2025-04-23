using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;
using Rezervacija = eTeatar.Model.Rezervacija;

namespace eTeatar.Services.RezervacijaStateMachine
{
    public class BaseRezervacijaState
    {
        private IServiceProvider service;
        public ETeatarContext Context { get; }
        public IMapper Mapper { get; }
        public BaseRezervacijaState(ETeatarContext context, IMapper mapper, IServiceProvider service)
        {
            Context = context;
            Mapper = mapper;
            this.service = service;
        }
        public virtual Rezervacija Insert(RezervacijaInsertRequest request)
        {
            throw new UserException("Metoda nije dozvoljena!");
        }
        public virtual Rezervacija Ponisti(int id)
        {
            throw new UserException("Metoda nije dozvoljena!");
        }
        public virtual Rezervacija Odobri(int id)
        {
            throw new UserException("Metoda nije dozvoljena!");
        }
        public virtual Rezervacija Zavrsi(int id)
        {
            throw new UserException("Metoda nije dozvoljena!");
        }
        public virtual List<string> AllowedActions(Database.Rezervacija? entity)
        {
            throw new UserException("Metoda nije dozvoljena!");
        }
        public BaseRezervacijaState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                    return service.GetService<InitialRezervacijaState>();
                case "Kreirana":
                    return service.GetService<KreiranaRezervacijaState>();
                case "Odobrena":
                    return service.GetService<OdobriRezervacijaState>();
                case "Ponistena":
                    return service.GetService<PonistiRezervacijaState>();
                case "Zavrsena":
                    return service.GetService<ZavrsiRezervacijaState>();
                default: throw new Exception("State ne postoji");
            }
        }
    }
}
