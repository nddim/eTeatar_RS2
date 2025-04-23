﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eTeatar.Services.Database
{
    internal interface ISoftDelete
    {
        public bool IsDeleted { get; set; }
        public DateTime? VrijemeBrisanja { get; set; }

        public void Undo()
        {
            IsDeleted = false;
            VrijemeBrisanja = null;
        }
    }
}
