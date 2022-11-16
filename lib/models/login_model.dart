class LoginModel {
  dynamic status;
  Data? data;
  dynamic message;
  dynamic token;

  LoginModel({this.status, this.data, this.message, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}

class Data {
  dynamic id;
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
  OfficeInfo? officeInfo;

  Data(
      {this.id,
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
        this.updatedAt,
        this.officeInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    officeInfo = json['office_info'] != null
        ? OfficeInfo.fromJson(json['office_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    if (officeInfo != null) {
      data['office_info'] = officeInfo!.toJson();
    }
    return data;
  }
}

class OfficeInfo {
  dynamic id;
  dynamic userId;
  dynamic email;
  dynamic name;
  dynamic subTitle;
  dynamic area;
  dynamic website;
  dynamic phone;
  dynamic address;
  dynamic moreInfo;
  dynamic projects;
  dynamic createdAt;
  dynamic updatedAt;

  OfficeInfo(
      {this.id,
        this.userId,
        this.email,
        this.name,
        this.subTitle,
        this.area,
        this.website,
        this.phone,
        this.address,
        this.moreInfo,
        this.projects,
        this.createdAt,
        this.updatedAt});

  OfficeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    email = json['email'];
    name = json['name'];
    subTitle = json['sub_title'];
    area = json['area'];
    website = json['website'];
    phone = json['phone'];
    address = json['address'];
    moreInfo = json['more_info'];
    projects = json['projects'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['sub_title'] = subTitle;
    data['area'] = area;
    data['website'] = website;
    data['phone'] = phone;
    data['address'] = address;
    data['more_info'] = moreInfo;
    data['projects'] = projects;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}