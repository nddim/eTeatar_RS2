using eTeatar.API.Auth;
using eTeatar.API.Filters;
using eTeatar.Services;
using eTeatar.Services.Database;
using eTeatar.Services.RabbitMq;
using eTeatar.Services.Recommender;
using eTeatar.Services.RezervacijaStateMachine;
using Mapster;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IDvoranaService, DvoranaService>();
builder.Services.AddTransient<IGlumacService, GlumacService>();
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
builder.Services.AddTransient<IStavkaUplateService, StavkaUplateService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IUplataService, UplataService>();
builder.Services.AddTransient<IVijestService, VijestService>();
builder.Services.AddTransient<IZanrService, ZanrService>();

builder.Services.AddTransient<BaseRezervacijaState>();
builder.Services.AddTransient<InitialRezervacijaState>();
builder.Services.AddTransient<KreiranaRezervacijaState>();
builder.Services.AddTransient<PonistiRezervacijaState>();
builder.Services.AddTransient<OdobriRezervacijaState>();
builder.Services.AddTransient<ZavrsiRezervacijaState>();

builder.Services.AddTransient<IRabbitMqService, RabbitMqService>();
builder.Services.AddScoped<IRecommenderService, RecommenderService>();

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ExceptionFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
    {
        new OpenApiSecurityScheme
        {
            Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
        },
        new string[]{}
    } });

});

DotNetEnv.Env.Load();

var connectionString = builder.Configuration.GetConnectionString("eTeatarConnection");
builder.Services.AddDbContext<ETeatarContext>(options => 
    options.UseSqlServer(connectionString));

builder.Services.AddMapster();
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

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

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<ETeatarContext>();
    dataContext.Database.Migrate();
}

app.Run();
