class BusinessAdsModel {
  int? id;
  int? classificationId;
  String? title;
  String? image;
  String? url;
  String? page;
  String? location;
  int? numberOfDays;
  int? status;
  String? activeFrom;
  String? expireAt;
  String? createdAt;
  String? updatedAt;
  Classification? classification;

  BusinessAdsModel(
      {this.id,
      this.classificationId,
      this.title,
      this.image,
      this.url,
      this.page,
      this.location,
      this.numberOfDays,
      this.status,
      this.activeFrom,
      this.expireAt,
      this.createdAt,
      this.updatedAt,
      this.classification});

  BusinessAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classificationId = json['classification_id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    page = json['page'];
    location = json['location'];
    numberOfDays = json['number_of_days'];
    status = json['status'];
    activeFrom = json['active_from'];
    expireAt = json['expire_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classification = json['classification'] != null
        ? new Classification.fromJson(json['classification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classification_id'] = this.classificationId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    data['page'] = this.page;
    data['location'] = this.location;
    data['number_of_days'] = this.numberOfDays;
    data['status'] = this.status;
    data['active_from'] = this.activeFrom;
    data['expire_at'] = this.expireAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.classification != null) {
      data['classification'] = this.classification!.toJson();
    }
    return data;
  }
}

class Classification {
  String? name;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Classification(
      {this.name, this.image, this.status, this.createdAt, this.updatedAt});

  Classification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}