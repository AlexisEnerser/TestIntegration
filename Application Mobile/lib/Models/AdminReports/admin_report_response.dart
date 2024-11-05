import 'package:zohoanalytics/Models/AdminReports/report.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';

class AdminReportResponse extends GeneralResponse{

  List<Report> reports;

  AdminReportResponse({
    required super.code, 
    required super.message,
    required this.reports
  });

  factory AdminReportResponse.fromJson(Map<String, dynamic> json) {
    return AdminReportResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      reports: List<Report>.from(json['data'].map((x) => Report.fromJson(x)))
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': reports
    };
  }
}