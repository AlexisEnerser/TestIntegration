using Microsoft.AspNetCore.Mvc;

namespace enerser.analytics.Utils
{
    public abstract class BaseController : Controller
    {
        protected IActionResult ProcessResponse(Func<object> action)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            try
            {
                var result = action();
                return Ok(result);
            }
            catch
            {
                return StatusCode(500, "Ocurrió un error en el servidor.");
            }
        }

        protected async Task<IActionResult> ProcessResponseAsync(Func<Task<object>> action)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            try
            {
                var result = await action();
                return Ok(result);
            }
            catch
            {
                return StatusCode(500, "Ocurrió un error en el servidor.");
            }
        }
    }

}
