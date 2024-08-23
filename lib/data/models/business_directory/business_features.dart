class BusinessFeatures {
  final String? featureImage;
  final String? featureTitle;

  BusinessFeatures({this.featureImage, this.featureTitle});
  factory BusinessFeatures.fromJson(Map<dynamic, dynamic> json) {
    return BusinessFeatures(
      featureImage: json['feature_images'],
      featureTitle: json['feature_titles'],
    );
  }
}
