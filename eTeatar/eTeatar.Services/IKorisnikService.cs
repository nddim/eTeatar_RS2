using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;

namespace eTeatar.Services
{
    public interface IKorisnikService
    {
        PagedResult<Korisnik> GetList(KorisnikSearchObject searchObject);
        Model.Korisnik Insert(KorisnikInsertRequest request);
        Model.Korisnik Update(int id, KorisnikUpdateRequest request);
    }
}
