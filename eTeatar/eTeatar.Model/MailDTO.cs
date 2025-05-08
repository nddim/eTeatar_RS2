using System;
using System.Collections.Generic;
using System.Text;

namespace eTeatar.Model
{
    public class MailDTO
    {
        public string EmailTo { get; set; }
        public string ReceiverName { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }
    }
}
