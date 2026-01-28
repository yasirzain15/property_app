class LoginResponseModel {
  final bool success;
  final String message;
  final int status;
  final LoginData data;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final Customer customer;
  final String token;

  LoginData({required this.customer, required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      customer: Customer.fromJson(json['customer']),
      token: json['token'],
    );
  }
}

class Customer {
  final int id;
  final String name;
  final String nic;
  final String fOrHName;
  final String email;
  final String mobileNo;
  final String? gender;
  final String? dob;
  final String? profileImage;
  final String agencyId;
  final String status;
  final String createdAt;
  final String updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.nic,
    required this.fOrHName,
    required this.email,
    required this.mobileNo,
    this.gender,
    this.dob,
    this.profileImage,
    required this.agencyId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      nic: json['nic'],
      fOrHName: json['f_or_h_name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      gender: json['gender'],
      dob: json['dob'],
      profileImage: json['profile_image'],
      agencyId: json['agency_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
