
class ProjectStagesModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProjectStagesModel({this.status, this.message, this.data});

  ProjectStagesModel.fromJson(Map<String, dynamic> json) {
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
  List<Stages>? stages;
  dynamic projectName;
  dynamic messages;
  List<TaskInProgress>? taskInProgress;
  List<FutureTasks>? futureTasks;
  List<CloseTasks>? closeTasks;

  Data(
      {this.stages,
        this.projectName,
        this.messages,
        this.taskInProgress,
        this.futureTasks,
        this.closeTasks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(Stages.fromJson(v));
      });
    }
    projectName = json['project_name'];
    messages = json['messages'];
    if (json['taskInProgress'] != null) {
      taskInProgress = <TaskInProgress>[];
      json['taskInProgress'].forEach((v) {
        taskInProgress!.add(TaskInProgress.fromJson(v));
      });
    }
    if (json['futureTasks'] != null) {
      futureTasks = <FutureTasks>[];
      json['futureTasks'].forEach((v) {
        futureTasks!.add(FutureTasks.fromJson(v));
      });
    }
    if (json['closeTasks'] != null) {
      closeTasks = <CloseTasks>[];
      json['closeTasks'].forEach((v) {
        closeTasks!.add(CloseTasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stages != null) {
      data['stages'] = stages!.map((v) => v.toJson()).toList();
    }
    data['project_name'] = projectName;
    data['messages'] = messages;
    if (taskInProgress != null) {
      data['taskInProgress'] =
          taskInProgress!.map((v) => v.toJson()).toList();
    }
    if (futureTasks != null) {
      data['futureTasks'] = futureTasks!.map((v) => v.toJson()).toList();
    }
    if (closeTasks != null) {
      data['closeTasks'] = closeTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stages {
  dynamic id;
  dynamic projectId;
  dynamic status;
  dynamic stageId;
  dynamic startDate;
  dynamic endDate;
  dynamic orderNo;
  dynamic createdAt;
  dynamic updatedAt;
  Stage? stage;

  Stages(
      {this.id,
        this.projectId,
        this.status,
        this.stageId,
        this.startDate,
        this.endDate,
        this.orderNo,
        this.createdAt,
        this.updatedAt,
        this.stage});

  Stages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    status = json['status'];
    stageId = json['stage_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    orderNo = json['order_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stage = json['stage'] != null ? Stage.fromJson(json['stage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['status'] = status;
    data['stage_id'] = stageId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['order_no'] = orderNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (stage != null) {
      data['stage'] = stage!.toJson();
    }
    return data;
  }
}

class Stage {
  dynamic id;
  dynamic name;
  dynamic responsibility;
  dynamic image;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;

  Stage(
      {this.id,
        this.name,
        this.responsibility,
        this.image,
        this.description,
        this.createdAt,
        this.updatedAt});

  Stage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    responsibility = json['responsibility'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['responsibility'] = responsibility;
    data['image'] = image;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TaskInProgress {
  dynamic id;
  dynamic projectId;
  dynamic taskType;
  dynamic taskId;
  dynamic startDate;
  dynamic endDate;
  dynamic contractorId;
  dynamic laywerId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic completeUsersCount;
  List<Contractors>? contractors;
  List<Lawyer>? lawyers;
  Task? task;
  CompleteStatus? completeStatus;
  List<CompleteUsers>? completeUsers;

  TaskInProgress(
      {this.id,
        this.projectId,
        this.taskType,
        this.taskId,
        this.startDate,
        this.endDate,
        this.contractorId,
        this.laywerId,
        this.createdAt,
        this.updatedAt,
        this.completeUsersCount,
        this.contractors,
        this.lawyers,
        this.task,
        this.completeStatus,
        this.completeUsers});

  TaskInProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    taskType = json['task_type'];
    taskId = json['task_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    contractorId = json['contractor_id'];
    laywerId = json['laywer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    completeUsersCount = json['complete_users_count'];
    if (json['contractors'] != null) {
      contractors = <Contractors>[];
      json['contractors'].forEach((v) {
        contractors!.add(Contractors.fromJson(v));
      });
    }
    if (json['lawyers'] != null) {
      lawyers = <Lawyer>[];
      json['lawyers'].forEach((v) {
        lawyers!.add(Lawyer.fromJson(v));
      });
    }
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    completeStatus = json['complete_status'] != null
        ? CompleteStatus.fromJson(json['complete_status'])
        : null;
    if (json['complete_users'] != null) {
      completeUsers = <CompleteUsers>[];
      json['complete_users'].forEach((v) {
        completeUsers!.add(CompleteUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['task_type'] = taskType;
    data['task_id'] = taskId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['contractor_id'] = contractorId;
    data['laywer_id'] = laywerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['complete_users_count'] = completeUsersCount;
    if (contractors != null) {
      data['contractors'] = contractors!.map((v) => v.toJson()).toList();
    }
    if (lawyers != null) {
      data['lawyers'] = lawyers!.map((v) => v.toJson()).toList();
    }
    if (task != null) {
      data['task'] = task!.toJson();
    }
    if (completeStatus != null) {
      data['complete_status'] = completeStatus!.toJson();
    }
    if (completeUsers != null) {
      data['complete_users'] =
          completeUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Contractors {
  dynamic id;
  dynamic officeEmail;
  dynamic image;
  dynamic status;
  dynamic firstName;
  dynamic lastName;
  dynamic companyName;
  dynamic subTitle;
  dynamic area;
  dynamic website;
  dynamic officePhone;
  dynamic officeAddress;
  dynamic moreInfo;
  dynamic projects;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic chooseByTenantCount;

  Contractors(
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
        this.updatedAt,
        this.chooseByTenantCount});

  Contractors.fromJson(Map<String, dynamic> json) {
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
    chooseByTenantCount = json['choose_by_tenant_count'];
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
    data['choose_by_tenant_count'] = chooseByTenantCount;
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
  dynamic chooseByTenantCount;
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
        this.chooseByTenantCount,
        this.officeInfo});

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
    chooseByTenantCount = json['choose_by_tenant_count'];
    officeInfo = json['office_info'] != null
        ? OfficeInfo.fromJson(json['office_info'])
        : null;
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
    data['choose_by_tenant_count'] = chooseByTenantCount;
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
// class Lawyer {
//   dynamic id;
//   dynamic officeEmail;
//   dynamic image;
//   dynamic status;
//   dynamic firstName;
//   dynamic lastName;
//   dynamic companyName;
//   dynamic subTitle;
//   dynamic area;
//   dynamic website;
//   dynamic officePhone;
//   dynamic officeAddress;
//   dynamic moreInfo;
//   dynamic projects;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic chooseByTenantCount;
//
//   Lawyer(
//       {this.id,
//         this.officeEmail,
//         this.image,
//         this.status,
//         this.firstName,
//         this.lastName,
//         this.companyName,
//         this.subTitle,
//         this.area,
//         this.website,
//         this.officePhone,
//         this.officeAddress,
//         this.moreInfo,
//         this.projects,
//         this.createdAt,
//         this.updatedAt,
//         this.chooseByTenantCount});
//
//   Lawyer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     officeEmail = json['office_email'];
//     image = json['image'];
//     status = json['status'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     companyName = json['company_name'];
//     subTitle = json['sub_title'];
//     area = json['area'];
//     website = json['website'];
//     officePhone = json['office_phone'];
//     officeAddress = json['office_address'];
//     moreInfo = json['more_info'];
//     projects = json['projects'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     chooseByTenantCount = json['choose_by_tenant_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['office_email'] = officeEmail;
//     data['image'] = image;
//     data['status'] = status;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['company_name'] = companyName;
//     data['sub_title'] = subTitle;
//     data['area'] = area;
//     data['website'] = website;
//     data['office_phone'] = officePhone;
//     data['office_address'] = officeAddress;
//     data['more_info'] = moreInfo;
//     data['projects'] = projects;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['choose_by_tenant_count'] = chooseByTenantCount;
//     return data;
//   }
// }

class Task {
  dynamic id;
  dynamic type;
  dynamic name;
  dynamic description;
  dynamic taskCheckboxText;
  dynamic createdAt;
  dynamic updatedAt;

  Task(
      {this.id,
        this.type,
        this.name,
        this.description,
        this.taskCheckboxText,
        this.createdAt,
        this.updatedAt});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    taskCheckboxText = json['task_checkbox_text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['task_checkbox_text'] = taskCheckboxText;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CompleteStatus {
  dynamic id;
  dynamic userId;
  dynamic taskId;
  dynamic projectTaskId;
  dynamic finishDate;
  dynamic projectId;
  dynamic status;
  dynamic lawyerId;
  dynamic contractorId;
  dynamic createdAt;
  dynamic updatedAt;

  CompleteStatus(
      {this.id,
        this.userId,
        this.taskId,
        this.projectTaskId,
        this.finishDate,
        this.projectId,
        this.status,
        this.lawyerId,
        this.contractorId,
        this.createdAt,
        this.updatedAt});

  CompleteStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    taskId = json['task_id'];
    projectTaskId = json['project_task_id'];
    finishDate = json['finish_date'];
    projectId = json['project_id'];
    status = json['status'];
    lawyerId = json['lawyer_id'];
    contractorId = json['contractor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['task_id'] = taskId;
    data['project_task_id'] = projectTaskId;
    data['finish_date'] = finishDate;
    data['project_id'] = projectId;
    data['status'] = status;
    data['lawyer_id'] = lawyerId;
    data['contractor_id'] = contractorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CompleteUsers {
  dynamic id;
  dynamic userId;
  dynamic taskId;
  dynamic projectTaskId;
  dynamic finishDate;
  dynamic projectId;
  dynamic status;
  dynamic lawyerId;
  dynamic contractorId;
  dynamic createdAt;
  dynamic updatedAt;
  Tenant? tenant;

  CompleteUsers(
      {this.id,
        this.userId,
        this.taskId,
        this.projectTaskId,
        this.finishDate,
        this.projectId,
        this.status,
        this.lawyerId,
        this.contractorId,
        this.createdAt,
        this.updatedAt,
        this.tenant});

  CompleteUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    taskId = json['task_id'];
    projectTaskId = json['project_task_id'];
    finishDate = json['finish_date'];
    projectId = json['project_id'];
    status = json['status'];
    lawyerId = json['lawyer_id'];
    contractorId = json['contractor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tenant =
    json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['task_id'] = taskId;
    data['project_task_id'] = projectTaskId;
    data['finish_date'] = finishDate;
    data['project_id'] = projectId;
    data['status'] = status;
    data['lawyer_id'] = lawyerId;
    data['contractor_id'] = contractorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (tenant != null) {
      data['tenant'] = tenant!.toJson();
    }
    return data;
  }
}

class Tenant {
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

  Tenant(
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

  Tenant.fromJson(Map<String, dynamic> json) {
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

class FutureTasks {
  dynamic id;
  dynamic projectId;
  dynamic taskType;
  dynamic taskId;
  dynamic startDate;
  dynamic endDate;
  dynamic contractorId;
  dynamic laywerId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Contractors>? contractors;
  List<Lawyer>? lawyers;
  Task? task;

  FutureTasks(
      {this.id,
        this.projectId,
        this.taskType,
        this.taskId,
        this.startDate,
        this.endDate,
        this.contractorId,
        this.laywerId,
        this.createdAt,
        this.updatedAt,
        this.contractors,
        this.lawyers,
        this.task});

  FutureTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    taskType = json['task_type'];
    taskId = json['task_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    contractorId = json['contractor_id'];
    laywerId = json['laywer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contractors'] != null) {
      contractors = <Contractors>[];
      json['contractors'].forEach((v) {
        contractors!.add(Contractors.fromJson(v));
      });
    }
    if (json['lawyers'] != null) {
      lawyers = <Lawyer>[];
      json['lawyers'].forEach((v) {
        lawyers!.add(Lawyer.fromJson(v));
      });
    }
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['task_type'] = taskType;
    data['task_id'] = taskId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['contractor_id'] = contractorId;
    data['laywer_id'] = laywerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (contractors != null) {
      data['contractors'] = contractors!.map((v) => v.toJson()).toList();
    }
    if (lawyers != null) {
      data['lawyers'] = lawyers!.map((v) => v.toJson()).toList();
    }
    if (task != null) {
      data['task'] = task!.toJson();
    }
    return data;
  }
}
class CloseTasks {
  dynamic id;
  dynamic projectId;
  dynamic taskType;
  dynamic taskId;
  dynamic startDate;
  dynamic endDate;
  dynamic contractorId;
  dynamic laywerId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Contractors>? contractors;
  List<Lawyer>? lawyers;
  Task? task;

  CloseTasks(
      {this.id,
        this.projectId,
        this.taskType,
        this.taskId,
        this.startDate,
        this.endDate,
        this.contractorId,
        this.laywerId,
        this.createdAt,
        this.updatedAt,
        this.contractors,
        this.lawyers,
        this.task});

  CloseTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    taskType = json['task_type'];
    taskId = json['task_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    contractorId = json['contractor_id'];
    laywerId = json['laywer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contractors'] != null) {
      contractors = <Contractors>[];
      json['contractors'].forEach((v) {
        contractors!.add(Contractors.fromJson(v));
      });
    }
    if (json['lawyers'] != null) {
      lawyers = <Lawyer>[];
      json['lawyers'].forEach((v) {
        lawyers!.add(Lawyer.fromJson(v));
      });
    }
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['task_type'] = taskType;
    data['task_id'] = taskId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['contractor_id'] = contractorId;
    data['laywer_id'] = laywerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (contractors != null) {
      data['contractors'] = contractors!.map((v) => v.toJson()).toList();
    }
    if (lawyers != null) {
      data['lawyers'] = lawyers!.map((v) => v.toJson()).toList();
    }
    if (task != null) {
      data['task'] = task!.toJson();
    }
    return data;
  }
}