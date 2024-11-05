class AdminReportCreateRequest {
  String name;
  String url;
  int reportTypeId;

  AdminReportCreateRequest({
    this.name = '',
    this.url = '',
    this.reportTypeId = 0,
  });


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'report_type_id': reportTypeId
    };
  }
}
