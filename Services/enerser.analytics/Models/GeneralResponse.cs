namespace enerser.analytics.Models
{
    public class GeneralResponse
    {
        public int code { get; set; } = new int();
        public string message { get; set; } = string.Empty;
    }

    public class GeneralResponse<T> where T : class, new()
    {
        public int code { get; set; } = new int();
        public string message { get; set; } = string.Empty;
        public T? data { get; set; } = new T();
    }
}
