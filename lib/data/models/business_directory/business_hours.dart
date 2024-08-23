class BusinessHours {
  final String? businessDay;
  final String? businessTime;
  BusinessHours({this.businessDay, this.businessTime});
  factory BusinessHours.fromMap(Map<dynamic, dynamic> map) {
    return BusinessHours(
      businessDay: map['business_days'],
      businessTime: map['business_times']
    );
  }
}