using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using MimeKit;
using MailKit.Net.Smtp;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace eTeatar.Subscriber
{
    public class MailSender
    {
        public static async Task SendEmail(MailDTO mailObj)
        {
            if (mailObj == null) return;

            string fromAddress = Environment.GetEnvironmentVariable("SMTP_USER") ?? "eteatar.rs2@gmail.com";
            string password = Environment.GetEnvironmentVariable("SMTP_PASS") ?? string.Empty;
            string host = Environment.GetEnvironmentVariable("SMTP_HOST") ?? "smtp.gmail.com";
            int port = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "465");
            bool enableSSL = bool.Parse(Environment.GetEnvironmentVariable("ENABLE_SSL") ?? "true");
            string displayName = Environment.GetEnvironmentVariable("_displayName") ?? "no-reply";
            int timeout = int.Parse(Environment.GetEnvironmentVariable("_timeout") ?? "255");
            Console.WriteLine($"Usli smo u metodu prije password: {password}");
            if (password == string.Empty)
            {
                Console.WriteLine("Sifra je prazna");
                return;
            }

            var email = new MimeMessage();

            email.From.Add(new MailboxAddress(displayName, fromAddress));
            email.To.Add(new MailboxAddress(mailObj.ReceiverName, mailObj.EmailTo));

            email.Subject = mailObj.Subject;

            email.Body = new TextPart(MimeKit.Text.TextFormat.Html)
            {
                Text = mailObj.Message
            };

            try
            {
                Console.WriteLine($"Sent email from {fromAddress} to {mailObj.EmailTo}, via port: {port}, at {DateTime.Now}");
                using (var smtp = new SmtpClient())
                {
                    await smtp.ConnectAsync(host, port, enableSSL);
                    await smtp.AuthenticateAsync(fromAddress, password);

                    await smtp.SendAsync(email);
                    await smtp.DisconnectAsync(true);
                }
                Console.WriteLine("Uspjesno poslata poruka");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error {ex.Message}");
                return;
            }
        }
    }
}
