import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'group.dart';

class GroupResponse extends GeneralResponse{

  List<Group> groups;

  GroupResponse({
    required super.code, 
    required super.message,
    required this.groups
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    return GroupResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      groups: List<Group>.from(json['data'].map((x) => Group.fromJson(x)))
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': groups
    };
  }
}