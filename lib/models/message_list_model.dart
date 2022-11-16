class MessageListModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  MessageListModel({this.status, this.message, this.data});

  MessageListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic projectId;
  dynamic projectCode;
  dynamic messageId;
  dynamic userId;
  dynamic type;
  dynamic isRead;
  dynamic title;
  dynamic summary;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.projectId,
        this.projectCode,
        this.messageId,
        this.userId,
        this.type,
        this.isRead,
        this.title,
        this.summary,
        this.description,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    projectCode = json['project_code'];
    messageId = json['message_id'];
    userId = json['user_id'];
    type = json['type'];
    isRead = json['is_read'];
    title = json['title'];
    summary = json['summary'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['project_code'] = projectCode;
    data['user_id'] = userId;
    data['type'] = type;
    data['is_read'] = isRead;
    data['title'] = title;
    data['summary'] = summary;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}