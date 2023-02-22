class AppContentModel {
  dynamic status;
  dynamic message;
  Data? data;

  AppContentModel({this.status, this.message, this.data});

  AppContentModel.fromJson(Map<String, dynamic> json) {
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
  List<AppScreen>? appScreen;
  GeneralSetting? generalSetting;

  Data({this.appScreen, this.generalSetting});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['appScreen'] != null) {
      appScreen = <AppScreen>[];
      json['appScreen'].forEach((v) {
        appScreen!.add(AppScreen.fromJson(v));
      });
    }
    generalSetting = json['generalSetting'] != null
        ? GeneralSetting.fromJson(json['generalSetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appScreen != null) {
      data['appScreen'] = appScreen!.map((v) => v.toJson()).toList();
    }
    if (generalSetting != null) {
      data['generalSetting'] = generalSetting!.toJson();
    }
    return data;
  }
}

class AppScreen {
  dynamic id;
  dynamic name;
  dynamic createdAt;
  dynamic updatedAt;
  TextClass? text;

  AppScreen({this.id, this.name, this.createdAt, this.updatedAt, this.text});

  AppScreen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    text = json['text'] != null ? TextClass.fromJson(json['text']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (text != null) {
      data['text'] = text!.toJson();
    }
    return data;
  }
}

class TextClass {
  dynamic id;
  dynamic label;
  dynamic text;
  dynamic appScreenId;
  dynamic subTitle;
  dynamic createdAt;
  dynamic updatedAt;

  TextClass(
      {this.id,
        this.label,
        this.text,
        this.appScreenId,
        this.subTitle,
        this.createdAt,
        this.updatedAt});

  TextClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    text = json['text'];
    appScreenId = json['app_screen_id'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['text'] = text;
    data['app_screen_id'] = appScreenId;
    data['sub_title'] = subTitle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class GeneralSetting {
  dynamic id;
  dynamic stars;
  dynamic officeLogo;
  dynamic favicon;
  dynamic appName;
  dynamic andriodLink;
  dynamic iosLink;
  dynamic iosLatestVersion;
  dynamic androidLatestVersion;
  dynamic diposit;
  dynamic payment;
  dynamic creater;
  dynamic termsCondition;
  dynamic messageData;
  dynamic createdAt;
  dynamic updatedAt;

  GeneralSetting(
      {this.id,
        this.stars,
        this.officeLogo,
        this.favicon,
        this.appName,
        this.andriodLink,
        this.iosLink,
        this.iosLatestVersion,
        this.androidLatestVersion,
        this.diposit,
        this.payment,
        this.creater,
        this.termsCondition,
        this.messageData,
        this.createdAt,
        this.updatedAt});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stars = json['stars'];
    officeLogo = json['office_logo'];
    favicon = json['favicon'];
    appName = json['app_name'];
    andriodLink = json['andriod_link'];
    iosLink = json['ios_link'];
    iosLatestVersion = json['ios_latest_version'];
    androidLatestVersion = json['android_latest_version'];
    diposit = json['diposit'];
    payment = json['payment'];
    creater = json['creater'];
    termsCondition = json['terms_condition'];
    messageData = json['message_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stars'] = stars;
    data['office_logo'] = officeLogo;
    data['favicon'] = favicon;
    data['app_name'] = appName;
    data['andriod_link'] = andriodLink;
    data['ios_link'] = iosLink;
    data['ios_latest_version'] = iosLatestVersion;
    data['android_latest_version'] = androidLatestVersion;
    data['diposit'] = diposit;
    data['payment'] = payment;
    data['creater'] = creater;
    data['terms_condition'] = termsCondition;
    data['message_data'] = messageData;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}