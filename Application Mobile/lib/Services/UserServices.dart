import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zohoanalytics/Models/AdminGroups/add_group_report_request.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_report_response.dart';
import 'package:zohoanalytics/Models/AdminUsers/admin_user_create_request.dart';
import 'package:zohoanalytics/Models/AdminUsers/admin_user_update_request.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import '../constants.dart';

Future<GeneralResponse> createUserService({required AdminUserCreateRequest data}) async {
  final url = Uri.parse('$urlBase/create/user');
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

Future<GeneralResponse> updateUserService({required AdminUserUpdateRequest data}) async {
  final url = Uri.parse('$urlBase/update/user');
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

Future<UserResponse> consultAllUsers() async {
  final url = Uri.parse('$urlBase/all/users');
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
      return UserResponse.fromJson(parsed);
    }
    else if(status == 401){
      return UserResponse(code: 401,message:'HTTP GET error: Status code = $status',users: []);
    }
    else {
      return UserResponse(code: -1,message:'HTTP GET error: Status code = $status',users: []);
    }
  } catch (e) {
    return UserResponse(code: -1,message:'Error occurred: $e',users: []);
  }
}

Future<GroupReportResponse> consultUserReports({required int userId}) async {
  final url = Uri.parse('$urlBase/user/report?groupId=$userId');
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
      return GroupReportResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GroupReportResponse(code: 401,message:'HTTP GET error: Status code = $status',reports: []);
    }
    else {
      return GroupReportResponse(code: -1,message:'HTTP GET error: Status code = $status',reports: []);
    }
  } catch (e) {
    return GroupReportResponse(code: -1,message:'Error occurred: $e',reports: []);
  }
}

Future<GroupReportResponse> consultUserNoReports({required int userId}) async {
  final url = Uri.parse('$urlBase/user/Noreport?groupId=$userId');
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
      return GroupReportResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GroupReportResponse(code: 401,message:'HTTP GET error: Status code = $status',reports: []);
    }
    else {
      return GroupReportResponse(code: -1,message:'HTTP GET error: Status code = $status',reports: []);
    }
  } catch (e) {
    return GroupReportResponse(code: -1,message:'Error occurred: $e',reports: []);
  }
}

Future<GeneralResponse> updateUserReports({required AddGroupReportRequest data}) async {
  final url = Uri.parse('$urlBase/update/user/reports');
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