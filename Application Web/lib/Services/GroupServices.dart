import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zohoanalytics/Models/AdminGroups/add_group_report_request.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_report_response.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import '../constants.dart';

Future<GeneralResponse> createGroupService({required Group data}) async {
  final url = Uri.parse('$urlBase/create/group');
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

Future<GeneralResponse> updateGroupService({required Group data}) async {
  final url = Uri.parse('$urlBase/update/group');
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

Future<GroupResponse> consultAllGroups() async {
  final url = Uri.parse('$urlBase/all/groups');
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
      return GroupResponse.fromJson(parsed);
    }
    else if(status == 401){
      return GroupResponse(code: 401,message:'HTTP GET error: Status code = $status',groups: []);
    }
    else {
      return GroupResponse(code: -1,message:'HTTP GET error: Status code = $status',groups: []);
    }
  } catch (e) {
    return GroupResponse(code: -1,message:'Error occurred: $e',groups: []);
  }
}

Future<GroupReportResponse> consultGroupReports({required int groupId}) async {
  final url = Uri.parse('$urlBase/group/report?groupId=$groupId');
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

Future<GroupReportResponse> consultGroupNoReports({required int groupId}) async {
  final url = Uri.parse('$urlBase/group/Noreport?groupId=$groupId');
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

Future<GeneralResponse> updateGroupReports({required AddGroupReportRequest data}) async {
  final url = Uri.parse('$urlBase/update/group/reports');
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

Future<UserResponse> consultGroupUsers({required int groupId}) async {
  final url = Uri.parse('$urlBase/group/users?groupId=$groupId');
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

Future<UserResponse> consultGroupNoUsers({required int groupId}) async {
  final url = Uri.parse('$urlBase/group/Nousers?groupId=$groupId');
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

Future<GeneralResponse> updateGroupUsers({required AddGroupReportRequest data}) async {
  final url = Uri.parse('$urlBase/update/group/users');
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