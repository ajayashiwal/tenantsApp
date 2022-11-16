// ignore: camel_case_types
class LawyerContactListModel {
  dynamic status;
  dynamic message;
  Data? data;

  LawyerContactListModel({this.status, this.message, this.data});

  LawyerContactListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic registrationCode;
  dynamic city;
  dynamic contactPhone;
  dynamic contactName;
  dynamic contactEmail;
  dynamic status;
  dynamic contractorId;
  dynamic lawyerId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Representatives>? representatives;
  List<Contacts>? contacts;
  List<Contractor>? contractor;
  List<Lawyer>? lawyer;

  Data(
      {this.id,
        this.name,
        this.registrationCode,
        this.city,
        this.contactPhone,
        this.contactName,
        this.contactEmail,
        this.status,
        this.contractorId,
        this.lawyerId,
        this.createdAt,
        this.updatedAt,
        this.representatives,
        this.contacts,
        this.contractor,
        this.lawyer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationCode = json['registration_code'];
    city = json['city'];
    contactPhone = json['contact_phone'];
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    status = json['status'];
    contractorId = json['contractor_id'];
    lawyerId = json['lawyer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['representatives'] != null) {
      representatives = <Representatives>[];
      json['representatives'].forEach((v) {
        representatives!.add(Representatives.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(Contacts.fromJson(v));
      });
    }
    if (json['contractor'] != null) {
      contractor = <Contractor>[];
      json['contractor'].forEach((v) {
        contractor!.add(Contractor.fromJson(v));
      });
    }
    if (json['lawyer'] != null) {
      lawyer = <Lawyer>[];
      json['lawyer'].forEach((v) {
        lawyer!.add(Lawyer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['registration_code'] = registrationCode;
    data['city'] = city;
    data['contact_phone'] = contactPhone;
    data['contact_name'] = contactName;
    data['contact_email'] = contactEmail;
    data['status'] = status;
    data['contractor_id'] = contractorId;
    data['lawyer_id'] = lawyerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (representatives != null) {
      data['representatives'] =
          representatives!.map((v) => v.toJson()).toList();
    }
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    if (contractor != null) {
      data['contractor'] = contractor!.map((v) => v.toJson()).toList();
    }
    if (lawyer != null) {
      data['lawyer'] = lawyer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Representatives {
  dynamic id;
  dynamic representative;
  dynamic lastUsedProject;
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

  Representatives(
      {this.id,
        this.representative,
        this.lastUsedProject,
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

  Representatives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    representative = json['representative'];
    lastUsedProject = json['last_used_project'];
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
    data['last_used_project'] = lastUsedProject;
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

class Contacts {
  dynamic id;
  dynamic projectId;
  dynamic name;
  dynamic image;
  dynamic phone;
  dynamic email;
  dynamic fax;
  dynamic address;
  dynamic role;
  dynamic createdAt;
  dynamic updatedAt;

  Contacts(
      {this.id,
        this.projectId,
        this.name,
        this.image,
        this.phone,
        this.email,
        this.fax,
        this.address,
        this.role,
        this.createdAt,
        this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    fax = json['fax'];
    address = json['address'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['name'] = name;
    data['image'] = image;
    data['phone'] = phone;
    data['email'] = email;
    data['fax'] = fax;
    data['address'] = address;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Contractor {
  int? id;
  String? officeEmail;
  String? image;
  int? status;
  String? firstName;
  String? lastName;
  String? companyName;
  String? subTitle;
  String? area;
  String? website;
  String? officePhone;
  String? officeAddress;
  String? moreInfo;
  String? projects;
  String? createdAt;
  String? updatedAt;

  Contractor(
      {this.id,
        this.officeEmail,
        this.image,
        this.status,
        this.firstName,
        this.lastName,
        this.companyName,
        this.subTitle,
        this.area,
        this.website,
        this.officePhone,
        this.officeAddress,
        this.moreInfo,
        this.projects,
        this.createdAt,
        this.updatedAt});

  Contractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    officeEmail = json['office_email'];
    image = json['image'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyName = json['company_name'];
    subTitle = json['sub_title'];
    area = json['area'];
    website = json['website'];
    officePhone = json['office_phone'];
    officeAddress = json['office_address'];
    moreInfo = json['more_info'];
    projects = json['projects'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['office_email'] = officeEmail;
    data['image'] = image;
    data['status'] = status;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company_name'] = companyName;
    data['sub_title'] = subTitle;
    data['area'] = area;
    data['website'] = website;
    data['office_phone'] = officePhone;
    data['office_address'] = officeAddress;
    data['more_info'] = moreInfo;
    data['projects'] = projects;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Lawyer {
  dynamic id;
  dynamic representative;
  dynamic lastUsedProject;
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

  Lawyer(
      {this.id,
        this.representative,
        this.lastUsedProject,
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
        this.officeInfo
      });

  Lawyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    representative = json['representative'];
    lastUsedProject = json['last_used_project'];
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
    officeInfo = json['office_info'] != null ? OfficeInfo.fromJson(json['office_info']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['representative'] = representative;
    data['last_used_project'] = lastUsedProject;
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

  OfficeInfo({this.id, this.userId, this.email, this.name, this.subTitle, this.area, this.website, this.phone, this.address, this.moreInfo, this.projects, this.createdAt, this.updatedAt});

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

