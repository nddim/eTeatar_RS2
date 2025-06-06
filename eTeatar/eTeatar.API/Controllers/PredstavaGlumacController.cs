﻿using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PredstavaGlumacController : BaseCRUDController<PredstavaGlumac, PredstavaGlumacSearchObject, PredstavaGlumacUpsertRequest, PredstavaGlumacUpsertRequest>
    {
        public PredstavaGlumacController(IPredstavaGlumacService service) : base(service)
        {
        }
    }
}
