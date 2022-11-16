class InfoListModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  InfoListModel({this.status, this.message, this.data});

  InfoListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic title;
  dynamic description;
  dynamic files;
  dynamic fileDescription;
  dynamic projectId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic status;

  Data(
      {this.id,
        this.title,
        this.description,
        this.files,
        this.fileDescription,
        this.projectId,
        this.createdAt,
        this.updatedAt,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    files = json['files'];
    fileDescription = json['file_description'];
    projectId = json['project_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['files'] = files;
    data['file_description'] = fileDescription;
    data['project_id'] = projectId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}


