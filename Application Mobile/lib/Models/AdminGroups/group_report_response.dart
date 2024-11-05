import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'package:zohoanalytics/Models/Reports/ReportResponse.dart';

class GroupReportResponse extends GeneralResponse{
  List<ReportResponseData> reports;

  GroupReportResponse({
    required super.code, 
    required super.message,
    required this.reports
  });

  factory GroupReportResponse.fromJson(Map<String, dynamic> json) {
    return GroupReportResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      reports: List<ReportResponseData>.from(json['data'].map((x) => ReportResponseData.fromJson(x)))
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