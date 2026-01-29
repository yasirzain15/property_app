class ProfileResponseModel {
  bool? success;
  String? message;
  int? status;
  ProfileData? data;

  ProfileResponseModel({this.success, this.message, this.status, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? nic;
  String? fOrHName;
  String? email;
  String? mobileNo;
  String? gender;
  String? dob;
  String? profileImage;
  List<CustomerAddress>? customerAddresses;
  List<CustomerDocument>? customerDocuments;

  ProfileData({
    this.id,
    this.name,
    this.nic,
    this.fOrHName,
    this.email,
    this.mobileNo,
    this.gender,
    this.dob,
    this.profileImage,
    this.customerAddresses,
    this.customerDocuments,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nic = json['nic'];
    fOrHName = json['f_or_h_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    gender = json['gender'];
    dob = json['dob'];
    profileImage = json['profile_image'];

    if (json['customer_addresses'] != null) {
      customerAddresses = <CustomerAddress>[];
      json['customer_addresses'].forEach((v) {
        customerAddresses!.add(CustomerAddress.fromJson(v));
      });
    }

    if (json['customer_documents'] != null) {
      customerDocuments = <CustomerDocument>[];
      json['customer_documents'].forEach((v) {
        customerDocuments!.add(CustomerDocument.fromJson(v));
      });
    }
  }
}

class CustomerAddress {
  String? address;

  CustomerAddress({this.address});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }
}

class CustomerDocument {
  String? filePath;

  CustomerDocument({this.filePath});

  CustomerDocument.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }
}
