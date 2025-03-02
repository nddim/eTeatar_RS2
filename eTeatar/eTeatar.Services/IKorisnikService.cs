using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using eTeatar.Model.Requests;

namespace eTeatar.Services
{
    public interface IKorisnikService
    {
        List<Model.Korisnik> GetList();
        Model.Korisnik Insert(KorisnikInsertRequest request);
        Model.Korisnik Update(int id, KorisnikUpdateRequest request);
    }
}
