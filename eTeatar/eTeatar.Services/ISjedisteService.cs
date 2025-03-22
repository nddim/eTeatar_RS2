using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
namespace eTeatar.Services
{
    public interface ISjedisteService : ICRUDService<Sjediste, SjedisteSearchObject, SjedisteUpsertRequest, SjedisteUpsertRequest>
    {
    }
}
