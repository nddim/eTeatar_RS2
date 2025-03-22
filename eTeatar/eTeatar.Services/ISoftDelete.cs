using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eTeatar.Services
{
    public interface ISoftDelete
    {
        public bool IsDeleted { get; set; }

        public DateTime? VrijemeBrisanja { get; set; }
    }
}
