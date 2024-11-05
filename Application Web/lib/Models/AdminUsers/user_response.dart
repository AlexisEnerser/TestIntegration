import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';

class UserResponse extends GeneralResponse{

  List<User> users;

  UserResponse({
    required super.code, 
    required super.message,
    required this.users
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      users: List<User>.from(json['data'].map((x) => User.fromJson(x)))
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': users
    };
  }
}