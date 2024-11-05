using Microsoft.AspNetCore.Mvc;
using enerser.analytics.JWT;
using enerser.analytics.Models;
using enerser.analytics.Models.Report;
using enerser.analytics.Services;
using enerser.analytics.Utils;

namespace enerser.analytics.Controllers
{
    [Route("")]
    public class ReportController : BaseController
    {
        private readonly ReportServices _reportServices;
        public ReportController(ReportServices reportServices)
        {
            _reportServices = reportServices;
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("create/report")]
        public IActionResult CreateReport([FromBody] AdminReportCreateRequest data)
        {
            return ProcessResponse(() => _reportServices.createReport(
                data,
                Claims.UserId(HttpContext)
            ));
        }

        [HttpPost]
        [JwtAuthentication]
        [Route("update/report")]
        public IActionResult UpdateReport([FromBody] AdminReportUpdateRequest data)
        {
            return ProcessResponse(() => _reportServices.updateReport(
                data,
                Claims.UserId(HttpContext)
            ));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("all/reports")]
        public GeneralResponse<List<Report>> ConsultAllReports()
        {
            return _reportServices.consultAllReports();
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("user/reports")]
        public ReportResponse GetUseReports()
        {
            var info = Claims.UserInfo(HttpContext);
            return _reportServices.getUseReports(info.Item1, info.Item2, info.Item3);
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("set/favorite")]
        public IActionResult SetFavoriteReports([FromQuery] string reportId)
        {
            return ProcessResponse(() => _reportServices.setFavoriteReports(
                Claims.UserId(HttpContext).ToString(),
                reportId
            ));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("delete/favorite")]
        public IActionResult DeleteFavoriteReports([FromQuery] string reportId)
        {
            return ProcessResponse(() => _reportServices.deleteFavoriteReports(
                Claims.UserId(HttpContext).ToString(),
                reportId
            ));
        }

        [HttpGet]
        [JwtAuthentication]
        [Route("save/record/report")]
        public void saveRecordReport([FromQuery] int reportId)
        {
            if (ModelState.IsValid)
            {
                _reportServices.saveRecord(
                    Claims.UserId(HttpContext), 
                    reportId
                );
            }
        }
    }
}
