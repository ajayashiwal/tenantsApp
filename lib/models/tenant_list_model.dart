class TenantListModel {
  int? status;
  String? message;
  List<Data>? data;

  TenantListModel({this.status, this.message, this.data});

  TenantListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic representative;
  dynamic profileImage;
  dynamic firstName;
  dynamic lastName;
  dynamic projectCode;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic type;
  dynamic phone;
  dynamic countryCode;
  dynamic addressData;
  dynamic buildingNumber;
  dynamic apartmentNumber;
  dynamic city;
  dynamic country;
  dynamic streetName;
  dynamic lastSeen;
  dynamic isLogin;
  dynamic device;
  dynamic applicationVersion;
  dynamic oneSignalId;
  dynamic associated;
  dynamic googleId;
  dynamic facebookId;
  dynamic appleId;
  dynamic deletedAt;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.representative,

        this.profileImage,
        this.firstName,
        this.lastName,
        this.projectCode,
        this.email,
        this.emailVerifiedAt,
        this.status,
        this.type,
        this.phone,
        this.countryCode,
        this.addressData,
        this.buildingNumber,
        this.apartmentNumber,
        this.city,
        this.country,
        this.streetName,
        this.lastSeen,
        this.isLogin,
        this.device,
        this.applicationVersion,
        this.oneSignalId,
        this.associated,
        this.googleId,
        this.facebookId,
        this.appleId,
        this.deletedAt,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    representative = json['representative'];

    profileImage = json['profile_image'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    projectCode = json['project_code'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    type = json['type'];
    phone = json['phone'];
    countryCode = json['country_code'];
    addressData = json['addressData'];
    buildingNumber = json['building_number'];
    apartmentNumber = json['apartment_number'];
    city = json['city'];
    country = json['country'];
    streetName = json['street_name'];
    lastSeen = json['lastSeen'];
    isLogin = json['isLogin'];
    device = json['device'];
    applicationVersion = json['applicationVersion'];
    oneSignalId = json['oneSignalId'];
    associated = json['associated'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
    deletedAt = json['deleted_at'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['representative'] = representative;

    data['profile_image'] = profileImage;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['project_code'] = projectCode;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['type'] = type;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['addressData'] = addressData;
    data['building_number'] = buildingNumber;
    data['apartment_number'] = apartmentNumber;
    data['city'] = city;
    data['country'] = country;
    data['street_name'] = streetName;
    data['lastSeen'] = lastSeen;
    data['isLogin'] = isLogin;
    data['device'] = device;
    data['applicationVersion'] = applicationVersion;
    data['oneSignalId'] = oneSignalId;
    data['associated'] = associated;
    data['google_id'] = googleId;
    data['facebook_id'] = facebookId;
    data['apple_id'] = appleId;
    data['deleted_at'] = deletedAt;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}