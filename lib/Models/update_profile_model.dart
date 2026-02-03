class UpdateProfileResponse {
  final bool success;
  final String message;
  final int status;
  final UpdateProfileData? data;

  UpdateProfileResponse({
    required this.success,
    required this.message,
    required this.status,
    this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? UpdateProfileData.fromJson(json['data'])
          : null,
    );
  }
}

class UpdateProfileData {
  final String? name;
  final String? nic;
  final String? fOrHName;
  final String? email;
  final String? mobileNo;
  final String? gender;
  final String? dob;

  UpdateProfileData({
    this.name,
    this.nic,
    this.fOrHName,
    this.email,
    this.mobileNo,
    this.gender,
    this.dob,
  });

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) {
    return UpdateProfileData(
      name: json['name'],
      nic: json['nic'],
      fOrHName: json['f_or_h_name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      gender: json['gender'],
      dob: json['dob'],
    );
  }
}
