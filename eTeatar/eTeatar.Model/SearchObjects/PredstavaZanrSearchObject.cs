using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model.SearchObjects
{
    public class PredstavaZanrSearchObject : BaseSearchObject
    {
        public int? PredstavaId { get; set; } 
        public int? ZanrId { get; set; }
    }
}
