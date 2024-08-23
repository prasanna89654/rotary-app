class CalendarEventModel {
  String id;
  String title;
  String location;
  DateTime date;

  CalendarEventModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.location});

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
        id: json['id'] as String,
        title: json['title'] as String,
        location: json['location'] as String,
        date: DateTime.parse(json['date']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
      };
}
