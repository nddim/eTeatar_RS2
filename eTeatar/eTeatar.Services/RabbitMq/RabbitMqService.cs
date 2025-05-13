using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eTeatar.Model;
using Newtonsoft.Json;
using RabbitMQ.Client;

namespace eTeatar.Services.RabbitMq
{
    public class RabbitMqService : IRabbitMqService
    {
        public void SendEmail(MailDTO mail)
        {
            var hostname = Environment.GetEnvironmentVariable("RABBIT_MQ_HOST") ?? "rabbitmq";
            var username = Environment.GetEnvironmentVariable("RABBIT_MQ_USER") ?? "guest";
            var password = Environment.GetEnvironmentVariable("RABBIT_MQ_PASS") ?? "guest";
            var port = int.Parse(Environment.GetEnvironmentVariable("_rabbitMqPort") ?? "5672");

            Console.WriteLine($"{hostname}:{username}:{password}");
            var factory = new ConnectionFactory { HostName = hostname, UserName = username, Password = password, Port = port };
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "mail_sending",
                durable: false,
                exclusive: false,
                autoDelete: false,
                arguments: null);

            var body = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(mail));

            channel.BasicPublish(exchange: string.Empty,
                routingKey: "mail_sending",
                basicProperties: null,
                body: body);
        }
    }
}
