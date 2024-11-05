class AdminReportUpdateRequest {
  int id;
  String name;
  String url;
  int reportTypeId;
  int statusId;

  AdminReportUpdateRequest({
    this.id = 0,
    this.name = '',
    this.url = '',
    this.reportTypeId = 0,
    this.statusId = 0,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'report_type_id': reportTypeId,
      'status_id': statusId,
    };
  }
}