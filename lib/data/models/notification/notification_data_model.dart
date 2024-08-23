class NotificationDataModel {
  String? id;
  String? title;
  String? location;
  String? date;
  String? description;
  String? filePath;
  String? fileType;

  NotificationDataModel(
      {this.id,
      this.title,
      this.location,
      this.date,
      this.description,
      this.filePath,
      this.fileType});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    description = json['description'];
    filePath = json['file_path'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['date'] = this.date;
    data['description'] = this.description;
    data['file_path'] = this.filePath;
    data['file_type'] = this.fileType;
    return data;
  }
}
