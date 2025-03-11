using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Korisnik = eTeatar.Model.Korisnik;
using System.Linq.Dynamic.Core;
using System.Text.RegularExpressions;

namespace eTeatar.Services
{
    public class KorisnikService : BaseCRUDService<Korisnik, KorisnikSearchObject, Database.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(ETeatarContext _eTeatarContext, IMapper _mapper) : base(_eTeatarContext, _mapper)
        {
  
        }

        public override IQueryable<Database.Korisnik> AddFilter(KorisnikSearchObject search, IQueryable<Database.Korisnik> query)
        {
            query = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.ImeGTE))
            {
                query = query.Where(x => x.Ime.StartsWith(search.ImeGTE));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeGTE))
            {
                query = query.Where(x => x.Prezime.StartsWith(search.PrezimeGTE));
            }
            if (!string.IsNullOrWhiteSpace(search?.Email))
            {
                query = query.Where(x => x.Email == search.Email);
            }
            if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme == search.KorisnickoIme);
            }
            if (search?.IsKorisnikUlogaIncluded == true)
            {
                query = query.Include(x => x.KorisnikUlogas).ThenInclude(x => x.Uloga);
            }
            if (!string.IsNullOrWhiteSpace(search?.OrderBy))
            {
                query = query.OrderBy(search.OrderBy);
            }
            int count = query.Count();
            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            return query;
        }

        public override void BeforeInsert(KorisnikInsertRequest request, Database.Korisnik entity)
        {
            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste!");
            }

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);

            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(KorisnikUpdateRequest request, Database.Korisnik entity)
        {

            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste!");
                }

                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

            base.BeforeUpdate(request, entity);
        }

        public static string GenerateSalt()
        {
            var byteArray = RandomNumberGenerator.GetBytes(16);
            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");

            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
    }
}
