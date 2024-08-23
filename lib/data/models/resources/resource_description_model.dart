class ResourceDescriptionModel {
  String? title;
  String? short_desc;
  String? description;
  String? image;
  String? year;
  String? publish_date;
  String? download;
  int? is_downloadable;

  ResourceDescriptionModel({
    this.title,
    this.short_desc,
    this.description,
    this.image,
    this.year,
    this.publish_date,
    this.download,
    this.is_downloadable,
  });

  factory ResourceDescriptionModel.fromJson(Map<String, dynamic> json) {
    return ResourceDescriptionModel(
      title: json['title'] as String,
      short_desc: json['short_desc'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      year: json['year'] as String,
      publish_date: json['publish_date'] as String,
      download: json['download'] as String,
      is_downloadable: json['is_downloadable'] as int,
    );
  }
}
