using Microsoft.AspNetCore.Mvc;
using enerser.analytics.JWT;
using enerser.analytics.Models;
using enerser.analytics.Models.Group;
using enerser.analytics.Services;
using enerser.analytics.Utils;
using Sprache;

namespace enerser.analytics.Controllers
{
    [Route("")]
    public class GroupController : BaseController
    {
        private readonly GroupServices _groupServices;
        public GroupController(GroupServices groupServices)
        {
            _groupServices = groupServices;
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("create/group")]
        public IActionResult CreateGroup([FromBody] Group data)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            GeneralResponse resp = _groupServices.createGroup(
                data,
                Claims.UserId(HttpContext)
            );
            return Ok(resp);
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/group")]
        public IActionResult UpdateGroup([FromBody] Group data)
        {
            return ProcessResponse(() => _groupServices.updateGroup(
                data,
                Claims.UserId(HttpContext)
            ));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("all/groups")]
        public GeneralResponse<List<Group>> ConsultAllGroups()
        {
            return _groupServices.consultAllGroups(Claims.UserId(HttpContext));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("group/report")]
        public IActionResult ConsultGroupReports([FromQuery] int groupId)
        {
            return ProcessResponse(() => _groupServices.consultGroupReports(groupId));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("group/Noreport")]
        public IActionResult ConsultGroupNoReports([FromQuery] int groupId)
        {
            return ProcessResponse(() => _groupServices.consultGroupNoReports(groupId));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/group/reports")]
        public IActionResult EditGroupReports([FromBody] AddGroupReportRequest data)
        {
            return ProcessResponse(() => _groupServices.editGroupReports(data));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("group/users")]
        public IActionResult ConsultGroupUsers([FromQuery] int groupId)
        {
            return ProcessResponse(() => _groupServices.consultGroupUsers(groupId));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("group/Nousers")]
        public IActionResult ConsultGroupNoUsers([FromQuery] int groupId)
        {
            return ProcessResponse(() => _groupServices.consultGroupNoUsers(groupId));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/group/users")]
        public IActionResult EditGroupUsers([FromBody] AddGroupReportRequest data)
        {
            return ProcessResponse(() => _groupServices.editGroupUsers(data));
        }
    }
}
