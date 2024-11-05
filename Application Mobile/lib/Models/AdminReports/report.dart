class Report {
  int id;
  String name;
  String url;
  int reportTypeId;
  String reportType;
  int statusId;
  String status;

  Report({
    this.id = 0,
    this.name = '',
    this.url = '',
    this.reportTypeId = 0,
    this.reportType = '',
    this.statusId = 0,
    this.status = '',
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      reportTypeId: json['report_type_id'] ?? 0,
      reportType: json['report_type'] ?? '',
      statusId: json['status_id'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'report_type_id': reportTypeId,
      'report_type': reportType,
      'status_id': statusId,
      'status': status,
    };
  }
}
