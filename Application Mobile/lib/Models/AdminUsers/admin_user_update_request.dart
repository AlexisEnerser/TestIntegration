class AdminUserUpdateRequest{
  int id;
  String name;
  String password;
  int employeeNumber;
  int idUserType;
  int idStatus;
  String email;
  int idUserCategory;

  AdminUserUpdateRequest({
    this.id = 0,
    this.name = '',
    this.password = '',
    this.employeeNumber = 0,
    this.idUserType = 0,
    this.idStatus = 0,
    this.email = '',
    this.idUserCategory = 0,
  });

  factory AdminUserUpdateRequest.fromJson(Map<String, dynamic> json) {
    return AdminUserUpdateRequest(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      employeeNumber: json['employee_number'] ?? 0,
      idUserType: json['id_user_type'] ?? 0,
      idStatus: json['id_status'] ?? 0,
      email: json['email'] ?? '',
      idUserCategory: json['id_user_category'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password':password,
      'employee_number':employeeNumber,
      'id_user_type':idUserType,
      'id_status':idStatus,
      'email':email,
      'id_user_category':idUserCategory,
    };
  }
}