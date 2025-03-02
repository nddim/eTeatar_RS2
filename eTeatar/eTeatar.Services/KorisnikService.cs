using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model.Requests;
using eTeatar.Services.Database;
using MapsterMapper;
using Korisnik = eTeatar.Model.Korisnik;

namespace eTeatar.Services
{
    public class KorisnikService : IKorisnikService
    {
        private ETeatarContext eTeatarContext;
        private IMapper mapper;
        public KorisnikService(ETeatarContext _eTeatarContext, IMapper _mapper)
        {
            eTeatarContext = _eTeatarContext;
            mapper = _mapper;
        } 
        public virtual List<Korisnik> GetList()
        {

            List<Korisnik> result = new List<Korisnik>();
            var list = eTeatarContext.Korisniks.ToList();

            result = mapper.Map(list, result);

            return result;
        }

        public Korisnik Insert(KorisnikInsertRequest request)
        {
            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste!");
            }

            Database.Korisnik entity = new Database.Korisnik();
            mapper.Map(request, entity);

            entity.DatumRegistracije = DateTime.Now;

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);

            eTeatarContext.Add(entity);
            eTeatarContext.SaveChanges();

            return mapper.Map<Korisnik>(entity);
        }

        public Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            var entity = eTeatarContext.Korisniks.Find(id);

            mapper.Map(request, entity);

            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste!");
                }

                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

            eTeatarContext.SaveChanges();
            return mapper.Map<Korisnik>(entity);
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
