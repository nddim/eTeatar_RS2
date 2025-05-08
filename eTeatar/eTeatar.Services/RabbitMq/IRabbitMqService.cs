namespace eTeatar.Services.RabbitMq
{
    public interface IRabbitMqService
    {
        void SendEmail(Model.MailDTO mail);
    }
}
