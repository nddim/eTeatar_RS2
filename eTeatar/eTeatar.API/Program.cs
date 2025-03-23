using eTeatar.API.Filters;
using eTeatar.Services;
using eTeatar.Services.Database;
using Mapster;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IDvoranaService, DvoranaService>();
builder.Services.AddTransient<IGlumacService, GlumacService>();
builder.Services.AddTransient<IHranaService, HranaService>();
builder.Services.AddTransient<IKartaService, KartaService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IOcjenaService, OcjenaService>();
builder.Services.AddTransient<IPredstavaService, PredstavaService>();
builder.Services.AddTransient<IPredstavaGlumacService, PredstavaGlumacService>();
builder.Services.AddTransient<IPredstavaZanrService, PredstavaZanrService>();
builder.Services.AddTransient<IPredstavaRepertoarService, PredstavaRepertoarService>();
builder.Services.AddTransient<IRepertoarService, RepertoarService>();
builder.Services.AddTransient<IRezervacijaService, RezervacijaService>();
builder.Services.AddTransient<IRezervacijaSjedisteService, RezervacijaSjedisteService>();
builder.Services.AddTransient<ISjedisteService, SjedisteService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IUplataService, UplataService>();
builder.Services.AddTransient<IVijestService, VijestService>();
builder.Services.AddTransient<IZanrService, ZanrService>();
builder.Services.AddControllers(x =>
{
    x.Filters.Add<ExceptionFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("eTeatarConnection");
builder.Services.AddDbContext<ETeatarContext>(options => 
    options.UseSqlServer(connectionString));

builder.Services.AddMapster();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
