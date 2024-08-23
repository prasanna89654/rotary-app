class NewsEntity {
  NewsEntity({
    this.id,
    this.club,
    this.title,
    this.imageUrl,
    this.publishDate,
    this.description,
    this.slug,
  });

  String? id;
  String? club;
  String? title;
  String? imageUrl;
  DateTime? publishDate;
  String? description;
  String? slug;
}
