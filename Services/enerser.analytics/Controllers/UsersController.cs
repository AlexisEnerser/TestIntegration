using Microsoft.AspNetCore.Mvc;
using enerser.analytics.JWT;
using enerser.analytics.Models;
using enerser.analytics.Models.Users;
using enerser.analytics.Services;
using enerser.analytics.Models.Group;
using enerser.analytics.Utils;

namespace enerser.analytics.Controllers
{

    [Route("")]
    public class UsersController : BaseController
    {
        private readonly UserServices _userServices;
        public UsersController(UserServices userServices)
        {
            _userServices = userServices;
        }

        [HttpPost]
        [Route("user/login")]
        public  IActionResult  makeLogin([FromQuery] string userName,string password,[FromBody] LoginComplement data)
        {
            return ProcessResponse(() => _userServices.makeLogin(userName, password, data));
        }

        [HttpGet]
        [Route("user/recoveryPassword")]
        public async Task<IActionResult> getUserRecoveryPassword ([FromQuery] string userName)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            GeneralResponse response = await _userServices.userRecoveryPassword(userName);
            return Ok(response);
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("all/users")]
        public IActionResult consultAllUsers()
        {
            return ProcessResponse(() => _userServices.consultAllUsers(Claims.UserId(HttpContext)));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("create/user")]
        public IActionResult createUser([FromBody] AdminUserCreateRequest data)
        {
            return ProcessResponse(() => _userServices.createUser(data, Claims.UserId(HttpContext)));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/user")]
        public IActionResult updateUser([FromBody] AdminUserUpdateRequest data)
        {
            return ProcessResponse(() => _userServices.updateUser(data));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("user/report")]
        public IActionResult consultGroupReports([FromQuery] int userId)
        {
            return ProcessResponse(() => _userServices.consultUserReports(userId));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("user/Noreport")]
        public IActionResult consultGroupNoReports([FromQuery] int userId)
        {
            return ProcessResponse(() => _userServices.consultUserNoReports(userId));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/user/reports")]
        public IActionResult editGroupReports([FromBody] AddGroupReportRequest data)
        {
            return ProcessResponse(() => _userServices.editUserReports(data));
        }
    }
}
