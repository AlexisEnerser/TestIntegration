class AdminUserCreateRequest{
  String name;
  String userName;
  String password;
  int employeeNumber;
  int idUserType;
  String email;
  int idUserCategory;

  AdminUserCreateRequest({
    this.name = '',
    this.userName = '',
    this.password = '',
    this.employeeNumber = 0,
    this.idUserType = 0,
    this.email = '',
    this.idUserCategory = 0,
  });

  factory AdminUserCreateRequest.fromJson(Map<String, dynamic> json) {
    return AdminUserCreateRequest(
      name: json['name'] ?? '',
      userName: json['user_name'] ?? '',
      password: json['password'] ?? '',
      employeeNumber: json['employee_number'] ?? 0,
      idUserType: json['id_user_type'] ?? 0,
      email: json['email'] ?? '',
      idUserCategory: json['id_user_category'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user_name': userName,
      'password': password,
      'employee_number':employeeNumber,
      'id_user_type':idUserType,
      'email':email,
      'id_user_category':idUserCategory,
    };
  }
}