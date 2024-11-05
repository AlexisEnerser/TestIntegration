import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zohoanalytics/Models/AdminReports/admin_report_create_request.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_response.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_update_request.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'package:zohoanalytics/Models/Reports/ReportResponse.dart';
import '../constants.dart';

Future<GeneralResponse> createReportService({required AdminReportCreateRequest data}) async {
  final url = Uri.parse('$urlBase/create/report');
  try {
    final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(data)
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return GeneralResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GeneralResponse(code: 401,message:'HTTP GET error: Status code = $status');
    }
    else {
      return GeneralResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return GeneralResponse(code: -1,message:'Error occurred: $e');
  }
}

Future<GeneralResponse> updateReportService({required AdminReportUpdateRequest data}) async {
  final url = Uri.parse('$urlBase/update/report');
  try {
    final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(data)
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return GeneralResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GeneralResponse(code: 401,message:'HTTP GET error: Status code = $status');
    }
    else {
      return GeneralResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return GeneralResponse(code: -1,message:'Error occurred: $e');
  }
}

Future<AdminReportResponse> consultAllReports() async {
  final url = Uri.parse('$urlBase/all/reports');
  try {
    final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        }
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return AdminReportResponse.fromJson(parsed);
    }
    else if(status == 401){
      return AdminReportResponse(code: 401,message:'HTTP GET error: Status code = $status',reports: []);
    }
    else {
      return AdminReportResponse(code: -1,message:'HTTP GET error: Status code = $status',reports: []);
    }
  } catch (e) {
    return AdminReportResponse(code: -1,message:'Error occurred: $e',reports: []);
  }
}

Future<ReportResponse> consultUserReports() async {
  final url = Uri.parse('$urlBase/user/reports');
  try {
    final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        }
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return ReportResponse.fromJson(parsed);
    }
    else if(status == 401){
      return ReportResponse(code: 401,message:'HTTP GET error: Status code = $status',myReports: [],groupReports: [],favoriteReports: []);
    }
    else {
      return ReportResponse(code: -1,message:'HTTP GET error: Status code = $status',myReports: [],groupReports: [],favoriteReports: []);
    }
  } catch (e) {
    return ReportResponse(code: -1,message:'Error occurred: $e',myReports: [],groupReports: [],favoriteReports: []);
  }
}

Future<GeneralResponse> setFavoriteReport(String reportId) async {
  final url = Uri.parse('$urlBase/set/favorite?reportId=$reportId');
  try {
    final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        }
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return GeneralResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GeneralResponse(code: 401,message:'HTTP GET error: Status code = $status');
    }
    else {
      return GeneralResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return GeneralResponse(code: -1,message:'Error occurred: $e');
  }
}

Future<GeneralResponse> deleteFavoriteReports(String reportId) async {
  final url = Uri.parse('$urlBase/delete/favorite?reportId=$reportId');
  try {
    final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        }
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return GeneralResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GeneralResponse(code: 401,message:'HTTP GET error: Status code = $status');
    }
    else {
      return GeneralResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return GeneralResponse(code: -1,message:'Error occurred: $e');
  }
}

Future<void> saveRecordReport(int reportId) async {
  final url = Uri.parse('$urlBase/save/record/report?reportId=$reportId');
  try {
    await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token,
      }
    );
  } 
  catch (e) {}
}