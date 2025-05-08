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
using eTeatar.Model;
using eTeatar.Services.RabbitMq;
using eTeatar.Services.Recommender;
using Predstava = eTeatar.Model.Predstava;

namespace eTeatar.Services
{
    public class KorisnikService : BaseCRUDService<Korisnik, KorisnikSearchObject, Database.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        private IRecommenderService recommenderService;
        private IRabbitMqService rabbitMqService;
        public KorisnikService(ETeatarContext _eTeatarContext, IMapper _mapper, IRecommenderService _recommenderService, IRabbitMqService rabbitMqService) : base(_eTeatarContext, _mapper)
        {
            this.recommenderService = _recommenderService;
            this.rabbitMqService = rabbitMqService;
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
            if (!string.IsNullOrWhiteSpace(search?.KorisnickoImeGTE))
            {
                query = query.Where(x => x.KorisnickoIme.StartsWith(search.KorisnickoImeGTE));
            }
            if (search?.UlogaId != null )
            {
                query = query.Include(x => x.KorisnikUlogas).ThenInclude(x => x.Uloga).Where(x=>x.KorisnikUlogas.Any(ku=>ku.UlogaId==search.UlogaId));
            }
            if (search?.isDeleted != null)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
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
            var entitet = Context.Korisniks.FirstOrDefault(x => x.KorisnickoIme == request.KorisnickoIme);
            if (entitet != null)
            {
                throw new UserException("Korisnicko ime je zauzeto!");
            }
            var lozinka = GenerateRandomString(8);

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, lozinka);
            entity.DatumRegistracije = DateTime.Now;
            rabbitMqService.SendEmail(new MailDTO()
            {
                EmailTo = entity.Email,
                Message = $"Poštovani, <br>" +
                          $"{entity.Ime} {entity.Prezime} <br>" +
                          $"Korisnicko ime: {entity.KorisnickoIme}<br>" +
                          $"Lozinka: {lozinka}<br><br>" +
                          $"Lijep pozdrav",
                ReceiverName = entity.Ime + " " + entity.Prezime,
                Subject = "Registracija na aplikaciji"
            });
            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(KorisnikUpdateRequest request, Database.Korisnik entity)
        {

            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new UserException("Lozinke se ne podudaraju!");
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
        public string GenerateRandomString(int size)
        {
            // Characters except I, l, O, 1, and 0 to decrease confusion when hand typing tokens
            var charSet = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@_-$#";
            var chars = charSet.ToCharArray();
            var data = new byte[1];
#pragma warning disable SYSLIB0023 // Type or member is obsolete
            var crypto = new RNGCryptoServiceProvider();
#pragma warning restore SYSLIB0023 // Type or member is obsolete
            crypto.GetNonZeroBytes(data);
            data = new byte[size];
            crypto.GetNonZeroBytes(data);
            var result = new StringBuilder(size);
            foreach (var b in data)
            {
                result.Append(chars[b % (chars.Length)]);
            }

            return result.ToString();
        }

        public Korisnik Login(string username, string password)
        {
            var entity = Context
                .Korisniks
                .Include(x => x.KorisnikUlogas)
                .ThenInclude(y => y.Uloga)
                .FirstOrDefault(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return Mapper.Map<Korisnik>(entity);

        }

        public List<Predstava> Recommend(int korisnikId)
        {
            var predstave = recommenderService.getRecommendedPredstave(korisnikId);
            return predstave;
        }

        public void TrainData()
        {
            recommenderService.TrainData();
        }
    }
}
