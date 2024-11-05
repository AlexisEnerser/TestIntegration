import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:js' as js;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import '../Models/Access/LoginComplementRequest.dart';
import '../Models/Access/LoginResponse.dart';
import '../Models/GeneralResponse.dart';
import '../constants.dart';
import '../Models/Access/LoginRequest.dart';

Future<LoginResponse> makeLogin({required LoginRequest loginRequest}) async {
  final params = loginRequest.toMap();
  final url = Uri.parse('$urlBase/user/login').replace(queryParameters: params);
  LoginComplementRequest complementRequest = LoginComplementRequest(
    platform: "WEB",
    device: js.context['navigator']['userAgent'],
    ipAddress: await getIP()
  );
  try {
    final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(complementRequest)
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      GeneralResponse temporal = GeneralResponse.fromJson(parsed);
      if(temporal.code!=1){
        return LoginResponse(code: temporal.code,message: temporal.message);
      }
      token = temporal.message;
      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      return LoginResponse(
        code: 1,
        message: "success",
        data: UserInfoResponseData.fromJwt(json.decode(decoded))
      );
    } else {
      return LoginResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return LoginResponse(code: -1,message:'Error occurred: $e');
  }
}

Future<String> getIP()async{
  try {
    var response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  } catch (exception) {
    return "";
  }
}

Future<GeneralResponse> makeRecoveryPassword({required String userName}) async {
  final url = Uri.parse('$urlBase/user/recoveryPassword?userName=$userName');
  try {
    final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }
    );
    final status = response.statusCode;
    if (status == 200) {
      final Map<String,dynamic> parsed = json.decode(response.body);
      return GeneralResponse.fromJson(parsed);
    } else {
      return GeneralResponse(code: -1,message:'HTTP GET error: Status code = $status');
    }
  } catch (e) {
    return GeneralResponse(code: -1,message:'Error occurred: $e');
  }
}