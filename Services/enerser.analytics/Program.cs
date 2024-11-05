using enerser.analytics.DataBase;
using enerser.analytics.JWT;
using enerser.analytics.Services;

DotNetEnv.Env.Load();
var builder = WebApplication.CreateBuilder(args);

builder.Configuration
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddEnvironmentVariables();

builder.Services.AddControllers();
builder.Services.AddCors(options =>
{
    options.AddPolicy(
        "AllowSpecificOrigin",
        builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        }
    );
});

builder.Services.AddHttpClient();

builder.Services.AddSingleton<UserDB>();
builder.Services.AddSingleton<ReportDB>();
builder.Services.AddSingleton<GroupDB>();

builder.Services.AddSingleton<UserServices>();
builder.Services.AddSingleton<ReportServices>();
builder.Services.AddSingleton<GroupServices>();

builder.Services.AddSingleton(provider => new JwtService("Enermnjhbvgfcrdexcfrvgbhnjmhgvfrcvgbhnyv234dfg", "zoho_issuer"));

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
var config = app.Configuration;
config["ProyectConfiguration:ZohoAnalitycs:db"] = DotNetEnv.Env.GetString("db_connection");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowSpecificOrigin");
app.UseAuthorization();
app.MapControllers();
await app.RunAsync();