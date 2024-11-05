import '../GeneralResponse.dart';

class ReportResponse extends GeneralResponse {
  List<ReportResponseData> myReports = [];
  List<ReportResponseData> favoriteReports = [];
  List<UserGroup> groupReports = [];

  ReportResponse({
    required this.myReports,
    required this.favoriteReports,
    required this.groupReports,
    required int code, required String message,
  }): super(code: code, message: message);

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    List<ReportResponseData> myReports = List<ReportResponseData>.from(json['myReports'].map((x) => ReportResponseData.fromJson(x)));
    List<ReportResponseData> favoriteReports = List<ReportResponseData>.from(json['favoriteReports'].map((x) => ReportResponseData.fromJson(x)));
    List<UserGroup> groupReports = List<UserGroup>.from(json['groupReports'].map((x) => UserGroup.fromJson(x)));
    return ReportResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      myReports : myReports,
      favoriteReports:favoriteReports,
      groupReports:groupReports
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['myReports'] = myReports.map((e) => e.toJson()).toList();
    data['favoriteReports'] = favoriteReports.map((e) => e.toJson()).toList();
    data['groupReports'] = groupReports.map((e) => e.toJson()).toList();
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class UserGroup {
  int groupId = 0;
  String group = '';
  List<ReportResponseData> report = [];

  UserGroup({
    required this.groupId,
    required this.group,
    required this.report,
  });

  UserGroup.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'] ?? 0;
    group = json['group'] ?? '';
    report = (json['report'] as List<dynamic>? ?? [])
        .map((e) => ReportResponseData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['groupId'] = groupId;
    data['group'] = group;
    data['report'] = report.map((e) => e.toJson()).toList();
    return data;
  }
}

class ReportResponseData {
  int reportId = 0;
  String name = '';
  String url = '';
  int reportTypeId = 0;
  String reportType = '';
  bool isFavorite = false;

  ReportResponseData({
    required this.reportId,
    required this.name,
    required this.url,
    required this.reportTypeId,
    required this.reportType,
    required this.isFavorite
  });

  ReportResponseData.fromJson(Map<String, dynamic> json) {
    reportId = json['reportId'] ?? 0;
    name = json['name'] ?? '';
    url = json['url'] ?? '';
    reportTypeId = json['reportTypeId'] ?? 0;
    reportType = json['reportType'] ?? '';
    isFavorite = json['isFavorite'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['reportId'] = reportId;
    data['name'] = name;
    data['url'] = url;
    data['reportTypeId'] = reportTypeId;
    data['reportType'] = reportType;
    data['isFavorite'] = isFavorite;
    return data;
  }
}