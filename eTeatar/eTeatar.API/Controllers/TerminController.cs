﻿using Microsoft.AspNetCore.Mvc;
using eTeatar.Model;
using eTeatar.Model.Requests;
using eTeatar.Model.SearchObjects;
using eTeatar.Services;

namespace eTeatar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TerminController : BaseCRUDController<Termin, TerminSearchObject, TerminUpsertRequest, TerminUpsertRequest>
    {
        public TerminController(ITerminService service) : base(service)
        {
        }
    }
}
