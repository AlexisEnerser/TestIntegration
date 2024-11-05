class User{
  int id;
  String name;
  String userName;
  int employeeNumber;
  int idUserType;
  String userType;
  int idStatus;
  String status;
  String email;
  int idUserCategory;
  String userCategory;

  User({
    this.id = 0,
    this.name = '',
    this.userName = '',
    this.employeeNumber = 0,
    this.idUserType = 0,
    this.userType = '',
    this.idStatus = 0,
    this.status = '',
    this.email = '',
    this.idUserCategory = 0,
    this.userCategory = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userName: json['user_name'] ?? '',
      employeeNumber: json['employee_number'] ?? 0,
      idUserType: json['id_user_type'] ?? 0,
      userType: json['user_type'] ?? '',
      idStatus: json['id_status'] ?? 0,
      status: json['status'] ?? '',
      email: json['email'] ?? '',
      idUserCategory: json['id_user_category'] ?? 0,
      userCategory: json['user_category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_name': userName,
      'employee_number':employeeNumber,
      'id_user_type':idUserType,
      'user_type':userType,
      'id_status':idStatus,
      'status':status,
      'email':email,
      'id_user_category':idUserCategory,
      'user_category':userCategory
    };
  }
}