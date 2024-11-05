import '../GeneralResponse.dart';

class LoginResponse extends GeneralResponse{
  UserInfoResponseData? data;

  LoginResponse({required int code, required String message,this.data})
      : super(code: code, message: message);


  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserInfoResponseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class UserInfoResponseData {
  int userId = 0;
  String username = '';
  String userType = '';
  String email = '';
  int businessId = 0;
  int categoryId = 0;
  String business = '';
  String status = '';
  String mobileAccess = '';
  String name = '';
  String category = '';

  UserInfoResponseData({
    required this.userId,
    required this.username,
    required this.userType,
    required this.email,
    required this.businessId,
    required this.business,
    required this.status,
    required this.mobileAccess,
    required this.category,
    required this.categoryId,
    required this.name
  });

  UserInfoResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    username = json['username'] ?? '';
    userType = json['userType'] ?? '';
    email = json['email'] ?? '';
    businessId = json['businessId'] ?? 0;
    business = json['business'] ?? '';
    status = json['status'] ?? '';
    mobileAccess = json['mobileAccess'] ?? '';
    categoryId = json['userCategoryId'] ?? 0;
    category = json['userCategory'] ?? '';
    name = json['name'] ?? '';
  }

  factory UserInfoResponseData.fromJwt(Map<String, dynamic> jwtPayload) {
    return UserInfoResponseData(
      userId: int.parse(jwtPayload['userId'] ?? '0'),
      username: jwtPayload['username'] ?? '',
      email: jwtPayload['email'] ?? '',
      userType: jwtPayload['userType'] ?? '',
      businessId: int.parse(jwtPayload['businessId'] ?? '0'),
      business: jwtPayload['business'] ?? '',
      status: jwtPayload['status'] ?? '',
      categoryId: int.parse(jwtPayload['userCategoryId'] ?? '0'),
      category: jwtPayload['userCategory'] ?? '',
      name: jwtPayload['name'] ?? '',
      mobileAccess: "True"//jwtPayload['mobileAccess'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['userType'] = this.userType;
    data['email'] = this.email;
    data['businessId'] = this.businessId;
    data['business'] = this.business;
    data['status'] = this.status;
    data['mobileAccess'] = this.mobileAccess;
    return data;
  }
}